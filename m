From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Compile warnings
Date: Mon, 14 Nov 2011 15:55:22 +0100
Message-ID: <op.v4xyekju0aolir@keputer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 14 15:55:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPxwe-0000SO-D0
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 15:55:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432Ab1KNOz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 09:55:27 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44337 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999Ab1KNOz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 09:55:26 -0500
Received: by eye27 with SMTP id 27so5069125eye.19
        for <git@vger.kernel.org>; Mon, 14 Nov 2011 06:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:date:subject:mime-version:content-transfer-encoding
         :from:message-id:user-agent;
        bh=mFTGSF3LcjFmbojHk7HmXZN5EGxMWMv+M4xmS/3ii30=;
        b=iMElGf3NDm8UjYT87us6ckWp7puYjIz7CcvQP3apaEYJYHt89n5DJVXac3FPdpARaz
         L1iHPDinbAAPHrzcoxCFoP+V5pOOOYeftfTnS9KXV+cm0W/vjH2qaDbYHYaUiM5+kokU
         m8cIzViZQmDxg4M8amJ2+zxLQTrmDEtJ2C1OU=
Received: by 10.213.22.211 with SMTP id o19mr531565ebb.6.1321282525072;
        Mon, 14 Nov 2011 06:55:25 -0800 (PST)
Received: from keputer (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id v3sm60597997eej.7.2011.11.14.06.55.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Nov 2011 06:55:24 -0800 (PST)
User-Agent: Opera Mail/12.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185388>

Hi,

Every now and then I see an 'unused result' warning come by during  
building. What is the general attitude towards these warnings? Remove them  
(by properly checking)? Or leave them be as a kind of documentation -- we  
know we're ignoring the info, but it's good to be reminded?

Thanks,
Frans
