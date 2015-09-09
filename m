From: =?UTF-8?B?Um9iZXJ0IE1hY2jDocSNZWs=?= <lighthunt.net@gmail.com>
Subject: Bug report: GIT PRO/Branches chapter
Date: Wed, 9 Sep 2015 13:11:46 +0700
Message-ID: <CACwN7xFG0RrCZCZiUb=h-x2svV3B6Q1U5b3=3x6r08ZZM3mPmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 09 08:14:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZYeS-0004KL-H0
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 08:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754012AbbIIGNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2015 02:13:43 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:34423 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955AbbIIGMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2015 02:12:16 -0400
Received: by ykdg206 with SMTP id g206so37209ykd.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2015 23:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=kjo/b8vlp943tswBrl1KL1my9KvFUCpozb7HwqYHoUw=;
        b=NOrwQgG7XxkF4MmDXO2+/EZ931FZxkW6SLdXqGb6f+vzy99xtf1V3Z10pD/Z6CHWkm
         7f+vUrU066icPdyxEI6YaKfyNwd+w8l38SF7eAsZV8x8H80C28Xa80oYRDUNof2WO+qy
         WcvjFvIL/JRVsE+rPWm7wmJo/ZjIXh/ZWUfOfm/wpSLy7MdipazM3NCyDgM56ZURSeuP
         ypfJmIQh00JlzXKUWK42qqSCjtNGOEKwAotmw938wCs3X2r1vihWgBQuhjd6p0wenYk0
         aZafepndkWvayNZafPoIpQUlBvyaRaP6C/I35ito07ZgWBK6HldBLI9VmgHnlIS8XWzG
         QvYg==
X-Received: by 10.170.228.193 with SMTP id u184mr3905920ykf.0.1441779135767;
 Tue, 08 Sep 2015 23:12:15 -0700 (PDT)
Received: by 10.31.147.15 with HTTP; Tue, 8 Sep 2015 23:11:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277531>

Hi,

Just reading this chapter:
https://git-scm.com/book/en/v2/Git-Branching-Branches-in-a-Nutshell

I believe that: Figure 3-9. Divergent history
(https://git-scm.com/book/en/v2/book/03-git-branching/images/advance-master.png)
does not show the final "2 branch situation" as described in the
example in this chapter. On the picture, the master and testing branch
do not point to correct commit hashes in the picture. I was thinking
for a while why they are swapped and the only conclusion I made is
that it's simply a bug in the picture as it also does not correspond
to the correct git log output in the chapter.

$ git log --oneline --decorate --graph --all
* c2b9e (HEAD, master) made other changes
| * 87ab2 (testing) made a change

I suggest to fix the picture or clarify the reason in the chapter.

Hope it helps,
Robert
