From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Re: [patch 02/16] const-expr.patch
Date: Tue, 27 Apr 2010 14:32:04 +0000
Message-ID: <20100427143204.GA36271@thor.il.thewrittenword.com>
References: <20100427135708.258636000@mlists.thewrittenword.com>
 <20100427135812.656626000@mlists.thewrittenword.com>
 <l2t40aa078e1004270708w905ae1e1lbead0f21acc70dee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Apr 27 16:32:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6lpd-0006pL-TR
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 16:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755950Ab0D0OcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 10:32:08 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:59795 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755763Ab0D0OcG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 10:32:06 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 194495C09;
	Tue, 27 Apr 2010 14:53:12 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 194495C09
Received: from thor.il.thewrittenword.com (thor.il.thewrittenword.com [10.191.57.1])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 4736BA1E;
	Tue, 27 Apr 2010 14:32:04 +0000 (UTC)
Received: by thor.il.thewrittenword.com (Postfix, from userid 1048)
	id 41609BAB3; Tue, 27 Apr 2010 14:32:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <l2t40aa078e1004270708w905ae1e1lbead0f21acc70dee@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145921>

On Tue, Apr 27, 2010 at 04:08:24PM +0200, Erik Faye-Lund wrote:
> On Tue, Apr 27, 2010 at 3:57 PM, Gary V. Vaughan
> <git@mlists.thewrittenword.com> wrote:
> > Index: b/unpack-trees.c
> > ===================================================================
> > --- a/unpack-trees.c
> > +++ b/unpack-trees.c
> > @@ -287,9 +287,11 @@ static void add_same_unmerged(struct cac
> > ?static int unpack_index_entry(struct cache_entry *ce,
> > ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct unpack_trees_options *o)
> > ?{
> > - ? ? ? struct cache_entry *src[5] = { ce, NULL, };
> > + ? ? ? struct cache_entry *src[5] = { NULL, NULL };
> 
> You don't need NULL twice when the array-size is specified, it's just
> confusing as the array has 5 elements. [[..and 2 other similar
> instances...]]

Thanks, agreed.  I won't spam the list with another copy of the patch
with such straight forward changes though.

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)
