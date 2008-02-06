From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] prune: heed --expire for stale packs, add a test
Date: Wed, 06 Feb 2008 09:12:38 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802060910340.2732@xanadu.home>
References: <Pine.GSO.4.63.0802051844220.15867@suma3>
 <alpine.LFD.1.00.0802051357420.2732@xanadu.home>
 <alpine.LSU.1.00.0802052005200.8543@racer.site>
 <alpine.LFD.1.00.0802051512370.2732@xanadu.home>
 <7v7ihi64xm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Steven Tweed <d.s.tweed@reading.ac.uk>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 15:13:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMl1W-00036P-Ts
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 15:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbYBFOMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 09:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbYBFOMl
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 09:12:41 -0500
Received: from relais.videotron.ca ([24.201.245.36]:57180 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbYBFOMk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 09:12:40 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JVT00EUHM52HO20@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 06 Feb 2008 09:12:39 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v7ihi64xm.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72808>

On Tue, 5 Feb 2008, Junio C Hamano wrote:

> They are not "stale packs", but temporary files that wanted to
> become pack but did not succeed.  Perhaps "stale temporary
> packs"?
> 
> Shouldn't we do something similar to objects/pack/pack-*.temp
> files and objects/??/*.temp that http walker leaves?

Instead, I think http walker should be made to use the same location and 
filename pattern for its temporary files as the rest of the code.


Nicolas
