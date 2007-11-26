From: Nicolas Pitre <nico@cam.org>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 16:35:18 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711261631170.9605@xanadu.home>
References: <200711252248.27904.jnareb@gmail.com>
 <858x4l2apc.fsf@lola.goethe.zz>
 <alpine.LFD.0.99999.0711261417580.9605@xanadu.home>
 <854pf8243i.fsf@lola.goethe.zz> <20071126195750.GD25784@efreet.light.src>
 <AA5ECB69-3F77-483E-AD19-04A5515779B3@wincent.com>
 <7vhcj8g0op.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Wincent Colaiuta <win@wincent.com>, Jan Hudec <bulb@ucw.cz>,
	David Kastrup <dak@gnu.org>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 22:43:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwlkB-0003Rk-7Y
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 22:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754785AbXKZVnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 16:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753341AbXKZVnT
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 16:43:19 -0500
Received: from relais.videotron.ca ([24.201.245.36]:9048 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754756AbXKZVnT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 16:43:19 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JS400HK2UMU3S41@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 26 Nov 2007 16:35:20 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vhcj8g0op.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66134>

On Mon, 26 Nov 2007, Junio C Hamano wrote:

> Wincent Colaiuta <win@wincent.com> writes:
> 
> > For the benefit of newcomers, I just wish the plumbing was kept a  
> > little bit out of sight. You know, porcelain in /usr/bin and plumbing  
> > in /usr/libexec or other such place.
> >
> > It's fine once you've learnt your workflows and know the 10 or 15 Git  
> > tools that you'll be using day-to-day; but for people who are just  
> > starting off this can be a little bit intimidating:
> >
> > $ git-<tab>
> > Display all 146 possibilities? (y or n)
> 
> I'd agree to that but I've always considered this an issue for distros.
> We've supported an ability for them to specify a gitexecdir separate
> from /usr/bin in our Makefile for almost two years.

Would probably be a good thing to start enforcing that by default. It's 
easier to follow such policies when they're coordinated from the project 
origin.


Nicolas
