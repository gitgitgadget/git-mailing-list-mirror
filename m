From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH] Hash name is SHA-1
Date: Thu, 25 Jan 2007 15:56:08 -0300
Message-ID: <200701251856.l0PIu8pP032403@laptop13.inf.utfsm.cl>
References: <11697294071178-git-send-email-vonbrand@inf.utfsm.cl> <1169729410294-git-send-email-vonbrand@inf.utfsm.cl> <20070125170120.GA13089@spearce.org> <Pine.LNX.4.64.0701251209100.3011@xanadu.home>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Jan 25 19:56:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA9m6-00061u-D7
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 19:56:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965575AbXAYS4j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 13:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965570AbXAYS4j
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 13:56:39 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:45903 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965574AbXAYS4i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 13:56:38 -0500
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l0PIu9vA000796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 25 Jan 2007 15:56:09 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l0PIu8pP032403;
	Thu, 25 Jan 2007 15:56:08 -0300
In-reply-to: <Pine.LNX.4.64.0701251209100.3011@xanadu.home>
Comments: In-reply-to Nicolas Pitre <nico@cam.org>
   message dated "Thu, 25 Jan 2007 12:10:28 -0500."
X-Mailer: MH-E 7.4.2; nmh 1.2-20070115cvs; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [0.0.0.0]); Thu, 25 Jan 2007 15:56:09 -0300 (CLST)
X-Virus-Scanned: ClamAV 0.88.7/2490/Thu Jan 25 13:56:53 2007 on inti.inf.utfsm.cl
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.6
X-Spam-Checker-Version: SpamAssassin 3.0.6 (2005-12-07) on inti.inf.utfsm.cl
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37750>

Nicolas Pitre <nico@cam.org> wrote:
> On Thu, 25 Jan 2007, Shawn O. Pearce wrote:
> > "Horst H. von Brand" <vonbrand@inf.utfsm.cl> wrote:
> > > index 3fefdac..814f78f 100644
> > > --- a/builtin-apply.c
> > > +++ b/builtin-apply.c
> > > @@ -1811,7 +1812,8 @@ static int apply_binary(struct buffer_desc *desc, struct patch *patch)
> > >  			     "without full index line", name);
> > >  
> > >  	if (patch->old_name) {
> > > -		/* See if the old one matches what the patch
> > > +		/* 
> > > +		 * See if the old one matches what the patch
> > >  		 * applies to.
> > >  		 */
> > >  		hash_sha1_file(desc->buffer, desc->size, blob_type, sha1);
> > 
> > However I cannot help but feel that this hunk is unrelated to the
> > theme of this extremely large patch.  I don't know how Junio feels,
> > but this late in the 1.5.0 series I'm a little leary of a 1600+
> > line patch which is changing so much code, even if its something
> > as trivial as the above hunk.

> Maybe the patch could be restricted to documentation fixes only for now?

That's what I tried to do. But just changing the documentation without
changing (some) of the messages and so on just gets you worse
inconsistency.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
