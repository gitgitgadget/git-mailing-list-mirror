From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Creating something like increasing revision numbers
Date: Sun, 18 Oct 2009 11:37:04 -0400
Message-ID: <9e4733910910180837n6465af8fq83ba1aa895d649e5@mail.gmail.com>
References: <20091018144158.GA9789@gandalf.dynalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Norbert Preining <preining@logic.at>
X-From: git-owner@vger.kernel.org Sun Oct 18 17:37:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzXor-0000mn-Df
	for gcvg-git-2@lo.gmane.org; Sun, 18 Oct 2009 17:37:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754680AbZJRPhB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Oct 2009 11:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754647AbZJRPhA
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 11:37:00 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:55492 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754628AbZJRPhA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Oct 2009 11:37:00 -0400
Received: by yxe17 with SMTP id 17so3279064yxe.33
        for <git@vger.kernel.org>; Sun, 18 Oct 2009 08:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=i44HXEjWR7GxlPh+5pIAEBVhxBc7j32SzSaRYV2Pn4Y=;
        b=iGbTpE9aL6qkCxvMSbWpsEKgti2P3jSFNqgC7a4nioYm4e1P0qKCEOoF/1Dk1lcest
         JA55tw18tH0SheLMcPrAbQmaVnA0Ogbnh05RfZPwWmw9jp9oVZsM82AaAKtdc160hqs0
         x45L6fuAlriUJm/kOr3ErxbeMzAfW+mPvGU08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vrrd95yVOf4zykPhrychM09fm8ry67AuOx+DMGgdJihTqXjzdpblYvgJieGvDQH2DL
         wqfSbkpsAaRnuw1OsE+sgSXgBj1b5QaJ7LGpTLYq+FJtScqeM/w8fcc3onI/HkJDjZGF
         a+ZKSxsJuStmTx1aQKw50dnf2EzYyTYXnQb/M=
Received: by 10.101.152.27 with SMTP id e27mr3017888ano.17.1255880224565; Sun, 
	18 Oct 2009 08:37:04 -0700 (PDT)
In-Reply-To: <20091018144158.GA9789@gandalf.dynalias.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130599>

On Sun, Oct 18, 2009 at 10:41 AM, Norbert Preining <preining@logic.at> =
wrote:
> Dear all,
>
> (please Cc)
>
> I am managing some of my projects with git and I am quite happy about=
 it.
>
> There is another project I am working that is quite big, the subversi=
on
> checkout is about 14Gb. Doing svn up is a pain, it has to open tens o=
f
> thousands of files and directories traversing the whole tree, trashin=
g
> the fs cache and taking ages.
>
> My idea was to move to git, from what I read it should be more capabl=
e
> in handling these type of projects.
>
> Now, there is one show-stopper I see. From our repository we create a
> set of "packages", and the maximum of the "last-changed" revisions of
> the contained files determine the "version" of the package. This
> guarantees that any change in a file will increase the revision numbe=
r
> of the package (some tricks for removals have to be done). This is ne=
cessary
> since we are distributing the packages from servers and the version n=
umber
> pf a package determines whether it should be upgraded (well known con=
cept).
>
> Now my question, is there any way to set up something similar with gi=
t?
>
> My idea is that git - like subversion - could (if asked to) count eac=
h
> commit (global to the repository, irrelevant of the branch) and give =
it
> a version number. Since we all will use a bare repository on a server
> and pull/push from/to there, I think that something similar could be =
possible.

There is a large LKML thread discussing this....
http://lwn.net/Articles/355923/

>
> So, before I delve into more gitty-nitty conversion, let me know if
> there is any chance for that, or we should stay with subversion.
>
> Thanks a lot and all the best
>
> Norbert
>
> PS: for those interested, it is TeX Live: www.tug.org/texlive
>
> ---------------------------------------------------------------------=
----------
> Dr. Norbert Preining =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Associate Professor
> JAIST Japan Advanced Institute of Science and Technology =A0 preining=
@jaist.ac.jp
> Vienna University of Technology =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 preining@logic.at
> Debian Developer (Debian TeX Task Force) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0preining@debian.org
> gpg DSA: 0x09C5B094 =A0 =A0 =A0fp: 14DF 2E6C 0307 BE6D AD76 =A0A9C0 D=
2BF 4AA3 09C5 B094
> ---------------------------------------------------------------------=
----------
> YONKERS (n.)
> (Rare.) The combined thrill of pain and shame when being caught in
> public plucking your nostril-hairs and stuffing them into your
> side-pocket.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0--- Douglas Adams, The=
 Meaning of Liff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Jon Smirl
jonsmirl@gmail.com
