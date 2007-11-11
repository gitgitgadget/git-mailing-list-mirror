From: "Yin Ping" <pkufranky@gmail.com>
Subject: Dose git-fetch need --reference option like git-clone?
Date: Sun, 11 Nov 2007 16:09:55 +0800
Message-ID: <46dff0320711110009y713c7d38q7b1457c92daecef6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 09:10:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir7ta-0000qE-V7
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 09:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbXKKIJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 03:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752131AbXKKIJ5
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 03:09:57 -0500
Received: from py-out-1112.google.com ([64.233.166.179]:60017 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbXKKIJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 03:09:56 -0500
Received: by py-out-1112.google.com with SMTP id u77so569055pyb
        for <git@vger.kernel.org>; Sun, 11 Nov 2007 00:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=zelJlZXRzYab4tNLYHGXrL6eNcTShtGzOa1y/VnV+0U=;
        b=pgHirPVA5txVFbzyPeG3ZPIDrwJManHM7C4Vg5Wm9UAagL0N9DRRAedjr6WQTYSaXD2eJjVKrsEjMDlMFAxoIKn5UD/0JQ99mYAIkc8f6jOf07Id0WNySh886WxfCZ40wvxvRNIiSpN6n01tKp7rWgEv0ItXuwS4bWUCwXJoE68=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HxAQknqkTm+TBh3qnM6UaGaUsyCzztl1H44ZqPnLxCqKrCE6mcC6qYiKpBlx4Sc4PYE7x4XUK+48nhu4N2FSYRvqQ995wyeiKZPLDbKXaaoS2O1SUgq8XVusGd5VYxmygWgp8YQ3WWxAIbZ9OUHlTySMoKCkClF1XI6RsghZEDM=
Received: by 10.35.99.5 with SMTP id b5mr4463350pym.1194768595683;
        Sun, 11 Nov 2007 00:09:55 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Sun, 11 Nov 2007 00:09:55 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64422>

I want to track remote repsotory (say remoteA) on my local repository
(say localB), so i do the following in directory localB
$ git remote add remoteA git://remoteAUrl
$ git fetch remoteA
This will fetch all objects from git://remoteAUrl if localB and
remoteA don't have common objects.

If I already have a cloned remoteA on local machine (say
/path/to/remoteACloned), I want to do following to reduce the net
traffic as git-clone:
git fetch --reference /path/to/remoteACloned remotedA

Is this reasonable? Or is there already a resolution for this case?

-- 
Ping Yin
