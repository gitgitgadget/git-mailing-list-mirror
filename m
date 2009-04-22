From: Sam Vilain <sam@vilain.net>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Wed, 22 Apr 2009 13:15:48 +1200
Message-ID: <1240362948.22240.76.camel@maia.lan>
References: <alpine.LFD.2.00.0904070903020.6741@xanadu.home>
	 <20090407142147.GA4413@atjola.homenet>
	 <alpine.LFD.2.00.0904071321520.6741@xanadu.home>
	 <20090407181259.GB4413@atjola.homenet>
	 <alpine.LFD.2.00.0904071454250.6741@xanadu.home>
	 <20090407202725.GC4413@atjola.homenet>
	 <alpine.LFD.2.00.0904080041240.6741@xanadu.home>
	 <20090410T203405Z@curie.orbis-terrarum.net>
	 <alpine.DEB.1.00.0904141749330.10279@pacific.mpi-cbg.de>
	 <alpine.LFD.2.00.0904141542161.6741@xanadu.home>
	 <20090414T202206Z@curie.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Wed Apr 22 03:17:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwR5w-0005RJ-OC
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 03:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752666AbZDVBQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 21:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752591AbZDVBQP
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 21:16:15 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:60840 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752435AbZDVBQO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 21:16:14 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 7DF2221C37C; Wed, 22 Apr 2009 13:15:54 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.182] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 8AF4221C31F;
	Wed, 22 Apr 2009 13:15:34 +1200 (NZST)
In-Reply-To: <20090414T202206Z@curie.orbis-terrarum.net>
X-Mailer: Evolution 2.24.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117165>

On Tue, 2009-04-14 at 13:27 -0700, Robin H. Johnson wrote:
> On Tue, Apr 14, 2009 at 04:17:55PM -0400, Nicolas Pitre wrote:
> > WRT the HTTP protocol, I was questioning git's ability to resume the 
> > transfer of a pack in the middle if such transfer is interrupted without 
> > redownloading it all. And Mike Hommey says this is actually the case.
> With rsync:// it was helpful to split the pack, and resume there worked
> reasonably (see my other mail about the segfault that turns up
> sometimes).
> 
> More recent discussions raised the possibility of using git-bundle to
> provide a more ideal initial download that they CAN resume easily, as
> well as being able to move on from it.

Hey Robin,

Now that the GSoC projects have been announced I can give you the good
news that one of our two projects is to optimise this stage in
git-daemon; I'm hoping we can get it down to being almost as cheap as
the workaround you described in your post.  I'll certainly be using your
repository as a test case :-)

So stay tuned!
Sam.
