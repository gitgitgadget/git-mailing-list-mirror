From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: CFT: merge-recursive in C (updated)
Date: Wed, 28 Jun 2006 12:04:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606281202360.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0606270848v2253209aw52466de632ab25c1@mail.gmail.com> 
 <Pine.LNX.4.63.0606271830210.29667@wbgn013.biozentrum.uni-wuerzburg.de> 
 <20060627223249.GA8177@steel.home> <81b0412b0606280234x7d07fbbck7887b5214d98bf91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Jun 28 12:04:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvWuB-0000B6-MF
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 12:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423249AbWF1KEQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 06:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423254AbWF1KEQ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 06:04:16 -0400
Received: from mail.gmx.de ([213.165.64.21]:8891 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1423249AbWF1KEP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jun 2006 06:04:15 -0400
Received: (qmail invoked by alias); 28 Jun 2006 10:04:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 28 Jun 2006 12:04:14 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0606280234x7d07fbbck7887b5214d98bf91@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22796>

Hi,

On Wed, 28 Jun 2006, Alex Riesen wrote:

> On 6/28/06, Alex Riesen <fork0@t-online.de> wrote:
> > Johannes Schindelin, Tue, Jun 27, 2006 18:42:51 +0200:
> > > > - use a pipe to "git-update-index --index-info" instead of using command
> > > > line
> 
> ...and to take it a step further, a patch (0002) to avoid too many calls to
> git-write-tree and to git-update-index.

... and introduces a lot more lines doing debug output.

However, the change is good, but I would not call it "FILE *fp". IMHO 
"FILE *update_index_pipe" would explain better what you do there.

Ciao,
Dscho
