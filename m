From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Features from GitSurvey 2010
Date: Wed, 2 Feb 2011 00:05:55 +0700
Message-ID: <AANLkTi=oTL2_ObcyKRb7bf7ZMPZoa1BU7uNH5pJRQtVC@mail.gmail.com>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com>
 <20110129231310.GA11088@burratino> <201102011451.17456.jnareb@gmail.com> <AANLkTinPAL2rEUMe-tRGFxSQ0-gfAJvSO7WW+f+2Fd2u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 01 18:07:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkJhH-0001J6-7W
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 18:07:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755358Ab1BARGd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Feb 2011 12:06:33 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60824 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754858Ab1BARG1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Feb 2011 12:06:27 -0500
Received: by wwa36 with SMTP id 36so7257446wwa.1
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 09:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=1VsBIspLcL3xuFUamu3y5Ko4csacyc5Q+UVuFwJTTwI=;
        b=RurFqBeJnqpNqB6tzWPPrG1T2qJmkw6XzAqwoRP9KCvvdrxLSGi+FKXn8QgTaTWFxp
         GomStuPYQjKGAOqpLSmffEfR76zTaWq4dnq6lfgLT/TtdAeRe3ETTFObkmKYaYArcwBm
         fP3jAv1uL6q8T91sDQZPJ0ieE/ufkgZLsRd3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=pN947L3Oe56Xpj0XcT1fwPgULo1JxpWTrz8+E/7gn0DvyWvZU6O9lCjG5iDGiYb+Rm
         wJIu8bAP5EKqbgKunOa2lQD3ab8j7CAKuzavveEPbnXZWQ2b+ymZjbWLt3aMHh0kR1Va
         jBGiahp8NK9l6PrVB2w1nEBrGYDieTFOnA4UE=
Received: by 10.216.176.201 with SMTP id b51mr919420wem.34.1296579986174; Tue,
 01 Feb 2011 09:06:26 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Tue, 1 Feb 2011 09:05:55 -0800 (PST)
In-Reply-To: <AANLkTinPAL2rEUMe-tRGFxSQ0-gfAJvSO7WW+f+2Fd2u@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165829>

On Tue, Feb 1, 2011 at 11:27 PM, Shawn Pearce <spearce@spearce.org> wro=
te:
>>> > subtree clone
>>>
>>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy and Elijah Newren have do=
ne some design and
>>> prototyping work.
>>
>> Git mailing list archives should contain proof of concept / RFC patc=
hes
>> for this feature. =C2=A0Quite interesting.
>
> I think Junio has already started thinking about this one.

I need to get nd/pathspec right and implement negative pathspecs
before returning to this feature. But there are still interesting
issues:

 - narrow by directories or pathspecs (or unpack_trees() by
directories or pathspecs)
 - widen a clone (negative pathspecs should help calculating necessary =
objects)
 - should commit objects that does not update narrow area be fetched
(I recall it consumes a considerable amount. Security is also an
issue)
 - push support for shallow clone (Elijah approach does not base on
shallow clone, so it's non-issue)
--=20
Duy
