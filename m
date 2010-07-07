From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] string_list: Add STRING_LIST_INIT macro and make use of
 it.
Date: Wed, 07 Jul 2010 09:55:35 -0700
Message-ID: <7v7hl7xmd4.fsf@alter.siamese.dyndns.org>
References: <20100702202257.GA7539@burratino>
 <546093148a7ccecace6552c75a70a1cd66b3f420.1278272508.git.tfransosi@gmail.com>
 <20100707151956.GA1529@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org,
	srabbelier@gmail.com, raa.lkml@gmail.com,
	peter.kjellerstedt@axis.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 07 18:56:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWXuj-0007eK-UT
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 18:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755340Ab0GGQzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 12:55:55 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49426 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754469Ab0GGQzy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 12:55:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F5C6C229F;
	Wed,  7 Jul 2010 12:55:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DoNZwvyd/yhivpClfUA9sSo50Rc=; b=hPoKPT
	r0PzfRwBsRAq1wfLICTI6tAD/SkDP8/qq2G7VQ4IaRL5gnJ/cDGpEboVBTh6jqqY
	mNVedlNVGQHCOE0QvIyBv4TyVi7tlFNmU0oMZ4uhUDeHKCbH9qsopPxuGYgM/ukr
	T2JV1ZoXCdTXruV/CAt/wiSOsCEOSbXhRcW0k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kwgsv4lnLf0OOErSlH9k3KeVFzXxZnjF
	hPcGnRD0tHwg3NmsIvHRWUo/YoxcPFZaNfNqMu0xWu5YB/gFCvy01XKD9obbRaGX
	1Si3PcznA6prZkclkQFhzPaJlFzdEyJs6QkfAACdSUIvEEqy61q1II2jV5QycoFR
	5u4GTWM33vU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 711B1C229E;
	Wed,  7 Jul 2010 12:55:44 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A66CC229D; Wed,  7 Jul
 2010 12:55:37 -0400 (EDT)
In-Reply-To: <20100707151956.GA1529@burratino> (Jonathan Nieder's message of
 "Wed\, 7 Jul 2010 10\:19\:56 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7BA63C3A-89E8-11DF-BFEA-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150481>

Jonathan Nieder <jrnieder@gmail.com> writes:

> [1] Maybe it could be clarified: how about inserting "sometimes"
> before "contain"?

Sure, or "will also contain".
