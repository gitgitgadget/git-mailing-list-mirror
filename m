From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 5/9] Convert 'hide' to the lib infrastructure
Date: Wed, 13 May 2009 17:08:02 +0100
Message-ID: <b0943d9e0905130908x6ce569b7gddfc7c152989a618@mail.gmail.com>
References: <20090428150742.27261.19620.stgit@pc1117.cambridge.arm.com>
	 <20090428151003.27261.72531.stgit@pc1117.cambridge.arm.com>
	 <20090429062749.GE18483@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed May 13 18:08:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4H0A-0004Jm-VL
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 18:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758802AbZEMQIH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 May 2009 12:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758726AbZEMQIF
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 12:08:05 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:5758 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267AbZEMQIC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2009 12:08:02 -0400
Received: by ey-out-2122.google.com with SMTP id 9so225857eyd.37
        for <git@vger.kernel.org>; Wed, 13 May 2009 09:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hYbz5LXiL4PEZXzeLWbvhukpW1I7PzSARAOcujfRhic=;
        b=tsXC3F3jLOb8GJ2hVjGLlv9mP6qHlTw6efc6Dh9RSmpFj22oLVvJ37hRgCxSQwbHVn
         XwTLSFqLdBmo4R99DIsct0dSoofPED7xKqRzRtT+bjlOrkb1WR/YL0+8+a3oU5r2/XAh
         AQjDpp09MEAzUW0Pv7ujdhwPdRjRT2WedjkOE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SV6geubdE1THiNzo2kXsEk3H23Kox48jaFmygCMRhID4AZvEezFixv8gsBHis2MqLY
         N8IqTpcSvL9G6vSUa+8FyrCjr/z/ytB0foQFen5Q+y3LiP/rURiSY4HwvxFop+I7E4lF
         yyj4OIQHbSHgvXMdAA6YOm4murYHQ8vP3QiF8=
Received: by 10.216.26.82 with SMTP id b60mr478750wea.177.1242230882511; Wed, 
	13 May 2009 09:08:02 -0700 (PDT)
In-Reply-To: <20090429062749.GE18483@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119061>

2009/4/29 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2009-04-28 16:10:03 +0100, Catalin Marinas wrote:
>
>> -args =3D [argparse.patch_range(argparse.applied_patches,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 argparse.u=
napplied_patches)]
>> +args =3D [argparse.patch_range(argparse.unapplied_patches)]
>
> Why not simply allow all patches? reorder_patches() below will happil=
y
> pop unapplied patches before hiding them IIRC, and for already hidden
> patches you could just say "already hidden".
>
> Hmm, but this is for the tab completion, so I guess we'd only want th=
e
> applied and unapplied patches here.

I fixed that in the proposed branch but I was to slow on sending e-mail=
s.

> As I said,
>
> =A0* Why not simply allow hiding of applied patches?
>
> =A0* Hiding a hidden patch should probably be a warning (if that), no=
t
> =A0 =A0an error.

=46ixed this as well.

--=20
Catalin
