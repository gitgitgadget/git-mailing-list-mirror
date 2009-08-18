From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: [PATCH] add -p: do not attempt to coalesce mode changes
Date: Tue, 18 Aug 2009 11:52:58 +0400
Organization: Marine Bridge & Navigation Systems
Message-ID: <20090818075258.GA4501@tugrik.mns.mnsspb.ru>
References: <1250339209-27962-1-git-send-email-kirr@mns.spb.ru> <770693df8f416615f57423141fb59f3d6eccc915.1250344341.git.trast@student.ethz.ch> <20090815141710.GA15978@sigill.intra.peff.net> <200908151635.24341.trast@student.ethz.ch> <7vtz09lz2r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 09:57:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdJZ5-0000gb-D3
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 09:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbZHRH4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 03:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbZHRH4Y
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 03:56:24 -0400
Received: from mail.mnsspb.ru ([84.204.75.2]:36068 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751252AbZHRH4X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 03:56:23 -0400
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1MdJXp-0006NC-1i; Tue, 18 Aug 2009 11:55:49 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1MdJV4-0001CY-6h; Tue, 18 Aug 2009 11:52:58 +0400
Content-Disposition: inline
In-Reply-To: <7vtz09lz2r.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126357>

On Sat, Aug 15, 2009 at 11:19:24AM -0700, Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> 
> > Hmm.  I briefly considered worrying about futureproofing, but then
> > decided it wasn't worth it since we also rely on
> > coalesce_overlapping_hunks only being run over the hunks of a single
> > file.
> 
> Thanks, all.

Thomas, Jeff, Junio,

Thanks for fixing this!
