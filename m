From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/4] merge-recursive in C
Date: Mon, 3 Jul 2006 17:54:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607031750310.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060630002721.GA22618@steel.home> <20060703184604.59801e4e.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 17:55:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxQlD-0006ux-OT
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 17:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWGCPyq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 11:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWGCPyq
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 11:54:46 -0400
Received: from mail.gmx.net ([213.165.64.21]:18385 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932082AbWGCPyq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 11:54:46 -0400
Received: (qmail invoked by alias); 03 Jul 2006 15:54:44 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp023) with SMTP; 03 Jul 2006 17:54:44 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060703184604.59801e4e.tihirvon@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23187>

Hi,

On Mon, 3 Jul 2006, Timo Hirvonen wrote:

> fork0@t-online.de (Alex Riesen) wrote:
> 
> > +/* in place */
> > +void path_list_union_update(struct path_list *dst, const struct path_list *src)
> > +{
> > +	char **new_paths;
> > +	int i = 0, j = 0, nr = 0, alloc = dst->nr + dst->nr;
> 
> It should be alloc = dst->nr + src->nr.

Good catch. Merci.

Ciao,
Dscho
