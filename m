From: Conrad Parker <conrad@metadecks.org>
Subject: Re: RFD: git-bzr: anyone interested?
Date: Fri, 6 Aug 2010 16:19:27 +0900
Message-ID: <AANLkTi=a27OtQX-oNwPqmXDUmZHFyKo+fPZCRgSv04G3@mail.gmail.com>
References: <4B7D8358.1080108@gmail.com>
	<fabb9a1e1002181037n58d6942dpa63a57a23f506d9c@mail.gmail.com>
	<4B7E3856.3080609@gmail.com>
	<20100219135549.GA31796@Knoppix>
	<4B820B4E.7050405@gmail.com>
	<20100222105133.GA10577@Knoppix>
	<4B834989.50502@gmail.com>
	<20100223124553.GA19153@Knoppix>
	<p2ka038bef51004261441x7e4857f1mc3f03a4104f8e018@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Gabriel Filion <lelutin@gmail.com>, git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 09:19:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhHDY-0002ap-JM
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 09:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933955Ab0HFHTe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 03:19:34 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63900 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933221Ab0HFHT2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Aug 2010 03:19:28 -0400
Received: by gyg10 with SMTP id 10so2753213gyg.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 00:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=sLELj1CH2Ww00HagsHXYMfB9GGGb5cYB2yzAtSQhsog=;
        b=xyqQ+IJVZVTQC08HjoIs7WhOaYCNCjwHyeWvSjNVMqi32hXILA2ZsnMirpPjIWj0at
         rh3d285zkiCzgTyG2a20K8X+YfLaAXZMHSRYhb74v0w6byEsx3AH+7e+SNM52LhtaAVh
         85LgtAkgxFhhp1lAd226Yt/5PDFQQV29IC/Xw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=rtFpw9Nmll0y5Ynn3zRvIKL9k3HWX0FouCEgtDeaLYRQSfCzX+NLs8ZMiDu9TekJpj
         t3nVAEnND6dsa85o+oN8rSwPd9mx/+vJ1QMknYHsj7WYd9IXTcd6ihhePLMqg1AOXnIk
         5anWqXeiUzbUrlY374JiXgLMC8UslKAYnFBHE=
Received: by 10.90.36.8 with SMTP id j8mr6279896agj.187.1281079167739; Fri, 06 
	Aug 2010 00:19:27 -0700 (PDT)
Received: by 10.90.63.20 with HTTP; Fri, 6 Aug 2010 00:19:27 -0700 (PDT)
In-Reply-To: <p2ka038bef51004261441x7e4857f1mc3f03a4104f8e018@mail.gmail.com>
X-Google-Sender-Auth: zz0Kyurz2G2oINMtDxKfIwANw64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152767>

Hi,

Anyone interested in git-bzr might also want to look at some recent
rewrites; from the current git-bzr README:

The following are rewrites in Python and may offer better bzr integrati=
on:
  * http://github.com/termie/git-bzr-ng
  * http://github.com/matthew-brett/git-bzr

(... and I'd also be interested to know how well either of these work :=
)

cheers,

Conrad (kfish).

On 27 April 2010 06:41, Chris Packham <judge.packham@gmail.com> wrote:
> Hi,
>
> How far did git-bzr or git-remote-bzr get?
>
> I've tried git-bzr from the repo and I seem to be stumbling on bzr no=
t
> having the fast-export command after I install the fast-import plugin
> as per [1]. So I think its a bazzar problem not a git-bzr one. Has
> anyone got a fully worked example including the installation of the
> required bits and pieces.
>
> Alternatively what I'm really trying to do is update a series of
> patches for an upstream project that is managed with bazzar. We have
> 30 or so patches with our customizations so I'd like to get git (or
> bzr) to do the heavy lifting for me. In git I'd do something like thi=
s
>
> git clone <upstream>
> git checkout <tag that corresponds to the version of the tarball we u=
se>
> git checkout -b our-patches
> git am <patches>
> git rebase <tag that corresponds to the new version we want to use>
> git format-patch ...
>
> Anybody got a similar recipe for bzr? (yes I'll go ask on the bzr lis=
t too)
>
> [1] http://github.com/kfish/git-bzr/blob/master/README
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
