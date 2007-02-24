From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fixup no-progress for fetch & clone
Date: Fri, 23 Feb 2007 18:14:10 -0800
Message-ID: <7vfy8w1evh.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702232002480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vfy8w3add.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702240217550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<alpine.LRH.0.82.0702232046300.29426@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Feb 24 03:14:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKmQR-0002BF-50
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 03:14:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933339AbXBXCOM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 21:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933340AbXBXCOM
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 21:14:12 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:58243 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933339AbXBXCOM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 21:14:12 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070224021412.OLQH2670.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 23 Feb 2007 21:14:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TEEB1W00C1kojtg0000000; Fri, 23 Feb 2007 21:14:11 -0500
In-Reply-To: <alpine.LRH.0.82.0702232046300.29426@xanadu.home> (Nicolas
	Pitre's message of "Fri, 23 Feb 2007 20:48:12 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40495>

Nicolas Pitre <nico@cam.org> writes:

> On Sat, 24 Feb 2007, Johannes Schindelin wrote:
>
>> Hi,
>> 
>> Since most servers will not have a no-progress aware upload-pack, how 
>> about this? (It is slightly ugly, but at least works...)
>
> Just slightly.
>
> Why not simply filtering any string that ends in '\r' ?

Yes.  I think that I can live with.
