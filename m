From: Yauheni Zablotski <e.zablotski@gmail.com>
Subject: bug "$message" literal in commit message
Date: Wed, 3 Jun 2015 18:51:10 +0200
Message-ID: <CAF-5DQ+WGhHq0OZZh+90iuD1qrffcYyuprzW9m7XC6NGXPZzSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 03 18:51:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0Bsr-0000WX-7g
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 18:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756687AbbFCQvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 12:51:13 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:33765 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361AbbFCQvL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 12:51:11 -0400
Received: by labpy14 with SMTP id py14so13009077lab.0
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 09:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Fxts5JDZN+ZDorQ2ZoPjbY8FBQDwnjNqyu1T6l/upN4=;
        b=y/pl26xxV0BZo1Fa5rUJUssmumIZRqic/iCzCdhcLDfDkQ0Vbdyr5NE6AmpcUsgNa0
         aUXGOzhKETLmKkD8JF/kCr4i2s1Iy6ZLd8q0wQGZKj2efhXgMXlTztR4XZd+o9BQAML7
         BaYCLC4rLEyb4tEZRGSyCQmbcSnNoXCrKQ1Pq7TmAd+CgavCYx3nNApDe99SaWZ/RtQA
         iI/7V5gwyKnbH1vou32dU/a+tI+WJaMykyG2cOySQ/zYgTFA93LmXMOCC2EndOJBnXlc
         wEbCFL6oPdJT4v0qqJx4htimZ89Dr5+QMVETjT85PDC/lFsJHmIshCqhb47Md4bxtGAs
         LcCw==
X-Received: by 10.112.55.70 with SMTP id q6mr31713309lbp.99.1433350270139;
 Wed, 03 Jun 2015 09:51:10 -0700 (PDT)
Received: by 10.112.149.71 with HTTP; Wed, 3 Jun 2015 09:51:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270698>

Hello,

I think I found a bug(or strange behavior) in the git.
If commit message contains literal "$message" than that literal
disappears from commit message.

For example:
-------------
user@comp ~/cc $ git commit -am "1$message1"
[master (root-commit) d36a841] 1
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 1

user@comp ~/cc $ git log
commit d36a841ae25510ada80246a78225446083fcb3e1
Author: user <e.zablotski@gmail.com>
Date:   Wed Jun 3 18:21:45 2015 +0200

    file
----------------

Sorry for having disturbed you
