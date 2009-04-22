From: Sam Vilain <sam@vilain.net>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Thu, 23 Apr 2009 10:01:46 +1200
Message-ID: <49EF93CA.20207@vilain.net>
References: <alpine.LFD.2.00.0904070903020.6741@xanadu.home> <20090407142147.GA4413@atjola.homenet> <alpine.LFD.2.00.0904071321520.6741@xanadu.home> <20090407181259.GB4413@atjola.homenet> <alpine.LFD.2.00.0904071454250.6741@xanadu.home> <20090407202725.GC4413@atjola.homenet> <alpine.LFD.2.00.0904080041240.6741@xanadu.home> <20090410T203405Z@curie.orbis-terrarum.net> <alpine.DEB.1.00.0904141749330.10279@pacific.mpi-cbg.de> <alpine.LFD.2.00.0904141542161.6741@xanadu.home> <20090414T202206Z@curie.orbis-terrarum.net> <1240362948.22240.76.camel@maia.lan> <alpine.LFD.2.00.0904221011340.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Nick Edelen <sirnot@gmail.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Apr 23 00:03:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwkXe-0006C7-OP
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 00:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754157AbZDVWCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 18:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753912AbZDVWCB
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 18:02:01 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:53905 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752306AbZDVWCA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 18:02:00 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 897B521C5C0; Thu, 23 Apr 2009 10:01:55 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id E563521C46D;
	Thu, 23 Apr 2009 10:01:49 +1200 (NZST)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <alpine.LFD.2.00.0904221011340.6741@xanadu.home>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117273>

Nicolas Pitre wrote:
>> Now that the GSoC projects have been announced I can give you the good
>> news that one of our two projects is to optimise this stage in
>> git-daemon; I'm hoping we can get it down to being almost as cheap as
>> the workaround you described in your post. I'll certainly be using your
>> repository as a test case :-)
>
> Please keep me in the loop as much as possible. I'd prefer we're not in
> disagreement over the implementation only after final patches are posted
> to the list.

Thanks Nico, given your close working knowledge of the pack-objects
code this will be very much appreciated. Perhaps you can first help
out by telling me what you have to say about moving object enumeration
from upload-pack to pack-objects?

Cheers!
Sam.
