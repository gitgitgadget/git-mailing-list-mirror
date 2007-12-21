From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-tag: fix -l switch handling regression.
Date: Fri, 21 Dec 2007 08:32:43 -0800
Message-ID: <7vd4t0atzo.fsf@gitster.siamese.dyndns.org>
References: <7vwsr8lwf7.fsf@gitster.siamese.dyndns.org>
	<20071221104704.GC17701@artemis.madism.org>
	<20071221105058.GD17701@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Dec 21 17:33:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5koX-0007mx-8y
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 17:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331AbXLUQc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 11:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752539AbXLUQc5
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 11:32:57 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:32924 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbXLUQc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 11:32:56 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E41F554DA;
	Fri, 21 Dec 2007 11:32:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8370954D9;
	Fri, 21 Dec 2007 11:32:50 -0500 (EST)
In-Reply-To: <20071221105058.GD17701@artemis.madism.org> (Pierre Habouzit's
	message of "Fri, 21 Dec 2007 11:50:58 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69071>

Pierre Habouzit <madcoder@debian.org> writes:

> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>
> It seems that you didnt took that patch either, that IMHO gives a better
> semantics to git tag -l than yours, while keeping backward
> compatibility.

I thought this depended on some other changes.  As is, doesn't
it break the t7004 test?
