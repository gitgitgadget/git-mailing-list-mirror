From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: CFT: merge-recursive in C (updated)
Date: Wed, 28 Jun 2006 17:09:51 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606281707570.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0606270848v2253209aw52466de632ab25c1@mail.gmail.com> 
 <Pine.LNX.4.63.0606271830210.29667@wbgn013.biozentrum.uni-wuerzburg.de> 
 <20060627223249.GA8177@steel.home>  <81b0412b0606280234x7d07fbbck7887b5214d98bf91@mail.gmail.com>
  <Pine.LNX.4.63.0606281202360.29667@wbgn013.biozentrum.uni-wuerzburg.de> 
 <81b0412b0606280435t70ac9957jae2c4d1c10b7681d@mail.gmail.com> 
 <Pine.LNX.4.63.0606281342290.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0606280727k2f4d5c26m5d37f2835821c93b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 17:10:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fvbfy-0006Fg-0b
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 17:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932822AbWF1PJz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 11:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932823AbWF1PJy
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 11:09:54 -0400
Received: from mail.gmx.de ([213.165.64.21]:1162 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932822AbWF1PJx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jun 2006 11:09:53 -0400
Received: (qmail invoked by alias); 28 Jun 2006 15:09:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 28 Jun 2006 17:09:52 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0606280727k2f4d5c26m5d37f2835821c93b@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22811>

Hi,

On Wed, 28 Jun 2006, Alex Riesen wrote:

> On 6/28/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > > What stands out next is getRenames (to be renamed into get_renames), a
> > > little profiling shows that the renames lists are the culprit this time
> > > too.
> > 
> > In my attempts, the path_list did not contain paths, but structs
> > containing a path and a void pointer. I think I will resurrect this idea
> > for the renames.
> > 
> 
> What was the pointer for?

We want to emulate the set with a sorted list. The pointer is for the 
payload.

Ciao,
Dscho
