From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: feature request: git add--interactive --patch on regex-matched hunks only
Date: Sun, 24 Jul 2011 12:11:29 +0700
Message-ID: <CACsJy8B1B25DZ1yrzHq69vwgzQyM2ouTXCHb8oPRpb_cAX+JZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 24 07:12:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qkqz1-0008W7-Pr
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 07:12:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253Ab1GXFMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 01:12:01 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:59783 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135Ab1GXFMA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 01:12:00 -0400
Received: by fxd18 with SMTP id 18so7231131fxd.11
        for <git@vger.kernel.org>; Sat, 23 Jul 2011 22:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=WzZrl8LhxUIB9FqPX3hkFwhbcG1XLgxJlG4zBmVWjEQ=;
        b=vv69JYlhOlhvYwR+RicXeB/xyDAKvBud1EP1yT7kQp84Kuhk9cl4bV3GG3hzeXZIwU
         GRIzr68sf3Iyew4FvGMkuwMvMkXb+uu6sGZmLDxhpE5s2mhqrh9AYiXYntaNvqJPh2Qq
         5FtQggiV8G1THWeIsS6vugr7T1Hi5MMrD+w4E=
Received: by 10.204.145.19 with SMTP id b19mr280147bkv.192.1311484319121; Sat,
 23 Jul 2011 22:11:59 -0700 (PDT)
Received: by 10.204.59.83 with HTTP; Sat, 23 Jul 2011 22:11:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177716>

Hello Perl heroes,

Can we have "git add--interactive --patch --match=regex" where only
(splitted if possible) hunks that match regex are shown?

I've been reviewing a .po file and adding translations that I approve,
leaving the rest to be determined later. The problem with .po files is
that a lot of comment lines are changes because some translations are
moved in source code. I don't care about those comment changes and
would like to completely ignore them (even destroy them with git
checkout -p).
-- 
Duy
