From: Tor Arntsen <tor@spacetec.no>
Subject: Re: [PATCH/RFC] Fix for default pager
Date: Thu, 10 Jun 2010 10:48:31 +0200
Message-ID: <AANLkTinLt3p0q-q5oDFk5CWzdhqQ2lwkWuvpdPzKZvYe@mail.gmail.com>
References: <20100608053507.GB15156@coredump.intra.peff.net>
	<AANLkTilvvpy4TBQF6g8boQL87FRB7kFDrVfYiHvOv6xu@mail.gmail.com>
	<4C0E5103.7030501@viscovery.net>
	<AANLkTilWg8hw5j20o-xGsVO-q_OeSmtKEKAO6O416qvH@mail.gmail.com>
	<4C0E6810.3070301@viscovery.net>
	<AANLkTinZSuXJEXzpvEavYNLSyqUlx8qzWlrbtIH6q6fx@mail.gmail.com>
	<4C0E932B.3010702@viscovery.net>
	<AANLkTinB_SBilMOfgnHtDrQS-NBOLF4yY5NaP7ZvN9rK@mail.gmail.com>
	<4C0EB741.9020905@op5.se>
	<AANLkTinAO5empFix9W_rbtU3Vv4O73OsJBtA1stb66DS@mail.gmail.com>
	<20100610082916.GA5559@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>,
	Dario Rodriguez <soft.d4rio@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 10 10:48:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMdRG-0000ce-VN
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 10:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758633Ab0FJIse convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jun 2010 04:48:34 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41670 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830Ab0FJIsd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jun 2010 04:48:33 -0400
Received: by fxm8 with SMTP id 8so4087034fxm.19
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 01:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=YZXzM+LyvtdcgkGccu3JLPxAbMCWjkkDEi1FJCo4iNA=;
        b=gpxCA3Op71zJl6O257YeYTk/8FQVAVSPShIy8Eraa79s2KteSiCSBFm1JfPWKeniFb
         wn9pwpx0z2gXktK2Oc2YCsoxrVeQS574ExNf+MfsBy60ASJJviO+kOCxBFhxkYSTLwJO
         N8fFFwSpHkyeSpa1eowP6lJVcPyPJli4YyczE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=XPinNlaBW1RNMVSamXwAhTQ/2I62HsCtq2My4xBSg+LMS/NI6yZG+mf441DZP0UjGO
         dvwRE8z0jK8vhSBSdkusQ8BI94wSMmiJyFhE/GtYD0cg1DLmL/eLdA85L8K3Z9juINwD
         HXppkvPyTaBEsGg6sCJpPukCbBNp0sieC5gEY=
Received: by 10.239.162.200 with SMTP id m8mr1349727hbd.112.1276159711336; 
	Thu, 10 Jun 2010 01:48:31 -0700 (PDT)
Received: by 10.239.156.209 with HTTP; Thu, 10 Jun 2010 01:48:31 -0700 (PDT)
In-Reply-To: <20100610082916.GA5559@coredump.intra.peff.net>
X-Google-Sender-Auth: 2TrMcIwTpQ8dY6cwIYS3D5d6d7E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148842>

On Thu, Jun 10, 2010 at 10:29, Jeff King <peff@peff.net> wrote:
> On Wed, Jun 09, 2010 at 11:08:49AM +0200, Tor Arntsen wrote:
>
>> If it's true that Git should demand 'less' to be installed before
>> being usable out of the box.. well, that's just plain silly.
>
> It depends on how you define "out of the box". The person compiling i=
t
> just needs to set DEFAULT_PAGER appropriately for their system. "less=
"
> is a sane choice for most modern systems. But we can make it even eas=
ier
> on AIX people with:
>
> diff --git a/Makefile b/Makefile
> index 34b7dd5..6ad0aca 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -930,6 +930,7 @@ ifeq ($(uname_S),NetBSD)
> =A0 =A0 =A0 =A0HAVE_PATHS_H =3D YesPlease
> =A0endif
> =A0ifeq ($(uname_S),AIX)
> + =A0 =A0 =A0 DEFAULT_PAGER =3D more
> =A0 =A0 =A0 =A0NO_STRCASESTR=3DYesPlease
> =A0 =A0 =A0 =A0NO_MEMMEM =3D YesPlease
> =A0 =A0 =A0 =A0NO_MKDTEMP =3D YesPlease

That looks good to me.

> That won't do automagic run-time detection if you have "less" install=
ed,
> but given your claim that AIX's "more" actually doesn't suck, it's
> probably a good default.

It does the paging just as 'less', yes. I can page 'git log' or any
other output. backwards/forwards as I wish. I'm not aware of any
'more' other than the AIX one that does this. Even the archaic
(pre-AIX5) versions did. The AIX 'more' also have several more
in-buffer options compared to e.g. Linux 'more'.  It sits somewhere
between traditional 'more' and 'less', feature-wise. (The AIX 6
version even does the, to me, annoying less-style erase-screen, unless
turned off by an option or environment variable.)

> People who care can set their PAGER environment
> variable.

-Tor
