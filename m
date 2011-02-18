From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-checkout.txt: improve detached HEAD documentation
Date: Thu, 17 Feb 2011 16:25:38 -0800
Message-ID: <7vmxlu89z1.fsf@alter.siamese.dyndns.org>
References: <1297971966-58500-1-git-send-email-jaysoffian@gmail.com>
 <7v7hcy9vrk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1102171909412.14920@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Feb 18 01:25:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqEAU-000615-Jb
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 01:25:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754947Ab1BRAZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 19:25:49 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44053 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593Ab1BRAZs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 19:25:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AE53E303A;
	Thu, 17 Feb 2011 19:26:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E3SW7hD97hQW0ge4SrK2ymG7shE=; b=VB/o9O
	l5bUshrB+xtUaNFRcDG18gb7Paqgm8dFr7Izb0kOB6+MQZ0UV4sZQqN533NaeKDD
	7GWeBrAjebEjxmMVgwFN/ABDbbVOiVJPAW3TxQyngKKwKIJ7I46MraWGFdzSNu8q
	8rZnjUqgtMoGTYPOP9Dni94Cnw/rSOVcAISoU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xFH3wJBPyljSMC643VA2GEgmMbmYF2vE
	jD4lBc0pCbyzCt027b/M78HNgdjGkYWafR0oN8jYncRH/ftsBa/eanWDty1Dw0i5
	/fUSPzUdumDu6J7AQP0/9U3iGWtX2fRyJhL/KBgp7uBfGwZ9Cc7dtOfup+Dbcizn
	be2QPx6m3bA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7D2403039;
	Thu, 17 Feb 2011 19:26:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 67B7E3034; Thu, 17 Feb 2011
 19:26:47 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1102171909412.14920@xanadu.home> (Nicolas
 Pitre's message of "Thu\, 17 Feb 2011 19\:14\:25 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C7CEDB08-3AF5-11E0-851D-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167139>

Nicolas Pitre <nico@fluxnic.net> writes:

> On Thu, 17 Feb 2011, Junio C Hamano wrote:
> ...
>> You can rectify it by tagging 'c' as a release point and detaching the
>> HEAD at that tag without losing the clarity of the following description.
>> While doing so, it would be better to update the labels in the
>> illustration with s/master/master branch/ and s/[abcde]/commit &/ as well,
>> e.g.
>> 
>> 
>>                    HEAD (refers to branch 'master')
>>                     |
>>                     V
>>   a---b---c---d  branch 'master' (refers to commit 'd')
>>           ^
>>           |
>>      tag 'v2.0' (refers to commit 'c')
>
> While I agree with the above, I think this is still a good idea to keep 
> this example using a non-tagged commit as well.  Perhaps not the first 
> one as you say.

Just to make sure, I wasn't opposed to the idea of showing the history
after building a few commits on top of the point you started from, to
explain why you might want to re-attach the about-to-be-orphaned commits
to the DAG anchored by refs.

IOW, detach at v2.0 tag, experiment with a few commits to fix things up,
and then when things go well, make it a maitenance branch, or something.
