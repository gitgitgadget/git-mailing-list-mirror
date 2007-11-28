From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Replace misleading message during interactive rebasing
Date: Tue, 27 Nov 2007 20:37:01 -0800
Message-ID: <7vve7n9eaa.fsf@gitster.siamese.dyndns.org>
References: <1196111891-18518-1-git-send-email-win@wincent.com>
	<474BD5CA.7050407@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org,
	tsuna@lrde.epita.fr, Johannes.Schindelin@gmx.de,
	mcostalba@gmail.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 13:33:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxKwS-0004cg-8b
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 12:18:56 +0100
Received: from mail-mx4.uio.no ([129.240.10.45])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxEo7-0004aO-PZ
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 05:45:55 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx4.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxEny-0001hB-OV
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 05:45:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754892AbXK1Eh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 23:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755909AbXK1Eh1
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 23:37:27 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:37619 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755104AbXK1EhS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 23:37:18 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id F1B582F0;
	Tue, 27 Nov 2007 23:37:36 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 60B889A945;
	Tue, 27 Nov 2007 23:37:30 -0500 (EST)
In-Reply-To: <474BD5CA.7050407@viscovery.net> (Johannes Sixt's message of
	"Tue, 27 Nov 2007 09:31:06 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-6.1, required=5.0, autolearn=disabled, AWL=0.903,RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: 44CED65289E174831C7DBB4FF7B316E1DFAF1D90
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -60 maxlevel 200 minaction 2 bait 0 mail/h: 44 total 723811 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66303>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Wincent Colaiuta schrieb:
>> +		export _GIT_CHERRY_PICK_HELP="run 'git rebase --continue'"
>
> Isn't this a bashism?

Being an old-fashioned shell programmer myself, "export VAR=VAL" does
raise my eyebrows.  It is in POSIX but are there shells that we do
support (dash, bash, ksh -- /bin/sh on Solaris does not count) that
want their exports old-fashioned way?
