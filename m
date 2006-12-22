From: "Pelle Svensson" <pelle2004@gmail.com>
Subject: newbie question - git-pull and local branch merge
Date: Fri, 22 Dec 2006 11:27:54 +0100
Message-ID: <6bb9c1030612220227h2dc83a78u2e31e0f4e6801412@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Dec 22 11:28:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxhd8-0006Ek-Dr
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 11:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946025AbWLVK1z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 05:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946026AbWLVK1z
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 05:27:55 -0500
Received: from py-out-1112.google.com ([64.233.166.179]:28104 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946025AbWLVK1y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 05:27:54 -0500
Received: by py-out-1112.google.com with SMTP id a29so1564023pyi
        for <git@vger.kernel.org>; Fri, 22 Dec 2006 02:27:54 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pTRtl7tDwjloErgbklrffrhcAVLSYHSgxSAiPXr3VAJpW4S/YLcVFAZS2t4aw4triesHBPmFh1cmjOUXD6hKK1VHz5m/2r35mN34i+yI7N5U/EyVHuk0CNLazDXvnCEvceYBZMV4OXZU28OMX1mVyhVAomWdAGjc5z30/myl54Q=
Received: by 10.35.79.3 with SMTP id g3mr14893886pyl.1166783274242;
        Fri, 22 Dec 2006 02:27:54 -0800 (PST)
Received: by 10.35.51.20 with HTTP; Fri, 22 Dec 2006 02:27:54 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35159>

Hi,

I'm quiet new to git and I have done this so far:

1. Installed git-1.4.4
2. pulled linus kernel tree.
3. Created a local branch 'git-checkout my stuff'
4. Edit a number of files.
5. git-commit -a
6. git-pull
7. Edit a couple more files.
8. git-pull <- Problem!

Accidentally I had 2 files not committed and one of these also
had changes in the git-pull master branch which git could
not merge automatically.

Changes has been done but I'm not fully convinced what has happen.
I see that files has been changed and the failing merge file need's
to be edit.

The really question I need answer is how can I see what changes
has been done in the master branch (the one pulled in) of the
file I suppose to merge manually. Is there no way to get out
the 2 last versions from the master branch and supply them to
KDiff3 or similarly diff program.

Also by reading the documentation I wounder what the difference is of:

- commit and check-in, seem to be same thing.
- update index-file and update the repository.

/Thanks
