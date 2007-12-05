From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Color support for "git-add -i"
Date: Wed, 05 Dec 2007 11:46:58 -0800
Message-ID: <7v1wa0q5zh.fsf@gitster.siamese.dyndns.org>
References: <7vbq95tnk7.fsf@gitster.siamese.dyndns.org>
	<475697BC.2090701@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Zwell <dzwell@zwell.net>, Jeff King <peff@peff.net>,
	Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Dec 05 20:48:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J00E0-0004F4-VS
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 20:48:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755464AbXLETrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 14:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755632AbXLETrI
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 14:47:08 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:45901 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756239AbXLETrG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 14:47:06 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 3EDCA2F0;
	Wed,  5 Dec 2007 14:47:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id ACAD19D3E3;
	Wed,  5 Dec 2007 14:47:22 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67188>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Junio C Hamano schrieb:
>> +color.interactive::
>> +	When true (or `always`), always use colors in `git add
>> +	--interactive`.  When false (or `never`), never.  When set to
>> +	`auto`, use colors only when the output is to the
>> +	terminal. Defaults to false.
>
> Any particular reason why color.interactive = true should be different from
> color.diff = true? See 57f2b842 ("color.diff = true" is not "always" anymore)

Leftover from the original series.  Thanks for noticing.

We will probably want that "git config --colorbool" thing we discussed
earlier.
