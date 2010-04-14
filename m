From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v2 0/4] A new library for plumbing output
Date: Wed, 14 Apr 2010 13:38:38 -0700
Message-ID: <7vbpdlpy5t.fsf@alter.siamese.dyndns.org>
References: <20100411231824.67460.24844.julian@quantumfyre.co.uk>
 <201004142110.36453.jnareb@gmail.com>
 <7vwrw9q18m.fsf@alter.siamese.dyndns.org>
 <201004142212.33162.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	git@vger.kernel.org, Eric Raymond <esr@thyrsus.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 22:38:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O29MP-0002hD-68
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 22:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756702Ab0DNUiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 16:38:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62536 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756680Ab0DNUiv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 16:38:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 23EB4AA3A7;
	Wed, 14 Apr 2010 16:38:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OqIVUCS7TB0AZJZruHcXH/+v5aY=; b=twGmJy
	YB8rzTwek8CKscqTkaw68PlLN8bBUqqdva35otnCSoQEe2FXN1bAEMYeKvCeq1pJ
	F3jyB/C2hMna0GaTMnqP3XBavDm+7tfVeS20WyXZTwDLbF8nYx9OPIhGnNsGIrro
	ztk1053WmCUTXEwucgEnKEc7ftnZkx0t8Widc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PssL1VZ21FUIrozYP2DL4aWJjOF8hHbx
	RXGmUFJ5ctsSlkwavyPTgQ/qxN7Ze3zjEEtzClyavjJvL73PX/qHi4DkXtL9ZIYS
	TrnvNrrcOFBPwWNELoHpuIXRITr0Jd/E0F5FFzzKIpRUZ7G3Lp4/aQ6TUt3vTan5
	8HkRd+i+0PA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C692DAA379;
	Wed, 14 Apr 2010 16:38:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E893EAA372; Wed, 14 Apr
 2010 16:38:39 -0400 (EDT)
In-Reply-To: <201004142212.33162.jnareb@gmail.com> (Jakub Narebski's message
 of "Wed\, 14 Apr 2010 22\:12\:32 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B8DB989A-4805-11DF-9ED3-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144909>

Jakub Narebski <jnareb@gmail.com> writes:

>> Wouldn't the exact same argument apply equally well to the output format
>> of "status --porcelain", by the way?  It is line-based and pretty much
>> self-describing (once you know the mnemonic but you can make an educated
>> guess from previous SCM experience).
>
> No, current "git status --porcelain" output is record-based (tabular);
> the meaning is not described by header but depends on field in record,
> i.e. position in line.

Now, what's wrong about that?  For that matter, would you say "diff --raw"
output should be JSON/XMLified because it is columnar?
