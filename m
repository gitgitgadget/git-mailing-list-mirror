From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git help stage" doesn't display git-stage man page
Date: Thu, 04 Dec 2008 11:37:36 -0800
Message-ID: <7vzljbd94v.fsf@gitster.siamese.dyndns.org>
References: <7vvdu1hj41.fsf@gitster.siamese.dyndns.org>
 <87myfdn2ga.fsf@iki.fi> <7vwsehfzf7.fsf@gitster.siamese.dyndns.org>
 <7vmyfdfyi9.fsf@gitster.siamese.dyndns.org>
 <20081204034203.GA12835@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 04 20:39:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8K2W-0001ih-NY
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 20:39:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbYLDThv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 14:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751730AbYLDThv
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 14:37:51 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47325 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbYLDThu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 14:37:50 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 045C617BD3;
	Thu,  4 Dec 2008 14:37:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AD20C181B5; Thu, 
 4 Dec 2008 14:37:37 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 08F3F4B4-C23B-11DD-8379-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102363>

Jeff King <peff@peff.net> writes:

> On Wed, Dec 03, 2008 at 12:34:22AM -0800, Junio C Hamano wrote:
>
>> diff --git a/Makefile b/Makefile
>> index 9577d6f..5158197 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -320,6 +320,7 @@ BUILT_INS += git-merge-subtree$X
>>  BUILT_INS += git-peek-remote$X
>>  BUILT_INS += git-repo-config$X
>>  BUILT_INS += git-show$X
>> +BUILT_INS += git-stage$X
>>  BUILT_INS += git-status$X
>>  BUILT_INS += git-whatchanged$X
>
> We need this, too, then.

Good catch, thanks.
