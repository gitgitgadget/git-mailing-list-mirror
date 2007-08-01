From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/4] Fix allocation of "int*" instead of "int".
Date: Wed, 1 Aug 2007 06:11:14 +0200
Message-ID: <200708010611.14171.chriscool@tuxfamily.org>
References: <20070731144829.ea83d43d.chriscool@tuxfamily.org> <20070731195616.GA6329@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio Hamano <junkio@cox.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 01 06:03:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IG5RA-0006gA-LO
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 06:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbXHAEDt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 1 Aug 2007 00:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbXHAEDt
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 00:03:49 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:38212 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750763AbXHAEDs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Aug 2007 00:03:48 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 6D6C81AB2B7;
	Wed,  1 Aug 2007 06:03:47 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 53BA31AB2B6;
	Wed,  1 Aug 2007 06:03:47 +0200 (CEST)
User-Agent: KMail/1.9.5
In-Reply-To: <20070731195616.GA6329@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54404>

Le mardi 31 juillet 2007 21:56, Jeff King a =E9crit :
> On Tue, Jul 31, 2007 at 02:48:29PM +0200, Christian Couder wrote:
> > -	weights =3D xcalloc(on_list, sizeof(int*));
> > +	weights =3D xcalloc(on_list, sizeof(int));
>
> How about the correct-by-definition sizeof(*weights)?

That's ok for me too.

Thanks,
Christian.
