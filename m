From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: different git-merge behavior with regard to submodules in
	1.6.2.4 vs. 1.6.2.1
Date: Wed, 29 Apr 2009 14:15:06 +0200
Message-ID: <20090429121506.GA1266@pvv.org>
References: <gt7err$3m4$1@ger.gmane.org> <7v4ow8my1u.fsf@gitster.siamese.dyndns.org> <20090428211257.GA31191@pvv.org> <20090429084209.GA24064@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Tim Olsen <tim@brooklynpenguin.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Apr 29 14:15:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz8hC-0005gW-9o
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 14:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbZD2MPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 08:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbZD2MPO
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 08:15:14 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:46171 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbZD2MPN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 08:15:13 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1Lz8gs-0005gI-RF; Wed, 29 Apr 2009 14:15:06 +0200
Content-Disposition: inline
In-Reply-To: <20090429084209.GA24064@localhost>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117877>

On Wed, Apr 29, 2009 at 10:42:09AM +0200, Clemens Buchacher wrote:
[...]
> > git is unfortunately not capable of merging submodules at all, so I
> > added these error messages to give me a hint about what I needed to do
> > in conflicting submodules to get something useful. I have used git a
> > lot more now, so maybe it is time to pick this up again and implement
> > proper recursive sub-module merging.
> 
> Are you sure it's always the right thing to merge conflicting submodule
> versions? The user could easily commit two versions, which you would never
> want merge -- due to changed history, for example. On the other hand, if a
> fast-forward merge is possible I suppose this could be considered a
> non-conflicting change.

I would _like_ git to be able to merge submodules.  However, if we
want to keep limiting sub-modules to only track external independent
3rdparty modules, it isn't so useful I guess. But I also think that
seriously reduces the usefulness of sub-modules.

Maybe a per-submodule flag that indicates whether or not it wants to
be automatically merged from the supermodule? Closely coupled vs
loosely coupled sub-modules.

- Finn Arne
