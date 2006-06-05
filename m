From: Nicolas Pitre <nico@cam.org>
Subject: Re: Horrible re-packing?
Date: Mon, 05 Jun 2006 17:22:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0606051721180.24152@localhost.localdomain>
References: <Pine.LNX.4.64.0606050951120.5498@g5.osdl.org>
 <Pine.LNX.4.64.0606051140530.5498@g5.osdl.org>
 <Pine.LNX.4.64.0606051155000.5498@g5.osdl.org>
 <20060605211436.GA58708@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 05 23:22:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnMWW-0000JZ-Ot
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 23:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbWFEVWF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 17:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWFEVWF
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 17:22:05 -0400
Received: from relais.videotron.ca ([24.201.245.36]:22128 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750900AbWFEVWD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jun 2006 17:22:03 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J0E00G02OOQIKG0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 05 Jun 2006 17:22:02 -0400 (EDT)
In-reply-to: <20060605211436.GA58708@dspnet.fr.eu.org>
X-X-Sender: nico@localhost.localdomain
To: Olivier Galibert <galibert@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21344>

On Mon, 5 Jun 2006, Olivier Galibert wrote:

> On Mon, Jun 05, 2006 at 12:03:31PM -0700, Linus Torvalds wrote:
> > Comments?
> 
> Why don't you just sort the full path+filename with a strcmp variant
> that starts by the end of the string for comparison?  May at least be
> simpler to understand.

Much more expensive for both memory usage and CPU cycles.


Nicolas
