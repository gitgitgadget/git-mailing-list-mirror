From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [NEW REPLACEMENT PATCH] git-checkout: Add a test case for relative paths use.
Date: Thu, 08 Nov 2007 12:48:37 -0800
Message-ID: <7v7iks31lm.fsf@gitster.siamese.dyndns.org>
References: <11945276321726-git-send-email-dsymonds@gmail.com>
	<Pine.LNX.4.64.0711081427450.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	Andreas Ericsson <ae@op5.se>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 08 21:49:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqEJH-00072t-9r
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 21:49:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759853AbXKHUsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 15:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761229AbXKHUst
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 15:48:49 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:35406 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759847AbXKHUst (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 15:48:49 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id C0B902F9;
	Thu,  8 Nov 2007 15:49:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 360FA939AA;
	Thu,  8 Nov 2007 15:49:06 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711081427450.4362@racer.site> (Johannes
	Schindelin's message of "Thu, 8 Nov 2007 14:32:52 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64071>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> +	mkdir dir2 &&
>> +	echo bonjour > dir2/file2 &&
>> +	git add dir2/file2 &&
>> +	git commit -m "populate tree"
>> +
>> +'
>
> Please lose the empty line before the closing quote.  (This applies to all 
> tests.)

I personaly find the extra blank lines before and after the
indented test body easier to read.  That is..


	test_expect_sucess 'test description comes here' '

		test command 1 &&
		test command 2 &&
                ...
                test command N

	'

I agree with all other suggestions from your message.
