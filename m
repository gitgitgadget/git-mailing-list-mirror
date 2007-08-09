From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] allow git-bundle to create bottomless bundle
Date: Thu, 9 Aug 2007 01:28:25 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708090127440.21857@racer.site>
References: <fcaeb9bf0708070623p24f1cae2q2af959a89738c4e8@mail.gmail.com>
 <20070808035946.GP9527@spearce.org> <Pine.LNX.4.64.0708081012110.14781@racer.site>
 <7vlkcl4zcw.fsf@assigned-by-dhcp.cox.net> <7vps1xzic2.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Mark Levedahl <mdl123@verizon.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 02:29:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIvto-00086I-N0
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 02:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935704AbXHIA3I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 20:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934274AbXHIA3I
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 20:29:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:45615 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933477AbXHIA3G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 20:29:06 -0400
Received: (qmail invoked by alias); 09 Aug 2007 00:29:05 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp034) with SMTP; 09 Aug 2007 02:29:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX180zCAzpGI00GkysRGOSKLNhd60pmJqP5HK9Z9+kF
	xseanH2XazKOqk
X-X-Sender: gene099@racer.site
In-Reply-To: <7vps1xzic2.fsf_-_@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55402>

Hi,

On Wed, 8 Aug 2007, Junio C Hamano wrote:

> +		 *
> +		 * Non commit objects such as tags and blobs do not have
> +		 * this issue as they are not affected by those extra
> +		 * constraints.
>  		 */
> -		if (!(e->item->flags & SHOWN)) {
> +		if (!(e->item->flags & SHOWN) && e->item->type == OBJ_COMMIT) {

That is all?  Heh.

Thanks for fixing this bug,
Dscho
