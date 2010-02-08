From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: [PATCH v3 2/3] git-push: clean up some of the output from git
 push --porcelain
Date: Mon, 8 Feb 2010 18:10:02 -0500
Message-ID: <20100208231002.GA25729@cthulhu>
References: <214a0317f2e4707a866b2f5d10509296bc1479c1.1265661033.git.larry@elder-gods.org>
 <a1b71c9f6566549e6117f5c98c2f1e60754a7334.1265661033.git.larry@elder-gods.org>
 <7vtytrih7b.fsf@alter.siamese.dyndns.org>
 <7vvde7h1mn.fsf@alter.siamese.dyndns.org>
 <20100208213256.GA470@coredump.intra.peff.net>
 <7viqa7cqs9.fsf@alter.siamese.dyndns.org>
 <20100208223107.GB21718@cthulhu>
 <7vpr4f9wey.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 00:10:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeckB-0004m2-CZ
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 00:10:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803Ab0BHXKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 18:10:05 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:35350 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700Ab0BHXKD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 18:10:03 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id EB24B82205A; Mon,  8 Feb 2010 18:10:02 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vpr4f9wey.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139334>

* Junio C Hamano (gitster@pobox.com) [100208 17:48]:
> Larry D'Anna <larry@elder-gods.org> writes:
> 
> > also these
> >
> > X TAB ...
> > ! TAB ...
> > * TAB ...
> > + TAB ...
> > SPACE TAB ...

Actually it won't to 'X'.  print_one_push_status has a case for 'X', but it
never gets called.  

> Is this documented anywhere?

aparnetly not.  patch to follow.

          --larry
