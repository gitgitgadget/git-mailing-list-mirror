From: "Ping Yin" <pkufranky@gmail.com>
Subject: Any command to simplify 'git fetch origin && git reset --hard origin/master'?
Date: Sat, 19 Jan 2008 13:22:31 +0800
Message-ID: <46dff0320801182122t1581b366yad123407aaad6326@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 19 06:23:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JG6AX-0002tj-Mg
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 06:23:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbYASFWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 00:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751684AbYASFWc
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 00:22:32 -0500
Received: from py-out-1112.google.com ([64.233.166.179]:60402 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbYASFWb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 00:22:31 -0500
Received: by py-out-1112.google.com with SMTP id u52so1891071pyb.10
        for <git@vger.kernel.org>; Fri, 18 Jan 2008 21:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=eMTxRrSEszFbacHGqfEs0N+ZQaox/JkWhEh8U345OI0=;
        b=tPuJNzwo23l07uFyW1EboV8Rma1fQ21iAM+Na033o7S7WPwyD86H0Xk+QNNUTTJihxix8x88Lyh14sMB6+Hg4G7qA4srvbs5ZDWjJcuQnrbCEwXZewYZxQ9//3N8HassBgLjF40355ZI9hIYdIpLhqhJGqw55VGHxH62J61MutI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=At6xOy3SVz9gzjdbpsmUxPaTrNS7cQfyVwnNnWiUmzFW0G+Y3H0kupdOPuDxEyOasxcULtgNtEZgyDaaWen2Fzq7h6O92y0J77HBtRtD6UQBtd8T751Og6f6x2uBJI5y7j8yHAvpKhcq/wH+4CMyraSVTxeEqWjsr57m7DfBOAo=
Received: by 10.35.42.18 with SMTP id u18mr4701484pyj.58.1200720151028;
        Fri, 18 Jan 2008 21:22:31 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Fri, 18 Jan 2008 21:22:31 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71079>

I often encounter the case that the origin reposotory is rebased and i
make sure i want to use the origin head as my master
Now I have to do
$ git fetch origin && git reset --hard origin/master

Should we introduce 'git pull --force-update' or something else to do
the command combination?

-- 
Ping Yin
