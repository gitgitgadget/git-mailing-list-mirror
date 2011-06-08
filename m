From: =?ISO-8859-1?Q?J=E9r=E9mie_NIKAES?= <jeremie.nikaes@gmail.com>
Subject: Re: Git-mediawiki : Encoding problems in perl
Date: Wed, 8 Jun 2011 17:46:08 +0200
Message-ID: <BANLkTi=DLZQM_jzove_g0wLy_zgBF6Z0Xw@mail.gmail.com>
References: <BANLkTimy85b3nu05FBjXzdnTJP0RBWdxiQ@mail.gmail.com>
 <20110608150106.GB7805@sigill.intra.peff.net> <vpqhb8049m3.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, thomas@xteddy.org, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 08 17:46:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUKxl-0002a7-QA
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 17:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756391Ab1FHPq3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2011 11:46:29 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45632 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753392Ab1FHPq2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2011 11:46:28 -0400
Received: by pzk9 with SMTP id 9so302215pzk.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 08:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=1Or1SEnPeRS/dTAH0yTXwvby9Zan7fLFvKwgxB5BAWw=;
        b=WZw0A3lhnDEnwiXdJwNAb3g8eHfRL52EfczvckxLFMCM8nrhRQCCv3+6q2hPtE3IID
         Pw1BJa6XwEjgXg3Cyedj4jNps1hZfVPn3d3NB6A6QgV00iQ9YpLIaAFOwLh7C8TRBuGX
         wRYda4JU1OTwwlVPnJGJxP07aymlH6Ui3xjl4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=pqQV7qRvh/bsWZIZr38VRNvXxfEvoclmpRYpSXWMtwnbN7Oqkajee5hyvxUPjQZSDi
         GAqHyP69sQqcU5P5+BMQADTxsiP3JKDEmfRqta07IoQQPUcKLMyEXrjPXlORWsWJ2Xio
         c0TE91ZRFlEoaUFvDtIzlpDoWNx2T6sX2/tto=
Received: by 10.142.248.38 with SMTP id v38mr299775wfh.15.1307547988149; Wed,
 08 Jun 2011 08:46:28 -0700 (PDT)
Received: by 10.142.136.2 with HTTP; Wed, 8 Jun 2011 08:46:08 -0700 (PDT)
In-Reply-To: <vpqhb8049m3.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175388>

2011/6/8 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:

> open(my $git, "-|:encoding(UTF-8)", "git cat-file -p $sha1");
> my $file_content =3D <$git>;
> close($git);

Yes, that did it ! Thank you boss :-)
And thanks to both of you Peff & Steffen for your suggestions.

Although, I'm still encountering issues regarding encoding file names
though, I am going to look deeper now that i have this solution.

--=20
J=E9r=E9mie Nikaes
=C9l=E8ve ing=E9nieur en deuxi=E8me ann=E9e =E0 l'Ensimag
Ing=E9nierie des Syst=E8mes d'Informations
Tel : +33 (0)6 12 99 78 75
Mail : jeremie.nikaes@gmail.com
