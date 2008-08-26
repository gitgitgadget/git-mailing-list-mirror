From: Nicolas Pitre <nico@cam.org>
Subject: Re: Git-aware HTTP transport
Date: Tue, 26 Aug 2008 13:01:20 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808261255570.1624@xanadu.home>
References: <20080826012643.GD26523@spearce.org> <48B36BCA.8060103@zytor.com>
 <20080826034544.GA32334@spearce.org>
 <alpine.DEB.1.10.0808252052350.29665@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Tue Aug 26 19:03:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY1wf-0003n0-A6
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 19:03:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753401AbYHZRB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 13:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756639AbYHZRB1
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 13:01:27 -0400
Received: from relais.videotron.ca ([24.201.245.36]:32124 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbYHZRB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 13:01:26 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K6700LSNWM8WJB0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 26 Aug 2008 13:01:20 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.DEB.1.10.0808252052350.29665@asgard.lang.hm>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93762>

On Mon, 25 Aug 2008, david@lang.hm wrote:

> and for cloneing (and especially thing like linux-next where you essentially
> re-clone daily) letting the pack get cached is probably a very good thing.

I hope that people recloning linux-next daily are very few.  This is an 
incredible waste of bandwidth, regardless of the protocol used, dumb or 
not.  A standard fetch with a remote tracking branch (with -f or with a 
plus sign on the "fetch" line in your config file) should be all that's 
needed to significantly reduce the amount of data needed to transfer.


Nicolas
