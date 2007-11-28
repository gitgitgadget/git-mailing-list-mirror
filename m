From: Junio C Hamano <gitster@pobox.com>
Subject: Re: stgit: lost all my patches again
Date: Tue, 27 Nov 2007 16:37:56 -0800
Message-ID: <7vr6ibb3x7.fsf@gitster.siamese.dyndns.org>
References: <9e4733910711271417l32ed9a77p9915aa34a780665b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 01:38:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxAwb-0000Dg-I0
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 01:38:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758869AbXK1AiE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 19:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758668AbXK1AiD
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 19:38:03 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:43803 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756760AbXK1AiB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 19:38:01 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 7E53B2EF;
	Tue, 27 Nov 2007 19:38:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 0126B9A813;
	Tue, 27 Nov 2007 19:38:19 -0500 (EST)
In-Reply-To: <9e4733910711271417l32ed9a77p9915aa34a780665b@mail.gmail.com>
	(Jon Smirl's message of "Tue, 27 Nov 2007 17:17:12 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66279>

"Jon Smirl" <jonsmirl@gmail.com> writes:

> Can we add a check in "git rebase" so that it will refuse to run if
> stg is active?

The pre-rebase hook has been there since early Feb 2006.
