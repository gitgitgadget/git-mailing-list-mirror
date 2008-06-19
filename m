From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: stg export fails
Date: Thu, 19 Jun 2008 09:00:44 +0530
Message-ID: <cc723f590806182030p65e737f6wcec3bada5a03d0b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Catalin Marinas" <catalin.marinas@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 05:31:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9As9-0003JY-UF
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 05:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797AbYFSDap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 23:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752422AbYFSDap
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 23:30:45 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:1492 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbYFSDao (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 23:30:44 -0400
Received: by wa-out-1112.google.com with SMTP id j37so416539waf.23
        for <git@vger.kernel.org>; Wed, 18 Jun 2008 20:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=kO9wPrUQ5nDDwZdp8ip9nivrikkKtAiTUceqXUbds38=;
        b=QTl/4w+d8jqD16bnTLsXYuRsMqgryUU7mWfmAVtu1blTqymFfW8C/RAEt5GxUG9PGC
         WBGFg1NaRrGKJD7A8KIEue3pHanczrUqUpt0kwyI/tMp/OH3/4fWAcFYgEYJl6G4/Atw
         ogeqYf+iNyJDe+LNhYVwGHdZmw6tePQDt61oE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=J/W2gsjtaVPJFXKgZA+O57z7hZQK53GRqIJYpUO8i8K+cRUVLZ8cGCTRlW5fgWDIwp
         4/WSm7xdEKwSkKmEaXUpd4DHtcHHUCLmlT8irlFD8HQ2k2Hw7oGPiyQMOLddAj8/9e32
         N0Tw6slQ3Ej0MgrugRPl0+mD/+9iXRJCGf7xU=
Received: by 10.114.151.13 with SMTP id y13mr1823304wad.148.1213846244076;
        Wed, 18 Jun 2008 20:30:44 -0700 (PDT)
Received: by 10.115.60.5 with HTTP; Wed, 18 Jun 2008 20:30:44 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85446>

[2.6.26-rc6.1-work@linux-review-ext]$ stg export -d /tmp/final/
001-ext4-bmap.patch
Checking for changes in the working directory ... done
Error: Unhandled exception:
Traceback (most recent call last):
  File "/home/kvaneesh/bin-local/stgit//lib/python2.5/site-packages/stgit/main.py",
line 278, in main
    ret = command.func(parser, options, args)
  File "/home/kvaneesh/bin-local/stgit//lib/python2.5/site-packages/stgit/commands/export.py",
line 94, in func
    patches = parse_patches(args, applied + unapplied, len(applied))
NameError: global name 'parse_patches' is not defined
[2.6.26-rc6.1-work@linux-review-ext]$
