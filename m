From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] Use perl instead of tac
Date: Mon, 28 Apr 2008 15:31:13 +0200
Message-ID: <4815D1A1.8020407@gnu.org>
References: <8D73338C-4EC3-4078-8A34-51DAC1842C2B@silverinsanity.com>	 <20080427064250.GA5455@sigill.intra.peff.net>	 <739FA851-F7F5-4CF9-B384-25AA7022B0C2@silverinsanity.com>	 <slrng1be8l.25r.joerg@alea.gnuu.de>	 <86k5iib0g9.fsf@blue.stonehenge.com> <ee77f5c20804280612o3db1fb86nf089e2201f688d2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	=?ISO-8859-1?Q?J=F6rg_?= =?ISO-8859-1?Q?Sommer?= 
	<joerg@alea.gnuu.de>, git@vger.kernel.org
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 15:32:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqTSh-0007Fz-R5
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 15:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765480AbYD1NbS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2008 09:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764816AbYD1NbS
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 09:31:18 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:44237 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762306AbYD1NbR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 09:31:17 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1873957nfb.21
        for <git@vger.kernel.org>; Mon, 28 Apr 2008 06:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=prNvX1az9Zo3pf5teBttxuOhj0BhXUaynQoKR5/L2W4=;
        b=PXtOjbw3frH+wgt5zgDsoAsOQhTF+KMjbC+wWALrW5yVuN1ROxEI+iZRavihCkZ9QRrJXIbGdbqag8CMpnu6+ffIF6ICPLnKXc8JDtbXk5KcsiH8JPOIpAyppuFBoDIMs5bppT/iuo7Y7Rh626SpgPsvdLBMN82hHr0hRoeZqMM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=a3gkSAaCW3DumGkiaqO1cRv8QyQWL2O5r8ANM6rh8Kxlwn/xcozYC364Tb0/IWAo4FzvtyodySwjSNvMX/709D/hY90SxmshrJvAyHOBjotgq6QKK/7PQ8bpZ8WC9fSFPjiybTUrQ4U34HalixnoiiDFQfJrqPdebqcR7i/LElo=
Received: by 10.210.70.14 with SMTP id s14mr5772238eba.161.1209389476064;
        Mon, 28 Apr 2008 06:31:16 -0700 (PDT)
Received: from scientist-2.local ( [195.176.178.209])
        by mx.google.com with ESMTPS id g1sm23753154muf.5.2008.04.28.06.31.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Apr 2008 06:31:14 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <ee77f5c20804280612o3db1fb86nf089e2201f688d2f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80532>

David Symonds wrote:
> On Mon, Apr 28, 2008 at 10:58 PM, Randal L. Schwartz
> <merlyn@stonehenge.com> wrote:
>>>>>>> "J=F6rg" =3D=3D J=F6rg Sommer <joerg@alea.gnuu.de> writes:
>>  J=F6rg> What about using a shell function and a *big* variable or a=
n intermediate
>>  J=F6rg> file?
>>
>>  What makes you think that's any more faster or efficient than calli=
ng Perl
>>  at this point?
>=20
> I doubt J=F6rg suggested it for its speed, but it removes the depende=
ncy on Perl.
>=20
> Bit ugly, still.

And quadratic, unlike Perl (and unlike sed, if it worked portably).

Paolo
