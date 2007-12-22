From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-tag: fix -l switch handling regression.
Date: Sat, 22 Dec 2007 00:01:23 -0800
Message-ID: <7vy7bnyx7w.fsf@gitster.siamese.dyndns.org>
References: <7vwsr8lwf7.fsf@gitster.siamese.dyndns.org>
	<20071221104704.GC17701@artemis.madism.org>
	<20071221105058.GD17701@artemis.madism.org>
	<7vd4t0atzo.fsf@gitster.siamese.dyndns.org>
	<20071221211833.GA10318@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sat Dec 22 09:01:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5zIx-0003bJ-N2
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 09:01:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbXLVIBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 03:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbXLVIBb
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 03:01:31 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49260 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922AbXLVIBa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 03:01:30 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7AF516E8D;
	Sat, 22 Dec 2007 03:01:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 05CD26E8C;
	Sat, 22 Dec 2007 03:01:26 -0500 (EST)
In-Reply-To: <20071221211833.GA10318@artemis.madism.org> (Pierre Habouzit's
	message of "Fri, 21 Dec 2007 22:18:33 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69124>

Pierre Habouzit <madcoder@debian.org> writes:

> On Fri, Dec 21, 2007 at 04:32:43PM +0000, Junio C Hamano wrote:
> ...
>> I thought this depended on some other changes.  As is, doesn't
>> it break the t7004 test?
>
>   Well there are tests that test:
>
>   git tag -n xxx -l ...
>
>   or
>
>   git tag -n "" -l ...
>
>   but I think we agreed those test nothing legitimate, and that the
> tests have to be removed. SO yes it hides another patch to cleanse t7004
> from the broken tests.

Thanks for a clarification; I'll resurect parts of my test
fix-ups and squash that in.
