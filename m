From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH v2] Custom compression levels for objects and packs
Date: Tue, 08 May 2007 21:03:37 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705082031370.24220@xanadu.home>
References: <4640FBDE.1000609@gmail.com>
 <7vk5vi27ko.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.99.0705082010230.24220@xanadu.home>
 <56b7f5510705081729t34a585c6y9ca9e2f9963d24a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 09 03:03:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlaaw-0003o6-LV
	for gcvg-git@gmane.org; Wed, 09 May 2007 03:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968408AbXEIBDt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 21:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968430AbXEIBDt
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 21:03:49 -0400
Received: from relais.videotron.ca ([24.201.245.36]:61175 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968408AbXEIBDs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 21:03:48 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JHR003051M1V230@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 08 May 2007 21:03:40 -0400 (EDT)
In-reply-to: <56b7f5510705081729t34a585c6y9ca9e2f9963d24a2@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46647>

On Tue, 8 May 2007, Dana How wrote:

> On 5/8/07, Nicolas Pitre <nico@cam.org> wrote:
> > On Tue, 8 May 2007, Junio C Hamano wrote:
> > If we want the fallback logic to work, at some point we must remember if
> > the current value is the default or if it is the result of an explicit
> > config option.
> I can leave as-is, or use a magic value like -99 and
> depend on it not colliding with values in zlib.h.

And where would you set those variables to a sensible default in the 
absence of any config option?


Nicolas
