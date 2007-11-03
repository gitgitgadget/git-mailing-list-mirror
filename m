From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] errors: "strict subset" -> "ancestor"
Date: Sat, 3 Nov 2007 08:08:55 +0100
Message-ID: <A4169B7B-C05B-4CA0-B41B-E1E2D71491B6@zib.de>
References: <20071103023944.GA15379@fieldses.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sat Nov 03 08:08:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoD6v-0002x0-Km
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 08:08:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754618AbXKCHHq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 03:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbXKCHHq
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 03:07:46 -0400
Received: from mailer.zib.de ([130.73.108.11]:40443 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753296AbXKCHHp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 03:07:45 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lA377ZBZ015334;
	Sat, 3 Nov 2007 08:07:39 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1075c.pool.einsundeins.de [77.177.7.92])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lA377XJL024330
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 3 Nov 2007 08:07:34 +0100 (MET)
In-Reply-To: <20071103023944.GA15379@fieldses.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63207>


On Nov 3, 2007, at 3:39 AM, J. Bruce Fields wrote:

> diff --git a/send-pack.c b/send-pack.c
> index 5e127a1..b74fd45 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -297,9 +297,9 @@ static int send_pack(int in, int out, struct  
> remote *remote, int nr_refspec, cha
>  				 * commits at the remote end and likely
>  				 * we were not up to date to begin with.
>  				 */
> -				error("remote '%s' is not a strict "
> -				      "subset of local ref '%s'. "
> -				      "maybe you are not up-to-date and "
> +				error("remote '%s' is not an ancestor of\n"
> +				      " local  '%s'.\n"

Two spaces in a row after local and before '%s'.

	Steffen
