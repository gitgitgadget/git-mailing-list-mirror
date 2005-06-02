From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Handle deltified object correctly in git-*-pull family.
Date: Wed, 01 Jun 2005 20:47:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0506012045190.17354@localhost.localdomain>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
 <Pine.LNX.4.62.0505301644430.5330@localhost.localdomain>
 <7vacmapo18.fsf@assigned-by-dhcp.cox.net>
 <7vu0kilc21.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0506011032570.7439@localhost.localdomain>
 <7vpsv6kqx0.fsf@assigned-by-dhcp.cox.net>
 <7v1x7lk8fl.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>,
	"Daniel Barkalow <barkalow@iabervon.org> Git Mailing List" 
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 02 02:46:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dddq2-000708-VD
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 02:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVFBAs2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 20:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVFBAs2
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 20:48:28 -0400
Received: from relais.videotron.ca ([24.201.245.36]:48474 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261263AbVFBAsZ
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Jun 2005 20:48:25 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR007.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IHF00DJFM7KO1@VL-MO-MR007.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 01 Jun 2005 20:47:44 -0400 (EDT)
In-reply-to: <7v1x7lk8fl.fsf_-_@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 1 Jun 2005, Junio C Hamano wrote:

> *** Dan and Nico, could you check this for correctness?  I've
> *** tested it with a deltified core GIT repository and pulling
> *** with local-pull from there.  I have verified that a pull
> *** that fails with -d flag retrieves the right base-object to
> *** complete a deltified ones.

The delta part looks fine to me.


Nicolas
