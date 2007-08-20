From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-stash segfaults ...
Date: Mon, 20 Aug 2007 13:44:22 -0700
Message-ID: <7vmywmrl5l.fsf@gitster.siamese.dyndns.org>
References: <20070820174427.GC7206@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Aug 20 22:44:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INE7B-0003pN-3q
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 22:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761297AbXHTUo0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 16:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759875AbXHTUo0
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 16:44:26 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:38192 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760858AbXHTUoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 16:44:25 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id ABC5D124F6F;
	Mon, 20 Aug 2007 16:44:45 -0400 (EDT)
In-Reply-To: <20070820174427.GC7206@artemis.corp> (Pierre Habouzit's message
	of "Mon, 20 Aug 2007 19:44:27 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56256>

Pierre Habouzit <madcoder@debian.org> writes:

>   When you don't use it from the root of the tree: I was in a subdir of
> my git tree, trying to do:
>
>   git stash apply
>
>   and I had:
>
>   $ git stash apply
>   error: missing object referenced by
>   '0ca54c1fba7fea7dca8a1cc59bce2b2849f26d20' Segmentation fault
>
>   going in the root of the repository (where .git is), all went fine.

I think this was fixed on Jul 25 with ceff079b and 1.5.3-rc4
should have it.
