From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 7/6] Enable threaded async procedures whenever pthreads
	is available
Date: Tue, 9 Mar 2010 15:43:17 -0800
Message-ID: <20100309234317.GA12958@spearce.org>
References: <cover.1267889072.git.j6t@kdbg.org> <7vk4tpdx9x.fsf@alter.siamese.dyndns.org> <20100306215051.GE2529@spearce.org> <201003092100.36616.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Mar 10 00:43:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Np95F-0007dl-Rg
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 00:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755066Ab0CIXnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 18:43:25 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56752 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323Ab0CIXnY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 18:43:24 -0500
Received: by gyd8 with SMTP id 8so252730gyd.19
        for <git@vger.kernel.org>; Tue, 09 Mar 2010 15:43:21 -0800 (PST)
Received: by 10.101.193.30 with SMTP id v30mr158051anp.199.1268178199809;
        Tue, 09 Mar 2010 15:43:19 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm6043966iwn.3.2010.03.09.15.43.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Mar 2010 15:43:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201003092100.36616.j6t@kdbg.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141856>

Johannes Sixt <j6t@kdbg.org> wrote:
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> On Samstag, 6. M?rz 2010, Shawn O. Pearce wrote:
> > I'm in favor of that.  If we have threaded delta search enabled,
> > we probably can also run these async procedures in a POSIX thread
> > rather than forking off a child.
> 
> OK. The patch could look like this.

Looks fine to me.  But given my earlier statement about xmalloc()
damage... I wonder if we shouldn't try to ensure that isn't a
problem first.

-- 
Shawn.
