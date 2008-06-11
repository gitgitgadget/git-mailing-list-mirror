From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Wed, 11 Jun 2008 19:21:18 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806111918300.23110@xanadu.home>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil>
 <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil>
 <20080611213648.GA13362@glandium.org>
 <alpine.DEB.1.00.0806112242370.1783@racer>
 <20080611230344.GD19474@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 12 01:22:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6Zdv-00053e-LM
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 01:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754325AbYFKXVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 19:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754281AbYFKXVV
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 19:21:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:24818 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754108AbYFKXVU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 19:21:20 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K2B00DXCNIXO2C0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 11 Jun 2008 19:20:57 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080611230344.GD19474@sigill.intra.peff.net>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84682>

On Wed, 11 Jun 2008, Jeff King wrote:

> I agree. If you are concerned about valuable stashes getting deleted, my
> guess is one of:
> 
>   - you would like reflog expiration to be longer
> 
>   - you are using stash as a long-term storage, which it was never
>     intended for. Use a branch.
> 
> The latter, of course, is based on my use and my impression of others
> use (I almost always apply a stash within 30 seconds of having stashed
> it). So maybe everyone is keeping stashes around for months, and this is
> a useful change.

As you say, branches are there just for that: keeping changes for 
months.  Stashes are not meant to be used like that nor should we 
encourage it.


Nicolas
