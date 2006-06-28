From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: CFT: merge-recursive in C (updated)
Date: Wed, 28 Jun 2006 14:55:49 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606281342290.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0606270848v2253209aw52466de632ab25c1@mail.gmail.com> 
 <Pine.LNX.4.63.0606271830210.29667@wbgn013.biozentrum.uni-wuerzburg.de> 
 <20060627223249.GA8177@steel.home>  <81b0412b0606280234x7d07fbbck7887b5214d98bf91@mail.gmail.com>
  <Pine.LNX.4.63.0606281202360.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0606280435t70ac9957jae2c4d1c10b7681d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 14:56:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvZaQ-0005Ez-VS
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 14:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423286AbWF1Mz5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 08:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423287AbWF1Mz4
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 08:55:56 -0400
Received: from mail.gmx.net ([213.165.64.21]:29146 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1423286AbWF1Mz4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jun 2006 08:55:56 -0400
Received: (qmail invoked by alias); 28 Jun 2006 12:55:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 28 Jun 2006 14:55:54 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0606280435t70ac9957jae2c4d1c10b7681d@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22807>

Hi,

On Wed, 28 Jun 2006, Alex Riesen wrote:

> What stands out next is getRenames (to be renamed into get_renames), a 
> little profiling shows that the renames lists are the culprit this time 
> too.

In my attempts, the path_list did not contain paths, but structs 
containing a path and a void pointer. I think I will resurrect this idea 
for the renames.

Ciao,
Dscho
