From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: allow some defaults to be specified via git-config
Date: Fri, 16 Oct 2009 17:50:35 -0700
Message-ID: <7v3a5iq1wk.fsf@alter.siamese.dyndns.org>
References: <1255650627-17576-1-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nigel McNie <nigel@catalyst.net.nz>
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sat Oct 17 02:50:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyxVT-0001XD-Ib
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 02:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbZJQAul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 20:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbZJQAul
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 20:50:41 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48283 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683AbZJQAuk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 20:50:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DAEC77A065;
	Fri, 16 Oct 2009 20:50:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=9pjKp1DA5WY2KNtHs+8TNTz/IO0=; b=tAWgXYW72Ic3sKT2MgliHxT
	7fFTM1KnDfdIUTb89enXP+0pljYqR0Tb8hB2sO24KxMoCogsvkyDNt7dXU6W86lA
	RRNCbmLCShuwBVvCOjojL9MBYralxeAtmBy+6TXf0gOspzolEco6fkf3/F7wUctA
	IxzsvOhLkmBFI2y0xseQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=gCe3Gt/mDn/g/KRFNdXVhmtjJOoXv2VPYuKdrLF8SK6RzKtX7
	RcF0/T5jO3CvXzr50Cq+agQO6DH0IqrZbxi0IQnH4j3RzrYVBlq3qbUrcBOx0Ayj
	Bq1FLsrhL/5oUnenEoZcpYnm0S/3I3PiBtcEzTRLXjw3JpyqDo4/GseSnk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B1F177A064;
	Fri, 16 Oct 2009 20:50:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7A1DA7A063; Fri, 16 Oct 2009
 20:50:37 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1848458A-BAB7-11DE-B084-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130541>

Sam Vilain <sam.vilain@catalyst.net.nz> writes:

> Some users prefer in particular '3way' to be the default, let them
> specify it via the config file - and some other boolean settings while
> we're at it.

I have to wonder how this will interact with the internal call rebase
makes into am.  Would there be unexpected fallouts?
