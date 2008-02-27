From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: [PATCH] Documentation: help: describe 'man.viewer' config variable.
Date: Wed, 27 Feb 2008 22:22:43 +0900
Message-ID: <200802271323.m1RDNGTQ025557@mi1.bluebottle.com>
References: <20080227065535.8ac7883a.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Pascal Obry <pascal@obry.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Feb 27 14:24:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUMGL-0003HJ-1s
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 14:23:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbYB0NXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 08:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbYB0NXS
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 08:23:18 -0500
Received: from mi1.bluebottle.com ([206.188.25.14]:42347 "EHLO
	mi1.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939AbYB0NXR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 08:23:17 -0500
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi1.bluebottle.com (8.13.1/8.13.1) with ESMTP id m1RDNGTQ025557
	for <git@vger.kernel.org>; Wed, 27 Feb 2008 05:23:17 -0800
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:in-reply-to:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=mMQmqngG4I0IMaO3gUTKl8P5ZjW75IeuoN+BFnRwlPqbRTXgUvdNrHAMFTOcA/iuv
	xLo8rkG66y0mTinjH2BBt6sDmB/pmVzZ33L3Nz9BSRHPaFvjjxI1X4vqm1MgoxC
Received: from nanako3.mail.bluebottle.com ([212.62.97.23])
	(authenticated bits=0)
	by fe0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m1RDN5L3006518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 Feb 2008 05:23:10 -0800
In-Reply-To: <20080227065535.8ac7883a.chriscool@tuxfamily.org>
X-Trusted-Delivery: <8f42e22a7bea0384c2c0c0194ff44ea3>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75230>

Quoting Christian Couder <chriscool@tuxfamily.org>:

> +man.viewer::
> +	Specify the program that will be used to display help in the
> +	'man' format. See linkgit:git-help[1].
> +
>  -i|--info::
> -	Use the 'info' program to display the manual page, instead of
> -	the 'man' program that is used by default.
> +	Display manual documentation about the command in Info
> +	format. The 'info' program will be used for that purpose.

I am not a native speaker of the English language, but "manual documentation about" feels duplicatedly redundant, at least to me.  I think it is more common to say "the manual page for", or "the man page for".

>  -m|--man::
> -	Use the 'man' program to display the manual page. This may be
> -	used to override a value set in the 'help.format'
> -	configuration variable.
> +	Display manual documentation about the command in Man format.

An earlier description for man.viewer says "in the 'man' format".

> +	This option may be used to override a value set in the
> +	'help.format' configuration variable.
> ++
> +By default the 'man' program will be used to display the man pages,

And this part says "the man pages".

>  -w|--web::
> -	Use a web browser to display the HTML manual page, instead of
> -	the 'man' program that is used by default.
> +	Display manual documentation about the command in HTLM format.
> +	A web browser will be used for that purpose.

Is this a mistyped "HTML format"?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Get a free email address with REAL anti-spam protection.
http://www.bluebottle.com/tag/1
