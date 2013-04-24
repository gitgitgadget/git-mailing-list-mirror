From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v2 4/5] check-ignore: allow incremental streaming of
 queries via --stdin
Date: Wed, 24 Apr 2013 09:02:35 +0100
Message-ID: <20130424080235.GC17889@pacific.linksys.moosehall>
References: <20130411110511.GB24296@pacific.linksys.moosehall>
 <1365681913-7059-1-git-send-email-git@adamspiers.org>
 <1365681913-7059-4-git-send-email-git@adamspiers.org>
 <20130411191132.GC3177@sigill.intra.peff.net>
 <20130411203141.GB21091@pacific.linksys.moosehall>
 <7vbo96phmn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 10:02:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUuf5-0002qr-Um
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 10:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757896Ab3DXICi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 04:02:38 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:58413 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757517Ab3DXICg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 04:02:36 -0400
Received: from localhost (d.b.d.8.9.7.2.8.b.4.d.e.3.e.0.4.0.d.3.7.6.a.1.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:11a6:73d0:40e3:ed4b:8279:8dbd])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 93D5C58EB2;
	Wed, 24 Apr 2013 09:02:35 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vbo96phmn.fsf@alter.siamese.dyndns.org>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222235>

On Mon, Apr 22, 2013 at 11:03:44AM -0700, Junio C Hamano wrote:
> Adam Spiers <git@adamspiers.org> writes:
> 
> > On Thu, Apr 11, 2013 at 03:11:32PM -0400, Jeff King wrote:
> >> I always get a little nervous with sleeps in the test suite, as they are
> >> indicative that we are trying to avoid some race condition, which means
> >> that the test can fail when the system is under load, or when a tool
> >> like valgrind is used which drastically alters the timing (e.g., if
> >> check-ignore takes longer than 1 second to produce its answer, we may
> >> fail here).
> >
> > Agreed, especially here where my btrfs filesystems see fit to kindly
> > freeze my system for a few seconds many times each day :-/
> > 
> >> Is there a simpler way to test this?
> >> 
> >> Like:
> >> ...
> > I'll re-roll using your approach.
> 
> I think I missed this one and it already is in 'next'.
> 
> I'll hold it back so please make your re-roll into an incremental
> update.

Will do - will probably take a few days more though, since I'm
currently catching up on a post-travel work backlog.
