From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: [PATCH 3/2] parse-options.c: introduce OPT_DATE
Date: Mon, 24 Mar 2008 17:25:42 +0100
Message-ID: <200803241725.42940.barra_cuda@katamail.com>
References: <200803232150.29971.barra_cuda@katamail.com> <alpine.LSU.1.00.0803241409400.4353@racer.site> <200803241502.21465.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 20:43:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdsZT-0007bM-QJ
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 20:43:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbYCXTmT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2008 15:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbYCXTmT
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 15:42:19 -0400
Received: from smtp.katamail.com ([62.149.157.154]:44825 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1750723AbYCXTmS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2008 15:42:18 -0400
Received: (qmail 31832 invoked by uid 89); 24 Mar 2008 16:11:38 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=RDNS_NONE autolearn=disabled
	version=3.2.3
Received: from unknown (HELO ?80.104.56.82?) (barra?cuda@katamail.com@80.104.56.82)
  by smtp1-pc with SMTP; 24 Mar 2008 16:11:38 -0000
User-Agent: KMail/1.9.7
In-Reply-To: <200803241502.21465.barra_cuda@katamail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78083>

On Monday 24 March 2008, Michele Ballabio wrote:
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0OPT_DATE(0, "expire", &=
expire,

[...]

> +#define OPT_DATE(s, l, v, h) \

Ooops. To be consistent, these should be OPT__DATE (with two underscore=
s)
instead (and in the commit message, too).
