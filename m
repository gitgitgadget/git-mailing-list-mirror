From: David Chanters <david.chanters@googlemail.com>
Subject: Creating CVS-style patch headers with git-diff
Date: Sat, 8 Jan 2011 11:23:06 +0000
Message-ID: <AANLkTinmq=3kJmtSVutf7dHAQ0QL3fr9_E3hZ7gDe1JY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Chanters <david.chanters@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 08 12:23:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbWtK-0001SP-UU
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 12:23:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045Ab1AHLXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jan 2011 06:23:09 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48985 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825Ab1AHLXI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jan 2011 06:23:08 -0500
Received: by fxm20 with SMTP id 20so17631445fxm.19
        for <git@vger.kernel.org>; Sat, 08 Jan 2011 03:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=/wo/65pgkByriZ3qbzptYfnCtMDi5HyZTB9c8KQFlz0=;
        b=HbuYeqqo/R1fqbvjvfF6FnIwe5GRY/XowiEkhD8YQ4YErI91d0zF5U4h5ApIIzT39e
         bxhMK5zN0jwXSM9cuT+eHOMd+CRUS/YYJJ17pxVxXjxDURGgYV/UA0uOvIioyGsQjgV5
         F4BjwJpOWRDfGxTSjkOlJazFVWMRTIo5JUVZs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=KlDm/nh5BYZWWGtW4tsmwOFO+YwA4iNbspb7oZSo9yPedgNu1BghNlkNyUFk+7OPMI
         APWC5/BirOJGTZfGk0XB7bCddF+KOIaqRTOhO3MCdFDUWDiiGKP3nUhxgKNf+pEWRCWw
         l2QrEJTdOcgqzvryVq/isFhPqnKFIKv+QR9Jg=
Received: by 10.223.83.11 with SMTP id d11mr5679028fal.37.1294485786491; Sat,
 08 Jan 2011 03:23:06 -0800 (PST)
Received: by 10.223.86.197 with HTTP; Sat, 8 Jan 2011 03:23:06 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164816>

Hi all,

[ Please Cc me on any replies as I am not subscribed to this list, thanks. ]

I am wondering if I can get git diff to create "CVS-style patches"?
What do I mean by that?  Well, whenever I do:

git diff

I get patch headers in the form:

diff --git a/foo.c b/foo.c
index 57b9527..a2d947b 100644
--- a/foo.c
+++ b/foo.c

This is fine for git, but if I then want to import the same patch into
CVS I have to either edit the patch, or mess around with the -p option
to patch(1).

I have seen that git-diff has options to change the a/ b/ headers --
can anyone shed some light on this as to what I can do?

The reason I am wanting to do this, is rather than importing
changesets from git -> CVS, I have a git clone outright of a CVS
project (which I update with git-cvsimport) and often want to import
diffs to CVS directly after I'm done, and then I publish my topic
branches in Git when I'm done.  The key thing though is to be able to
apply patches from git -- and I am hoping the easiest thing to do is
to try and get git-diff to change the headers.

Any help greatly received.

Kindly,
David
