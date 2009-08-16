From: Scott Chacon <schacon@gmail.com>
Subject: Re: GitHub linking, was Re: bbchop & Wikipedia's Bayesian search 
	theory page
Date: Sun, 16 Aug 2009 14:48:28 -0700
Message-ID: <d411cc4a0908161448g5a4ab4a2x680fc6e492017161@mail.gmail.com>
References: <alpine.DEB.1.00.0908161907580.8306@pacific.mpi-cbg.de>
	 <alpine.DEB.1.00.0908161915040.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ealdwulf Wuffinga <ealdwulf@googlemail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 16 23:48:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mcnai-0001S8-3x
	for gcvg-git-2@lo.gmane.org; Sun, 16 Aug 2009 23:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755393AbZHPVs2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Aug 2009 17:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753948AbZHPVs2
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 17:48:28 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:23770 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753387AbZHPVs1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Aug 2009 17:48:27 -0400
Received: by an-out-0708.google.com with SMTP id d40so2519003and.1
        for <git@vger.kernel.org>; Sun, 16 Aug 2009 14:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dIwo9XjI9KP/R+pKQpBRDlmCvCIKxI946zT7AWiCik0=;
        b=fhRxtw/ZcOl9FWKd6GIs9/mqsJNtjVlk84M/F0Jt7YYRnhlm/Six35+j92M9VRlkXY
         IPiyU1BahbbH17M2jirGkZyvM67bfRZnrvEyatNS92WLFyqRixVyJWabMH4FhfBhQx6a
         C2hEoQxbIj7kVwcRhJ2LsPSBIf+wXO6EgLEH4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=g2snJBrTguAoXPxD8OkQ8Nl8EzpUpY4s5Dj6lFIbVSOU/6PAj6EjYRz2ArbNA61m7b
         hVfsmj5s6F3MwoGtnDHNFAViR76exb9MHFFZTwqJHtZR3OVfLVjsqe/jma9ufnyxQdRi
         Xv89HkhNRdsc4Y7Dc2X63J9r98601/JLu/IzY=
Received: by 10.100.122.17 with SMTP id u17mr741106anc.93.1250459308660; Sun, 
	16 Aug 2009 14:48:28 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908161915040.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126083>

Hey,

On Sun, Aug 16, 2009 at 10:18 AM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> The issue is that the link incorrectly includes the closing parenthes=
is.
> It should link to
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0http://en.wikipedia.org/wiki/Bayesian_sear=
ch_theory
>
> not
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0http://en.wikipedia.org/wiki/Bayesian_sear=
ch_theory)
>
> Scott, is it possible to fix that? =C2=A0Or is the README not magical=
ly made
> from the README in the repository (which does not contain HTML markup=
)?
>

If they change the README to have spaces between the url and the
parens, it will link properly - I'll file a bug for the linking issue.
 Thanks.

Scott
