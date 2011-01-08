From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [RFD] My thoughts about implementing gitweb output caching
Date: Fri, 07 Jan 2011 21:46:30 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101072142550.22191@xanadu.home>
References: <201101080042.36156.jnareb@gmail.com>
 <20110108002643.GD15495@burratino>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	"J.H." <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 08 03:53:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbOvp-0002Hs-Qw
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 03:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385Ab1AHCqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 21:46:31 -0500
Received: from relais.videotron.ca ([24.201.245.36]:56059 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab1AHCqb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 21:46:31 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz24.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LEO00CTNNOYEF90@vl-mo-mrz24.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 07 Jan 2011 21:46:10 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20110108002643.GD15495@burratino>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164804>

On Fri, 7 Jan 2011, Jonathan Nieder wrote:

> > With output caching gitweb can also support 'Range' requests, which
> > means that it would support resumable download.  This would mean hat we
> > would be able to resume downloading of snapshot (or in the future
> > bundle)... if we cannot do this now.  This would require some more code
> > to be added.
> 
> Exciting stuff.
> 
> Teaching gitweb to generate bundles sounds like a recipe for high server
> loads, though.  I suspect manual (or by cronjob) generation would work
> better, with a possible exception of very frequently cloned and
> infrequently pushed-to repos like linus's linux-2.6.

Even for Linus' linux repo, it is not a good idea to auto create bundle, 
except maybe once every major release which is every 3 months or so.  I 
really don't think this is a good idea to put this in the realm of 
gitweb caching.


Nicolas
