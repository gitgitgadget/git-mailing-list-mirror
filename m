From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] the ar tool is called gar on some systems
Date: Tue, 02 Oct 2007 21:55:23 -0700
Message-ID: <7vlkakhk5g.fsf@gitster.siamese.dyndns.org>
References: <20071003014934.GF20753@schiele.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robert Schiele <rschiele@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 06:55:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcwGo-0005Ib-JK
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 06:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbXJCEza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 00:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbXJCEza
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 00:55:30 -0400
Received: from rune.pobox.com ([208.210.124.79]:36202 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235AbXJCEza (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 00:55:30 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 7DF851409FF;
	Wed,  3 Oct 2007 00:55:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 9034C1409CC;
	Wed,  3 Oct 2007 00:55:47 -0400 (EDT)
In-Reply-To: <20071003014934.GF20753@schiele.dyndns.org> (Robert Schiele's
	message of "Wed, 3 Oct 2007 03:49:34 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59784>

Robert Schiele <rschiele@gmail.com> writes:

> Some systems that have only installed the GNU toolchain (prefixed with "g")
> do not provide "ar" but only "gar".  Make configure find this tool as well.
>
> Signed-off-by: Robert Schiele <rschiele@gmail.com>
> ---
> I sent that some weeks ago but it seems it got lost.

I still have the original one in my mailbox.  Hasn't applied as
we hadn't heard anybody cheering or thanking for the patch, but
I do not see anything _wrong_ with it, so let's apply.
