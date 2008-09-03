From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] Detached-HEAD reminder on commit?
Date: Wed, 03 Sep 2008 11:16:58 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0809031113580.23787@xanadu.home>
References: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl>
 <200809022339.20123.johan@herland.net>
 <20080902214428.GA20355@sigill.intra.peff.net>
 <200809030945.08619.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Stephan Beyer <s-beyer@gmx.net>,
	Junio C Hamano <gitster@pobox.com>,
	Pieter de Bie <pdebie@ai.rug.nl>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Sep 03 17:18:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kau7d-0004FN-Hv
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 17:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbYICPRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 11:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbYICPRH
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 11:17:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:60726 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbYICPRG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 11:17:06 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K6M007QDL4A582C@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 03 Sep 2008 11:16:58 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <200809030945.08619.johan@herland.net>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94801>

On Wed, 3 Sep 2008, Johan Herland wrote:

> On Tuesday 02 September 2008, Jeff King wrote:
> > On Tue, Sep 02, 2008 at 11:39:20PM +0200, Johan Herland wrote:
> > > I'm not sure I like this personally, but if we _really_ don't want
> > > newbies to shoot themselves in the foot, we could make "git commit"
> > > fail on a detached HEAD unless the user has indicated that s/he knows
> > > what's going on; i.e. something like this:
> >
> > This was discussed to death when detached HEAD was introduced, and the
> > decision was to go with the current behavior. Try looking in the list
> > archives around December 2006 / January 2007 if you are truly
> > masochistic.
> 
> Ok. Scratch that.
> 
> But what happened to the various suggestions in that original thread on 
> adding a safety valve when _leaving_ the detached state (i.e. preventing 
> the user from leaving their detached commits unreachable)?

It has been made unnecessary when the HEAD reflog started recording 
detached head states.


Nicolas
