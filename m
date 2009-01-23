From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2009, #05; Wed, 21)
Date: Thu, 22 Jan 2009 22:23:30 -0800
Message-ID: <7vr62u35i5.fsf@gitster.siamese.dyndns.org>
References: <7vab9kataf.fsf@gitster.siamese.dyndns.org>
 <200901212321.50526.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Fri Jan 23 07:25:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQFTz-0003X2-2V
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 07:25:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763345AbZAWGXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 01:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763337AbZAWGXg
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 01:23:36 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61523 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762171AbZAWGXf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 01:23:35 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id F350C1D1F2;
	Fri, 23 Jan 2009 01:23:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 479751D1F1; Fri,
 23 Jan 2009 01:23:31 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5D005366-E916-11DD-9F48-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106843>

"Boyd Stephen Smith Jr." <bss@iguanasuicide.net> writes:

>>* js/diff-color-words (Tue Jan 20 21:46:57 2009 -0600) 8 commits
>> + color-words: Support diff.wordregex config option
>> + color-words: make regex configurable via attributes
>> + color-words: expand docs with precise semantics
>> + color-words: enable REG_NEWLINE to help user
>> + color-words: take an optional regular expression describing words
>> + color-words: change algorithm to allow for 0-character word
>>   boundaries
>> + color-words: refactor word splitting and use ALLOC_GROW()
>> + Add color_fwrite_lines(), a function coloring each line
>>   individually
>
> I think my patch in 
> http://thread.gmane.org/gmane.comp.version-control.git/106567 should be 
> applied to the top of this.

Thanks.
