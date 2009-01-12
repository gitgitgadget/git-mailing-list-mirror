From: "Ping Yin" <pkufranky@gmail.com>
Subject: "git diff --stat" doesn't show added empty file
Date: Mon, 12 Jan 2009 11:36:00 +0800
Message-ID: <46dff0320901111936h6343e51fo94750d83e95743dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 12 04:37:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMDcC-0004IU-LR
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 04:37:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204AbZALDgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 22:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752069AbZALDgD
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 22:36:03 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:42112 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbZALDgB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 22:36:01 -0500
Received: by yw-out-2324.google.com with SMTP id 9so3352812ywe.1
        for <git@vger.kernel.org>; Sun, 11 Jan 2009 19:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=lHQU3Q3ZDbryNkJGywl7rxOncOA3wN1BoKXKSym4Amw=;
        b=pilXfg7rH58cQZQzGC2IBNz6PF51W+cSeQFXn+kElOa+ZF9Ri8BXNRwLq2h3M1oMER
         u72UR+ZVkZ2Bcl5ZsRVawzm+gdKBeummf6dPdcdl09QBRgk3xYbzn2+X63chOewTIk1M
         ICs7rACzWPBOOT8n3SVbY5ecLmkUo1crbSn98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=oGxWXIO+7u+kC/KdpXT+l3bdmbMMY5zeqoZNiDcVW26HQ5zI4qbAr/mnwvnKVHWVDR
         i6TrJSZg/pf4TGuLbSS/5AWIDsW+zmqukUCpr/Hog1JF/v4PYYUGDtCZHxzzmZ8DIDdk
         vCvYFBDy2kSFdf653eRI7uXzeLNJdMnT/aEi0=
Received: by 10.100.96.9 with SMTP id t9mr14915195anb.109.1231731360264;
        Sun, 11 Jan 2009 19:36:00 -0800 (PST)
Received: by 10.100.212.13 with HTTP; Sun, 11 Jan 2009 19:36:00 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105285>

$ git --version
git version 1.6.1.9.g97c34
$ mkdir test && cd test && git init && git commit --allow-empty -m
"Initial commit"
$ touch .gitignore && git add .gitignore && git commit -m "Add empty .gitignore"
$ git diff --stat HEAD^..
 0 files changed, 0 insertions(+), 0 deletions(-)

May be the following is better?

 .gitignore |    0 +
 1 files changed, 0 insertions(+), 0 deletions(-)

Ping Yin
