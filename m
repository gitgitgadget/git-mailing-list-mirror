From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git sequencer prototype
Date: Tue, 01 Jul 2008 01:51:44 -0700
Message-ID: <7vabh2oulb.fsf@gitster.siamese.dyndns.org>
References: <1214879914-17866-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Tue Jul 01 10:52:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDbbX-000238-M1
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 10:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753569AbYGAIvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 04:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752895AbYGAIvw
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 04:51:52 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37507 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190AbYGAIvw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 04:51:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B49B21D55E;
	Tue,  1 Jul 2008 04:51:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 04DEA1D55D; Tue,  1 Jul 2008 04:51:46 -0400 (EDT)
In-Reply-To: <1214879914-17866-1-git-send-email-s-beyer@gmx.net> (Stephan
 Beyer's message of "Tue, 1 Jul 2008 04:38:30 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F22E803E-474A-11DD-8409-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87009>

Stephan Beyer <s-beyer@gmx.net> writes:

> I'm using sequencer-based git-am and git-rebase-i and also git-sequencer
> itself for around 2-3 weeks now. So, for me, it is reality-proven, but
> I'm curious about your opinions/suggestions in usage and source.

Thanks.

> The migration patches are a little hard to code-review in the diff-form,
> but feel free to apply, test, and then look at the code ;)

Heh, these three typically come in different order.  Look at the log
message and docs to see if the design is sound, then look at the code, and
if things overall look Ok, then finally apply and test.

I unfortunately ran out of time tonight and will look at them probably
Thursday evening.  It seems that another GSoC topic is finally nearing
completion and I can shift my attention to other topics now.

By the way Christian is not CC'ed?
