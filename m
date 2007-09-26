From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-commit --amend: respect grafted parents.
Date: Wed, 26 Sep 2007 11:50:24 -0700
Message-ID: <7vd4w51csv.fsf@gitster.siamese.dyndns.org>
References: <11908086961933-git-send-email-johannes.sixt@telecom.at>
	<Pine.LNX.4.64.0709261322150.28395@racer.site>
	<46FA5604.101@viscovery.net>
	<Pine.LNX.4.64.0709261501190.28395@racer.site>
	<46FA6CD7.1020709@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>, gitster@pobox.com,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Sep 26 20:50:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iaby4-0000ke-Vm
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 20:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754502AbXIZSue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 14:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754657AbXIZSue
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 14:50:34 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:40494 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754241AbXIZSud (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 14:50:33 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 8B03813AD18;
	Wed, 26 Sep 2007 14:50:48 -0400 (EDT)
In-Reply-To: <46FA6CD7.1020709@viscovery.net> (Johannes Sixt's message of
	"Wed, 26 Sep 2007 16:29:43 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59239>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Johannes Schindelin schrieb:
>> The reason why I insist on not putting this into --amend is that I
>> think this is not really an amend, but actively a rewrite of the
>> merge commit.
>
> You have a point here. I'm convinced. Scrap the patch.

I am slow today.  Since when --amend is not about "a rewrite of
commit"?
