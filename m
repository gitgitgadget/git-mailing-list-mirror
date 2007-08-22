From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Wed, 22 Aug 2007 13:21:13 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0708221313350.16727@xanadu.home>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz>
 <46CC3C17.8040901@op5.se> <864pirej6w.fsf@lola.quinscape.zz>
 <alpine.LFD.0.999.0708221154150.16727@xanadu.home>
 <Pine.LNX.4.64.0708221713540.20400@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 22 19:21:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INttP-00080v-55
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 19:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933765AbXHVRVR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 13:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933751AbXHVRVP
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 13:21:15 -0400
Received: from relais.videotron.ca ([24.201.245.36]:20622 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933220AbXHVRVO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 13:21:14 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JN600I43QVDC7Y0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 22 Aug 2007 13:21:13 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0708221713540.20400@racer.site>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56403>

On Wed, 22 Aug 2007, Johannes Schindelin wrote:

> Hi,
> 
> On Wed, 22 Aug 2007, Nicolas Pitre wrote:
> 
> > On Wed, 22 Aug 2007, David Kastrup wrote:
> > 
> > > Personally, I would prefer an approach of using an embedded script 
> > > interpreter: then language incompatibilities become a non-issue. 
> > > git-busybox sounded like a great idea for portability.
> > 
> > Indeed.  And while the conversion of some script into C was the right 
> > thing to do performance wise, many other scripts are hardly performance 
> > critical.
> 
> What is wrong with going from shell to C?  C _is_ portable.  Instead of 
> relying on _yet_ another scripting language, introducing _yet_ another 
> language that people have to learn to hack git, introducing _yet_ another 
> place for bugs to hide, why not just admit that shell is nice for 
> _prototyping_?

This is a narrow view of the programming world that I don't share.

C is portable indeed, which is one of its upsides.  But it has many 
downsides too for many _users_, that as a Git _developer_ you apparently 
conveniently ignore.

> Why do we have to to have the same discussion over and over and over 
> again?

Because, as shown by the recurring nature of this discussion, using C for 
everything is evidently not the optimal solution.


Nicolas
