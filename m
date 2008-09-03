From: Petr Baudis <pasky@suse.cz>
Subject: Re: pack count on repo.or.cz [was "Medium term dreams"]
Date: Wed, 3 Sep 2008 12:08:28 +0200
Message-ID: <20080903100828.GS10360@machine.or.cz>
References: <7vsksjsbcc.fsf@gitster.siamese.dyndns.org> <20080902000037.GA11869@coredump.intra.peff.net> <20080902010410.GI10360@machine.or.cz> <20080902011433.GA12682@coredump.intra.peff.net> <20080902111531.GL10360@machine.or.cz> <20080902115424.GA11303@coredump.intra.peff.net> <20080902130801.GN10360@machine.or.cz> <48BD446C.6020403@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Sep 03 12:09:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KapIz-0003gZ-O0
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 12:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbYICKIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 06:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751783AbYICKIg
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 06:08:36 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50304 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751664AbYICKIf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 06:08:35 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 4D3413939B4B; Wed,  3 Sep 2008 12:08:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48BD446C.6020403@viscovery.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94782>

On Tue, Sep 02, 2008 at 03:49:32PM +0200, Johannes Sixt wrote:
> Petr Baudis schrieb:
> >> As to why the other packs weren't pruned, I don't know. In my example,
> >> you can see that the pruning happens as we expect. So either there is a
> >> bug in git-prune-packed, or there is something we're not realizing.
> > 
> > Well, that's my question here. :-)
> 
> Does removing all the *.keep files help? ;)

Haha, good catch - thanks! :-) I wonder where they came from, though I
hazily remember some curious behaviour of older Git versions wrt. .keep
files and they seem all to be of old date. Now I have a single nice pack
and fsck of all the forks still passes fine.

Thanks all, I will adopt this for all projects.

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
