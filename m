From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 2/3] git-tar-tree: documentation update
Date: Sun, 18 Jun 2006 15:06:59 +0200
Message-ID: <44954FF3.9060001@lsrfire.ath.cx>
References: <11506282792065-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 18 15:07:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrwzU-0004mM-SN
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 15:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWFRNG6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 18 Jun 2006 09:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWFRNG5
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 09:06:57 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:1456
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S932209AbWFRNG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jun 2006 09:06:57 -0400
Received: from [10.0.1.3] (p508E50CB.dip.t-dialin.net [80.142.80.203])
	by neapel230.server4you.de (Postfix) with ESMTP id 46A711A020;
	Sun, 18 Jun 2006 15:06:56 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <11506282792065-git-send-email-rene.scharfe@lsrfire.ath.cx>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22077>

>  * add example on how to avoid adding a global extended pax header
>  * don't mention linux anymore, use git itself as an example instead
>  * update to v1.4.0 ;-)
>  * append missing :: to the examples

Oops, I forgot to mention this change:

> -git tar-tree HEAD | (cd /var/tmp/ && mkdir junk && tar Cxf junk -)::
> +git tar-tree HEAD junk | (cd /var/tmp/ && tar xf -)::
> =20
>  	Create a tar archive that contains the contents of the
>  	latest commit on the current branch, and extracts it in
>  	`/var/tmp/junk` directory.

The new version features less typing and no more path duplication.

Ren=E9
