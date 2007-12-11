From: Nicolas Pitre <nico@cam.org>
Subject: Re: v1.5.4 plans
Date: Mon, 10 Dec 2007 22:53:50 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712102249180.555@xanadu.home>
References: <20071022061115.GR14735@spearce.org>
 <7vodeecyni.fsf@gitster.siamese.dyndns.org>
 <7vpryqwtt7.fsf@gitster.siamese.dyndns.org>
 <7vk5ot40w9.fsf@gitster.siamese.dyndns.org>
 <7vy7d43ptc.fsf@gitster.siamese.dyndns.org>
 <7vabpg9x5k.fsf@gitster.siamese.dyndns.org>
 <7vy7cwsi3p.fsf@gitster.siamese.dyndns.org>
 <7vk5o6jbq9.fsf@gitster.siamese.dyndns.org>
 <7v63zjgoel.fsf@gitster.siamese.dyndns.org>
 <7vsl2i6ea4.fsf@gitster.siamese.dyndns.org>
 <7vhcixtnm4.fsf@gitster.siamese.dyndns.org>
 <7vfxye4yv7.fsf@gitster.siamese.dyndns.org>
 <7vve78qhtf.fsf@gitster.siamese.dyndns.org>
 <7vmysijhwq.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 04:54:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1wCF-00040N-Jv
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 04:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbXLKDxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 22:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751740AbXLKDxy
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 22:53:54 -0500
Received: from relais.videotron.ca ([24.201.245.36]:58635 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbXLKDxy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 22:53:54 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSV006AW9HS8560@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 10 Dec 2007 22:53:53 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vmysijhwq.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67783>

On Mon, 10 Dec 2007, Junio C Hamano wrote:

> There are outstanding issues that need to be resolved:
> 
>  * We need to do something about "gc --aggressive".  The documentation
>    removal patch from Linus, if it ever materializes, would be better
>    than nothing, but I have this nagging suspicion that the explosion is
>    merely a bad interation between -A and -f option to the repack, which
>    are not meant to be used together.

Well, with the gcc repo, simply using 'git repack -a -f' with current 
default window size does produce a 2.1GB pack, while changing the window 
size to 100 (keeping default delta depth) produces a 400MB pack for me.

So this is really a matter of not having a sufficiently large window for 
some data sets.

>  * We have a handful deprecation notices in the draft release notes, but
>    if I recall correctly, Nico wanted to add a few more.  We need to
>    come up with a wording that is easy to understand for the end users
>    to decide which ancient versions will be affected.

This is still on my todo list.


Nicolas
