From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: Merging submodules
Date: Fri, 1 Aug 2008 11:52:08 +0200
Message-ID: <8aa486160808010252j540a28cdw6e48027396da5248@mail.gmail.com>
References: <20080730230336.GA6481@Hermes>
	 <20080731092104.1a6ce8bd@pc09.procura.nl>
	 <20080731143955.034f0577@pc09.procura.nl>
	 <20080731130626.GQ32184@machine.or.cz>
	 <20080731170123.79e0d3e9@pc09.procura.nl>
	 <8aa486160807310824h25c9630dxc25b156e80fcdb29@mail.gmail.com>
	 <20080731201530.067be667@pc09.procura.nl>
	 <8aa486160807311203o3fb4deb8u4a5ae57818c76fab@mail.gmail.com>
	 <20080801090422.55c6a45f@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>,
	"Brian Gernhardt" <benji@silverinsanity.com>,
	"Git List" <git@vger.kernel.org>,
	"Lars Noschinski" <lars-2008-1@usenet.noschinski.de>
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Fri Aug 01 11:54:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOrJz-0000TI-IO
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 11:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755640AbYHAJwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 05:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757704AbYHAJwM
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 05:52:12 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:35627 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754887AbYHAJwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 05:52:09 -0400
Received: by yw-out-2324.google.com with SMTP id 9so564941ywe.1
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 02:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=9xpbTpYzSahFqytjn/3fv6x9pLMEwBLkFn3kKn/OgG4=;
        b=RwVAraMqjDxscya6zW1ZgusGb4WnKXA2gLEKctUhKjvEqqa3JoETwa3Tt2G1UEtRVT
         Tdf4yKYG98l8ACAlt5CzcH0teeQf6Iv8sgloa9ogVIqYyqCl4u0FytZbeohizFDN8AkR
         qKemHEPONrZRxncJuUIhZlVgEM44ier3yE75w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=M9iDrILiqc1LNxszjgOI6WJQ7JzX/+EsDX0J+lAgGLUUjAFO3W2r3un4eepaaIlQzv
         xEfKIrhS/EQFQ9L4/okLrtQ8s9vRut4hyhz3qIOnL92ST5W0qxi/+DWHE0Um97RwabWd
         2wl6xvflHVAxISSU+tbI2cxNBy5dz3V3TUeMU=
Received: by 10.150.196.20 with SMTP id t20mr2923382ybf.99.1217584328533;
        Fri, 01 Aug 2008 02:52:08 -0700 (PDT)
Received: by 10.150.95.21 with HTTP; Fri, 1 Aug 2008 02:52:08 -0700 (PDT)
In-Reply-To: <20080801090422.55c6a45f@pc09.procura.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91048>

On Fri, Aug 1, 2008 at 09:04, H.Merijn Brand <h.m.brand@xs4all.nl> wrote:
>
> Almost perfect now.
>
> 4gl/new 121 > git-ls-files | grep fnc_declare
> include/fnc_declare.h
> 4gl/new 122 > git-show d971ec91a3dbc9f1f27a96e4f9b95366babd036c
> commit d971ec91a3dbc9f1f27a96e4f9b95366babd036c
> Author: H.M. Brand <merijn@a5.(none)>
> Date:   Tue Jul 29 16:45:43 2008 +0200
>
>    Backward comp functie voor PV indicatie
>
> diff --git a/fnc_declare.h b/fnc_declare.h
> index acd686c..25d9a73 100644
> --- a/fnc_declare.h
> +++ b/fnc_declare.h
> @@ -136,6 +136,11 @@ eaf_N Indicaties    ($x1);
>  eaf_N pv_datum      ($x1, $x2, $x3);
>  #endif
>
> +#ifndef PV_INDICATIE
> +#define PV_INDICATIE
> +eaf_S pv_indicatie  ($x1);
> +#endif
> +
>  #undef eaf_B
>  #undef eaf_N
>  #undef eaf_S
> 4gl/new 123 >
>
> all the diffs are still showing as if they were against the folder they
> were originally committed in. Is that correct? I would now have expected
> something like

It is correct for old commits, when you look at an old commit it
doesn't know that later it is merge in a subfolder. For new commits it
depends on how you made them, in the modules and doing a subtree merge
or directly in the "superproject".

Santi


>
> commit d971ec91a3dbc9f1f27a96e4f9b95366babd036c
> Author: H.M. Brand <merijn@a5.(none)>
> Date:   Tue Jul 29 16:45:43 2008 +0200
>
>    Backward comp functie voor PV indicatie
>
> diff --git a/include/fnc_declare.h b/include/fnc_declare.h
> index acd686c..25d9a73 100644
> --- a/include/fnc_declare.h
> +++ b/include/fnc_declare.h
> @@ -136,6 +136,11 @@ eaf_N Indicaties    ($x1);
>  eaf_N pv_datum      ($x1, $x2, $x3);
>  #endif
>
> +#ifndef PV_INDICATIE
> +#define PV_INDICATIE
> +eaf_S pv_indicatie  ($x1);
> +#endif
> +
>  #undef eaf_B
>  #undef eaf_N
>  #undef eaf_S
>
> --
> H.Merijn Brand          Amsterdam Perl Mongers  http://amsterdam.pm.org/
> using & porting perl 5.6.2, 5.8.x, 5.10.x, 5.11.x on HP-UX 10.20, 11.00,
> 11.11, 11.23, and 11.31, SuSE 10.1, 10.2, and 10.3, AIX 5.2, and Cygwin.
> http://mirrors.develooper.com/hpux/           http://www.test-smoke.org/
> http://qa.perl.org      http://www.goldmark.org/jeff/stupid-disclaimers/
>
