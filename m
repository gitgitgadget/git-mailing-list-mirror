From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [ANNOUNCE] Stacked Git 0.15
Date: Sun, 25 Oct 2009 17:13:03 +0000
Message-ID: <b0943d9e0910251013v19fb39b7we412e7f734c2755f@mail.gmail.com>
References: <b0943d9e0910241541n7b1091ecp6b21fa896405afa0@mail.gmail.com>
	 <m34opoe5t6.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 18:13:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N26eY-0001mz-L5
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 18:13:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753704AbZJYRND convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Oct 2009 13:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753661AbZJYRNC
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 13:13:02 -0400
Received: from mail-bw0-f227.google.com ([209.85.218.227]:62347 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbZJYRNB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Oct 2009 13:13:01 -0400
Received: by bwz27 with SMTP id 27so1676994bwz.21
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 10:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=evE4Y1S2AO9TxsNXtJTLr/1hoWSfwtXcLwO9r9r2hOo=;
        b=KgCO5otacEG94obEzl4cQMiqcGwNFh9d0HKTYIoYU5OAPPAzwkqh18oT/J+opUaAWE
         hDnc5kFNc1+pWLyHCF5et9gPmUEqudcS1v/Y0lFTU3BM65z3dbTb0tR2mRT7pQ5gFgjU
         Z9or7qqHU4jt/i7MBfHALhJ9TIjUO7/BVjFKg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rKvzWUVPoJPu4Q9Eq0p3kbH/AirOHxHXt3ye/VMH9u7bt9IB+4F2lko9dJnvpSjPyo
         2xaHosxMgdZ0bkvpLTWmrvYKf8rCzsDT7So20X0ECCxs/XKrqw0OYnfR7OuJG9aR4uQO
         /dLHmS+Bm/i+IBmnXqmuu/8ZH2LfxWqYPUN9k=
Received: by 10.223.143.15 with SMTP id s15mr182557fau.77.1256490784043; Sun, 
	25 Oct 2009 10:13:04 -0700 (PDT)
In-Reply-To: <m34opoe5t6.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131224>

2009/10/25 Jakub Narebski <jnareb@gmail.com>:
> Catalin Marinas <catalin.marinas@gmail.com> writes:
>
>> StGit is a Python application providing functionality similar to Qui=
lt
>> (i.e. pushing/popping patches to/from a stack) on top of Git. These
>> operations are performed using Git commands, and the patches are
>> stored as Git commit objects, allowing easy merging of the StGit
>> patches into other repositories using standard Git functionality.
>>
>> =A0 Download: =A0 =A0 =A0 =A0 http://download.gna.org/stgit/stgit-0.=
15.tar.gz
>> =A0 Main repository: =A0git://repo.or.cz/stgit.git
>> =A0 Project homepage: http://www.procode.org/stgit/
>> =A0 Mailing list: =A0 =A0 git@vger.kernel.org (please use "StGit" in=
 the subject)
>> =A0 Bug tracker: =A0 =A0 =A0https://gna.org/bugs/?group=3Dstgit
>
> Is there RPM or SRPM (src.rpm) available somewhere? Or does tarball
> include *.spec file, or an rpm target?

Late last night when running my release script I realised that
setup.py no longer accepts the --prefix=3D/usr option I used for RPMs.
I'll try to build one in the next couple of days (I wasn't even sure
anyone was using it).

--=20
Catalin
