From: Joe Perches <joe@perches.com>
Subject: Re: git vs hg commit counts?
Date: Mon, 26 Oct 2009 17:23:05 -0700
Message-ID: <1256602985.29938.18.camel@Joe-Laptop.home>
References: <1256602127.29938.8.camel@Joe-Laptop.home>
	 <7v8wexd6zq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>, git <git@vger.kernel.org>,
	mercurial@selenic.com, Marti Raudsepp <marti@juffo.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755530AbZJ0AXD@vger.kernel.org Tue Oct 27 01:23:24 2009
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755530AbZJ0AXD@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2ZqN-0007os-Dx
	for glk-linux-kernel-3@lo.gmane.org; Tue, 27 Oct 2009 01:23:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755530AbZJ0AXD (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 26 Oct 2009 20:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755334AbZJ0AXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Oct 2009 20:23:02 -0400
Received: from mail.perches.com ([173.55.12.10]:1087 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755059AbZJ0AXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Oct 2009 20:23:01 -0400
Received: from [192.168.1.152] (new-host-2.home [192.168.1.152])
	by mail.perches.com (Postfix) with ESMTP id F23D824368;
	Mon, 26 Oct 2009 16:23:01 -0800 (PST)
In-Reply-To: <7v8wexd6zq.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.28.1 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131292>

On Mon, 2009-10-26 at 17:18 -0700, Junio C Hamano wrote:
> > $ git log --since=1-year-ago -- MAINTAINERS | \
> > 	grep -P "^commit [0-9a-f]{40,40}$"  | wc -l
> > 514
> > $ hg log --template="commit {node}\n" --date -365 -- MAINTAINERS  | \
> > 	grep -P "^commit [0-9a-f]{40,40}$" | wc -l
> > 601
> > Anyone have any understanding why?
> We simplify a merge history by discarding one branch when the merge result
> matches one of the parents.

Thanks Junio.

> Does "hg" know how to do that as well?

I don't know.

I was hoping to get equivalent results though.

Anyone know how?
