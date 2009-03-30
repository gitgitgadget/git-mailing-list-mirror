From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/2] bisect--helper: string output variables together with "&&"
Date: Mon, 30 Mar 2009 06:18:18 +0200
Message-ID: <200903300618.19041.chriscool@tuxfamily.org>
References: <20090329115547.91e2de5b.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 06:20:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo8zX-0005cG-SC
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 06:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbZC3ETY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 00:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbZC3ETY
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 00:19:24 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:48767 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752AbZC3ETX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2009 00:19:23 -0400
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 52D3D4C808E;
	Mon, 30 Mar 2009 06:19:14 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 66B504C8020;
	Mon, 30 Mar 2009 06:19:12 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20090329115547.91e2de5b.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115059>

Le dimanche 29 mars 2009, Christian Couder a =E9crit :

> -static void show_tried_revs(struct commit_list *tried)
> +static void show_tried_revs(struct commit_list *tried, int stringed)
>  {
> +	char *last_format =3D stringed ? "%s &&" : "%s";
> +
>  	printf("bisect_tried=3D'");
>  	for (;tried; tried =3D tried->next) {
> -		char *format =3D tried->next ? "%s|" : "%s";
> +		char *format =3D tried->next ? "%s|" : last_format;
>  		printf(format, sha1_to_hex(tried->item->object.sha1));
>  	}
>  	printf("'\n");

Ooops, sorry, this is wrong I will send an updaed series.

Best regards,
Christian.
