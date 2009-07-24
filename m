From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] git-add -p: be able to undo a given hunk
Date: Fri, 24 Jul 2009 19:32:07 +0900
Message-ID: <20090724193207.6117@nanako3.lavabit.com>
References: <20090723074104.GI4750@laphroaig.corp> <7veis7yxwx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Pierre Habouzit <madcoder@debian.org>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 12:33:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUI5M-00083Q-Im
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 12:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbZGXKcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 06:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752350AbZGXKcs
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 06:32:48 -0400
Received: from karen.lavabit.com ([72.249.41.33]:43464 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752284AbZGXKcr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 06:32:47 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 6236411B7E2;
	Fri, 24 Jul 2009 05:32:47 -0500 (CDT)
Received: from 4104.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id 12KI257A9OUF; Fri, 24 Jul 2009 05:32:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=0wnKfrPnsbi8knY7Y9mrXQD3OBqscJlmq8k58V0Nw0scwSyB9IG0YmLOnvHGWELPtGwajwVib87Zd0Qi5F8qDJ9Sl94tZ0A7SWnKteaVvkO1kUQk5q/yh1yn0BMLo0qSsxRvwPbqa7i9PzKf1L9MG3DlJDZhaYIPXob6BfX8Q0k=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7veis7yxwx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123915>

Quoting Junio C Hamano <gitster@pobox.com>

> I fear tempting a new user who sees "undo" to say "yeah, I added the
> change in this hunk to the index by mistake, please undo", which would
> lose the work.  The confusion is easier to avoid if "add" only manipulates
> the index without harming the work tree, and the user used a different
> command, namely "checkout from the index", to get rid of the remaining
> debug cruft, once s/he added all the necessary bits to the index perhaps
> after a multi-stage commit session.

I can see your argument that this might introduce more danger for newbies. As you said yourself number of times, nobody will stay being a newbie forever, and I don't think it is wise to reject a feature that is very handy for experts based solely on such a fear.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
