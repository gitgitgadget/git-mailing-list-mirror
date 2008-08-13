From: Nicolas Pitre <nico@cam.org>
Subject: Re: pack operation is thrashing my server
Date: Wed, 13 Aug 2008 10:37:50 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808131036590.4352@xanadu.home>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
 <20080811030444.GC27195@spearce.org>
 <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com>
 <87vdy71i6w.fsf@basil.nowhere.org>
 <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com>
 <20080813031503.GC5855@spearce.org>
 <70550C21-8358-4BEF-A7BA-3A41C1ACB346@adacore.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>,
	git@vger.kernel.org
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 16:39:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTHV6-0004xI-Ay
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 16:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688AbYHMOh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 10:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbYHMOh4
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 10:37:56 -0400
Received: from relais.videotron.ca ([24.201.245.36]:34251 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbYHMOh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 10:37:56 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K5J00LXSNB2WP40@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 13 Aug 2008 10:37:50 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <70550C21-8358-4BEF-A7BA-3A41C1ACB346@adacore.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92221>

On Tue, 12 Aug 2008, Geert Bosch wrote:

> One nice optimization we could do for those pesky binary large objects
> (like PDF, JPG and GZIP-ed data), is to detect such files and revert
> to compression level 0. This should be especially beneficial
> since already compressed data takes most time to compress again.

That would be a good thing indeed.


Nicolas
