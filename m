From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: git svn clone clone php/pear/Net_LDAP2 misses tags and branches
Date: Sun, 25 Oct 2015 09:32:48 -0600
Message-ID: <CAOc6etYvzv+MFyTXk0zU673b1GypyUbTOuiVyS35PS4ROFHztg@mail.gmail.com>
References: <20151025154325.36eddb4c@bogo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Christian Weiske <cweiske@cweiske.de>
X-From: git-owner@vger.kernel.org Sun Oct 25 16:33:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqNIG-00062i-Cu
	for gcvg-git-2@plane.gmane.org; Sun, 25 Oct 2015 16:33:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbbJYPct convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Oct 2015 11:32:49 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34360 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbbJYPct convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Oct 2015 11:32:49 -0400
Received: by padhk11 with SMTP id hk11so162639347pad.1
        for <git@vger.kernel.org>; Sun, 25 Oct 2015 08:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=VbRzAe7xiADpyBcn3Cb6npBWOvO+29HAk6vb4S7c5rU=;
        b=FlpIjtHLRQW82pvPGmtfR2yR/3OCstIlAHPnJYiekLc5JoeI84LF4Xz0/pfTT+vzqR
         zvV0lhzvrWvxEXtOK26FVAUlF1q3GkjdNB40+qLutFuZ+J5hhlJL2G282XXEkHMpXg1T
         88qprGEp1Rb+mkJn5vWPBXfImlAmbT41lbsHX7CfagBq8sgEuVmVv3y9NGukf5cPTP2e
         BlkingkKBG1pcCMFNc/GuU4qogJl85/IEAKSYCgg/gmwmEGOlU9xOPkg0MD6ZIrXDAyt
         ToHd/OX5mcDqDMCMDwfWmG0oYLxcnt+reZ1T25yx97ORJmiNu6FCyNappgf6hjp9PIVz
         p5Bw==
X-Received: by 10.68.68.143 with SMTP id w15mr17374181pbt.28.1445787168600;
 Sun, 25 Oct 2015 08:32:48 -0700 (PDT)
Received: by 10.66.149.4 with HTTP; Sun, 25 Oct 2015 08:32:48 -0700 (PDT)
In-Reply-To: <20151025154325.36eddb4c@bogo>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280156>

Using -r single-revision-number (against tha same repo), I was not
able to pull much (on that revision only the standard layout was set
up so nothing would come out for git)

Did you try with -r revision-number:HEAD?


=2E
=2E
=2E
r255572 =3D 73d7692d844ee6baae8b4b2e5fc0f07a4118d09e (refs/remotes/svn/=
trunk)
       M       package2.xml
r255574 =3D d1f380277cb6a4d096d71e3a83942bb17dabf041 (refs/remotes/svn/=
trunk)
=46ound possible branch point:
https://svn.php.net/repository/pear/packages/Net_LDAP2/trunk =3D>
https://svn.php.net/repository/pear/packages/Net_LDAP2/tags/RELEASE_2_0=
_0RC2
, 255574
=46ound branch parent: (refs/remotes/svn/tags/RELEASE_2_0_0RC2)
d1f380277cb6a4d096d71e3a83942bb17dabf041
=46ollowing parent with do_switch
       D       LICENSE
       D       tests/ldif_data/unsorted_w50_WIN.ldif
Successfully followed parent
W: -empty_dir: LICENSE
W: -empty_dir: tests/ldif_data/unsorted_w50_WIN.ldif
r255575 =3D d37158da793aee8692a6dca23870b9d2e3baaf18
(refs/remotes/svn/tags/RELEASE_2_0_0RC2)
       M       package2.xml
r255576 =3D 05d71ac6543430b119232714334b3d836d20bfc8 (refs/remotes/svn/=
trunk)
       M       package2.xml
       M       LDAP2/Entry.php
=2E
=2E
=2E


On Sun, Oct 25, 2015 at 8:43 AM, Christian Weiske <cweiske@cweiske.de> =
wrote:
> Hi,
>
>
> Using git 2.6.2 to clone an SVN repository misses out branches and ta=
gs.
>
> The clone command:
>
> $ git svn clone --trunk=3Dtrunk --tags=3Dtags --branches=3Dbranches
>   --prefix=3Dorigin/
>   https://svn.php.net/repository/pear/packages/Net_LDAP2 -r 255346
>
> The final repository's tag and branch list is empty.
>
> There are tags and branches, though - see the web interface at
> http://svn.php.net/viewvc/pear/packages/Net_LDAP2/
>
> What am I doing wrong here?
>
> --
> Regards/Mit freundlichen Gr=C3=BC=C3=9Fen
> Christian Weiske
>
> -=3D=E2=89=A1 Geeking around in the name of science since 1982 =E2=89=
=A1=3D-
