From: Mathieu Malaterre <mathieu.malaterre@gmail.com>
Subject: error: refs/tags/2.0.9 does not point to a valid object!
Date: Mon, 18 Oct 2010 21:23:57 +0200
Message-ID: <AANLkTi=JgVhkNVu70nW7_vbqWUsS=mnJGQDVBtm-dxJD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 18 21:32:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7vR8-0007cP-JC
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 21:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933131Ab0JRTbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 15:31:45 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38807 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932134Ab0JRTbn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 15:31:43 -0400
Received: by iwn35 with SMTP id 35so429734iwn.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 12:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=ls743cT+HsgelLSKlxUEQYr8NxKhDmTVAmhWOi8uKBw=;
        b=vOy5jA1/NjW/S7m21tMVle0ZQ5Ydc/Ot0nDdaM+umC0XK9NjncOARO3DTz7UkJI+G6
         nm9sdoXKT3ZgsFpz98CWAIF0WxShNqmMucNncKfGm9HvVb1hTAM7QRPjl2no93nMWjGZ
         v2M7r+fyK055iqowXl5h76JTA0AX6bf6OswFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=Zyhc652JzcCo79vaJfy5a52/xPM8V5dUClB9FwEzwEaQPn6APVGYqRdE4nu1gAenQt
         Cge2fuh1/3bZh9fne9LiENjhdsb1Wxzl7U26lN8bzWOVBQMlTwX1d0nmyMso5+QkqMhO
         kVtpscgihnzrOLIzjrXQU4xLWeVGw1qbf5bO8=
Received: by 10.231.32.140 with SMTP id c12mr3695680ibd.90.1287430298854; Mon,
 18 Oct 2010 12:31:38 -0700 (PDT)
Received: by 10.231.17.141 with HTTP; Mon, 18 Oct 2010 12:23:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159284>

Hi there,

  I am trying to convert a SVN repository to GIT. After the conversion
I tried to do some cleanups (git plumbing):

$ git filter-branch --prune-empty -f --tree-filter 'find . -type f -a
\( -name \*.txx -o -name \*.cxx -o -name \*.h -o -name \*.dtd -o -name
\*.dtd -o -name \*.xsd -o -name \*.txt -o -name \*.rc -o -name
\*.linux \)  -exec sudo dos2unix -p {} \;' --tag-name-filter cat --
--all

  The filter ran for a couple of hours. But after the conversion I get
the following:

Initialized empty Git repository in /tmp/bla/.git/
remote: Counting objects: 59368, done.
remote: Compressing objects: 100% (25408/25408), done.
remote: Total 59368 (delta 43461), reused 44204 (delta 33809)
Receiving objects: 100% (59368/59368), 14.40 MiB | 14.27 MiB/s, done.
Resolving deltas: 100% (43461/43461), done.
error: refs/tags/2.0.9 does not point to a valid object!
error: refs/tags/2.0.8 does not point to a valid object!
error: refs/tags/2.0.7 does not point to a valid object!
error: refs/tags/2.0.6 does not point to a valid object!
error: refs/tags/2.0.5 does not point to a valid object!
error: refs/tags/2.0.4 does not point to a valid object!
error: refs/tags/2.0.16 does not point to a valid object!
error: refs/tags/2.0.15 does not point to a valid object!
error: refs/tags/2.0.14 does not point to a valid object!
error: refs/tags/2.0.13 does not point to a valid object!
error: refs/tags/2.0.12 does not point to a valid object!
error: refs/tags/2.0.11 does not point to a valid object!
error: refs/tags/2.0.10 does not point to a valid object!

  Could someone please let me know what I am doing wrong in my script
in filter-branch.

Thanks a bunch !
-- 
Mathieu
