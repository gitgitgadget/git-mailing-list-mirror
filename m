From: Jack Adrian Zappa <adrianh.bsc@gmail.com>
Subject: Problem staging file
Date: Mon, 9 Nov 2015 10:17:39 -0500
Message-ID: <CAKepmajcgHQ3n9PcA86f=sjt7tLjFHQ06Fn_3MwFc1zEXGuqmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git-mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 09 16:17:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvoCX-0001dP-LK
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 16:17:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbbKIPRl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 10:17:41 -0500
Received: from mail-lf0-f49.google.com ([209.85.215.49]:34728 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbbKIPRk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2015 10:17:40 -0500
Received: by lffu14 with SMTP id u14so12432464lff.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2015 07:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=AyJi51+/bIC5LopBRzV5s3satPviYrgzQdfhg+hFRpA=;
        b=l/3DjGr0b7063iX2dYTnkPRbsz3GvMgSQ3G7g7Mnl6dzzNp7A3qKxR7Tp+xn5BqGOU
         UuJtys6HLUcFVKDJRkpGMwO849Y8LjQTX25vsBTwJO+F2ssYxuT++JRZipExkewGl0pG
         l/3sPPqNTCUkY6iUDI+Qse5pyJ1K2kSn2lEfqgsfjWQvbPpvPJ3IIr8BwZSHDJRuWgnX
         qQOZ9GEBsnJ3FRLWJWCzgZacu5A5Bxy6m0e62GhCaucuFRb1kIf9Nz/w05WwZe/oK1n5
         JnlrhFHeqPDgZw0SBfybxvVY0XZ4IgFJlNA4RxMcrLK0acuUq58GJExSpEKQpX4VL6I+
         324g==
X-Received: by 10.25.138.69 with SMTP id m66mr9329557lfd.94.1447082259252;
 Mon, 09 Nov 2015 07:17:39 -0800 (PST)
Received: by 10.25.139.6 with HTTP; Mon, 9 Nov 2015 07:17:39 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281050>

I'm using vss2git [1] which as the name suggests, converts a VSS
source control database to git.  It has had a couple of hiccups, but
for the most part I've not had too much problems that I couldn't
manually fix.... except for this one.

I have a file that refuses to be staged.  The commands are:

    git add -A
    git commit -f d:\tmp\tmp1233.tmp

To override, I've tried to manually add the file and even use the -a
switch on commit line, but no joy.  The file in question stays firmly
in the "Changes not staged for commit" section.

Anyone know why this would be the case and how to fix it?

Thanks,


A


[1] https://github.com/trevorr/vss2git
