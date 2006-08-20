From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Object hash (was: Re: [ANNOUNCE] git-rev-size: calculate sizes
 of repository)
Date: Sun, 20 Aug 2006 20:47:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608202047010.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060820105452.GA19630@nospam.com> <200608201837.33577.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.63.0608201846110.28360@wbgn013.biozentrum.uni-wuerzburg.de>
 <200608202041.19644.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 20 20:47:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEsKe-00024N-1b
	for gcvg-git@gmane.org; Sun, 20 Aug 2006 20:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWHTSrd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Aug 2006 14:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWHTSrd
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Aug 2006 14:47:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:14723 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751145AbWHTSrc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Aug 2006 14:47:32 -0400
Received: (qmail invoked by alias); 20 Aug 2006 18:47:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 20 Aug 2006 20:47:31 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200608202041.19644.Josef.Weidendorfer@gmx.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25765>

Hi,

On Sun, 20 Aug 2006, Josef Weidendorfer wrote:

> On Sunday 20 August 2006 18:51, Johannes Schindelin wrote:
> 
> > > > +void hash_put(struct hash_map *hash, struct object *obj)
> > > > +{
> > > > +	if (++hash->nr > hash->alloc / 2)
> > > > +		grow_hash(hash);
> > > 
> > > If you insert the same object multiple times, hash->nr will get too big.
> > 
> > First, you cannot put the same object multiple times. That is not what a  
> > hash does (at least in this case): it stores unique objects (identified by 
> > their sha1 in this case).
> 
> I put it the wrong way; I should have said "if you call hash_put() multiple
> times with the same object". You get the same index, and nothing should
> change. However, you still increment hash->nr, but this error is not really
> important as you correct it in grow_hash().

Talk about unintended side effects ;-)

Ciao,
Dscho
