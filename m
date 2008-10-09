From: Nicolas Pitre <nico@cam.org>
Subject: Re: fetch fails with a short read of received pack
Date: Thu, 09 Oct 2008 16:31:06 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810091629520.26244@xanadu.home>
References: <20081009195518.GA1497@blimp.localhost>
 <2008-10-09-22-24-15+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Thu Oct 09 22:32:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko2BN-00014P-Mt
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 22:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754950AbYJIUbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 16:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754877AbYJIUbO
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 16:31:14 -0400
Received: from relais.videotron.ca ([24.201.245.36]:18743 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754428AbYJIUbO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 16:31:14 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K8H00A0CNMUQ5H0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 09 Oct 2008 16:30:32 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <2008-10-09-22-24-15+trackit+sam@rfc1149.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97883>

On Thu, 9 Oct 2008, Samuel Tardieu wrote:

> >>>>> "Alex" == Alex Riesen <raa.lkml@gmail.com> writes:
> 
> Alex> Somehow I got my gnulib mirror to a strange state where I can't
> Alex> fetch anything from it:
> 
> You're the third person to report this problem in three days (I was
> the second one). I thought my repository or the upstream one (GCC) was
> corrupted in some ways, but it looks like a general problem.

Alex has a good test case and his bissection points at me.
So I'm on it.


Nicolas
