From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFH] An early draft of v1.5.0 release notes
Date: Wed, 27 Dec 2006 20:44:19 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612272041421.18171@xanadu.home>
References: <200612271300.kBRD082j007703@laptop13.inf.utfsm.cl>
 <7vtzzh5dnv.fsf@assigned-by-dhcp.cox.net>
 <7vbqlo4zg8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 02:44:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzkJk-0003Ee-EU
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 02:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWL1BoV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 20:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWL1BoV
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 20:44:21 -0500
Received: from relais.videotron.ca ([24.201.245.36]:44577 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964845AbWL1BoV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 20:44:21 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JAY00I0WNHVVJE0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 27 Dec 2006 20:44:19 -0500 (EST)
In-reply-to: <7vbqlo4zg8.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35504>

On Wed, 27 Dec 2006, Junio C Hamano wrote:

> Junio C Hamano <junkio@cox.net> writes:
> 
> > "Horst H. von Brand" <vonbrand@inf.utfsm.cl> writes:
> > ...
> >> And what happens to the people who can't/won't display UTF-8? This is a
> >> both a project wide configuration (how does stuff get saved) + a user/local
> >> configuration (how to display stuff).
> > ...
> > Maybe i18n.displayencoding set to latin1 is what you are after?
> > I think it might make sense...
> 
> I've done this and will be pushing the result out in 'next'
> shortly, with a new test.  I find the result mostly sensible.

Shouldn't the LANG environment variable be used for this purpose 
instead?


Nicolas
