From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] git-branch -v: show the remote tracking statistics
Date: Wed, 02 Jul 2008 01:42:49 -0700
Message-ID: <7vwsk4d6d2.fsf@gitster.siamese.dyndns.org>
References: <20080701091347.GA11817@elte.hu> <80iqvq2bw0.fsf@tiny.isode.net>
 <20080701101414.GG31309@elte.hu> <7vlk0lmn32.fsf@gitster.siamese.dyndns.org>
 <7vhcb8en92.fsf@gitster.siamese.dyndns.org> <486B3B05.4080006@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>,
	Bruce Stephens <bruce.stephens@isode.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jul 02 10:44:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDxwa-0004pA-Gf
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 10:44:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752924AbYGBInH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 04:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752427AbYGBInG
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 04:43:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50706 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934AbYGBInF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 04:43:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F4001287CB;
	Wed,  2 Jul 2008 04:43:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2448F287CA; Wed,  2 Jul 2008 04:42:56 -0400 (EDT)
In-Reply-To: <486B3B05.4080006@viscovery.net> (Johannes Sixt's message of
 "Wed, 02 Jul 2008 10:23:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E1710230-4812-11DD-AB6C-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87117>

Johannes Sixt <j.sixt@viscovery.net> writes:

> What do you think about showing the tracking information only if --track
> is supplied? But then even write more information:
>
> * jc/report-tracking   41666f7 diverged 3 vs. 117
>   foo                  1234567 behind 22
>   bar                  fedcba9 ahead 6
>
> and filter the output to show only tracking branches.

I am not sure about the use of --track option, but now the infrastructure
is clean enough for anybody to paint it in his favorite color, and I do
not care deeply about how it would look like.  Discuss away and give me an
applicable patch that the list has concensus on, and I'll apply it.
