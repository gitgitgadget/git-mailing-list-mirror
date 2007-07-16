From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] vc-git: support asynchronous annotations, and improve versioning.
Date: Mon, 16 Jul 2007 07:29:38 +0200
Message-ID: <85k5t0or0d.fsf@lola.goethe.zz>
References: <403842ba71506c7b194812cd9a4f669c847eb7bc.1184548803.git.dak@gnu.org>
	<cfa5ed80635135dd7544f2b4c6df521a4353e90d.1184548803.git.dak@gnu.org>
	<7v3azpavae.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 07:30:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAJAE-0002Na-HJ
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 07:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764601AbXGPF3m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 01:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764586AbXGPF3m
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 01:29:42 -0400
Received: from mail-in-15.arcor-online.net ([151.189.21.55]:44836 "EHLO
	mail-in-15.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1764555AbXGPF3l (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2007 01:29:41 -0400
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net [151.189.8.20])
	by mail-in-15.arcor-online.net (Postfix) with ESMTP id E93D64455A;
	Mon, 16 Jul 2007 07:29:39 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id D75A4212FB7;
	Mon, 16 Jul 2007 07:29:39 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-040-115.pools.arcor-ip.net [84.61.40.115])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id B6C5719B321;
	Mon, 16 Jul 2007 07:29:39 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id A202B1CE30E9; Mon, 16 Jul 2007 07:29:38 +0200 (CEST)
In-Reply-To: <7v3azpavae.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sun\, 15 Jul 2007 20\:20\:57 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52640>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> (vc-git-symbolic-commit): Allow nil to pass through.
>> (vc-git-previous-version): Use explicit parent argument.
>> (vc-git-next-version): Simplify.
>> (vc-git-annotate-command): Use `vc-do-command'.
>> (vc-git-annotate-extract-revision-at-line): Rename from
>> `vc-annotate-extract-revision-at-line'.
>> (vc-git-checkout): Make nicer way of ensuring encoding.
>>
>
> These do not seem to match what the patch does at all.
> I give up.

The previous changelog entry crept in as well.

> Will apply only the "install .el, too" change from the confusing
> series for now.

Fair enough.

How do I go about resubmitting with better comments?  Make an extra
branch and redo the part in artificial new commits?

I have no experience.  Any good pointers how one does this sort of
propose, rewind, propose stuff most conveniently?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
