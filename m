From: =?UTF-8?B?Q8OpbGVzdGluIE1hdHRl?= <celestin.matte@ensimag.fr>
Subject: Re: [PATCH 1/2] rm: better error message on failure for multiple
 files
Date: Mon, 10 Jun 2013 13:28:54 +0200
Message-ID: <51B5B876.3070903@ensimag.fr>
References: <1370680434-2709-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 10 13:29:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um0Hb-00048U-6N
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 13:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764Ab3FJL3C convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jun 2013 07:29:02 -0400
Received: from mx1.imag.fr ([129.88.30.5]:53167 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751843Ab3FJL3B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 07:29:01 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5ABSsNb027680
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 13:28:54 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5ABSt6L013405;
	Mon, 10 Jun 2013 13:28:55 +0200
Received: from [127.0.0.1] (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5ABSs5T019032;
	Mon, 10 Jun 2013 13:28:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <1370680434-2709-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 10 Jun 2013 13:28:54 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227272>

Le 08/06/2013 10:33, Mathieu Lienard--Mayor a =C3=A9crit :
> +	if (files_staged.len)
> +		errs =3D error(_("the following files have staged content "
> +			       "different from both the\nfileand the HEAD:%s\n"
> +			       "(use -f to force removal)"), files_staged.buf);

Typo here: "fileand" -> "file and"

--=20
C=C3=A9lestin Matte
