From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Hash name is SHA-1
Date: Thu, 25 Jan 2007 12:10:28 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701251209100.3011@xanadu.home>
References: <11697294071178-git-send-email-vonbrand@inf.utfsm.cl>
 <1169729410294-git-send-email-vonbrand@inf.utfsm.cl>
 <20070125170120.GA13089@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 25 18:10:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA87N-0003gn-TK
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 18:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030446AbXAYRKa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 12:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030450AbXAYRKa
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 12:10:30 -0500
Received: from relais.videotron.ca ([24.201.245.36]:39721 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030446AbXAYRKa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 12:10:30 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCF00IS8P1HGB00@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 25 Jan 2007 12:10:29 -0500 (EST)
In-reply-to: <20070125170120.GA13089@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37742>

On Thu, 25 Jan 2007, Shawn O. Pearce wrote:

> "Horst H. von Brand" <vonbrand@inf.utfsm.cl> wrote:
> > index 3fefdac..814f78f 100644
> > --- a/builtin-apply.c
> > +++ b/builtin-apply.c
> > @@ -1811,7 +1812,8 @@ static int apply_binary(struct buffer_desc *desc, struct patch *patch)
> >  			     "without full index line", name);
> >  
> >  	if (patch->old_name) {
> > -		/* See if the old one matches what the patch
> > +		/* 
> > +		 * See if the old one matches what the patch
> >  		 * applies to.
> >  		 */
> >  		hash_sha1_file(desc->buffer, desc->size, blob_type, sha1);
> 
> However I cannot help but feel that this hunk is unrelated to the
> theme of this extremely large patch.  I don't know how Junio feels,
> but this late in the 1.5.0 series I'm a little leary of a 1600+
> line patch which is changing so much code, even if its something
> as trivial as the above hunk.

Maybe the patch could be restricted to documentation fixes only for now?


Nicolas
