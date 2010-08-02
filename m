From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] t1011 (sparse checkout): style nitpicks
Date: Mon, 02 Aug 2010 10:31:05 -0700
Message-ID: <7viq3sncpy.fsf@alter.siamese.dyndns.org>
References: <1280556869-707-1-git-send-email-pclouds@gmail.com>
 <1280556869-707-2-git-send-email-pclouds@gmail.com>
 <7vmxt5lyjh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 19:31:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfyrB-0005HP-VM
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 19:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720Ab0HBRbR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 13:31:17 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55623 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330Ab0HBRbQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Aug 2010 13:31:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 57E23CA9AC;
	Mon,  2 Aug 2010 13:31:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/fCK4KVE3xjC
	KZkug+DnA7r/pCw=; b=UkMPb9qRnNJs7kb/F2KaMUBW90oVgeZZSd9x4NToaB13
	DL5QpJDqz7Jzad2oFYqzIrDEQBP+JZXhsO6m9Ka11k/9+QZgJG5FwXoe1MVnG+Uy
	E53qdZyfefInybR7VhFznDX9kqO24flNcZZchXXr5+p35F9WVqUajmCGC7yQ0yA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=CoEB04
	aM3o+HftGI++/wlGQUzZcMtcoVDODXAKRsrve6GlOZS0nDAHQs/hZznIem7dX77r
	Q9gfYm2HtLQUs1bUPiWxMIMaSH9uQa95JgTbSZKYhyqtfGza4+wxZmHGIxY0oMct
	5tiXrAQcpxWkbsOPtqxCH3c3TxNIdE6KoHKYA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 97B2DCA9A8;
	Mon,  2 Aug 2010 13:31:10 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C383FCA9A7; Mon,  2 Aug
 2010 13:31:06 -0400 (EDT)
In-Reply-To: <7vmxt5lyjh.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 02 Aug 2010 10\:22\:42 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BDAE4C1C-9E5B-11DF-BD61-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152427>

Junio C Hamano <gitster@pobox.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> From: Jonathan Nieder <jrnieder@gmail.com>
>>
>> Tweak the rest of the script to more closely follow the test
>> style guide.  Guarding setup commands with test_expect_success
>> makes it easy to see the scope in which some particular data is
>> used; removal of whitespace after >redirection operators is just
>> for consistency.
>>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>
> What happened to the 'test -z "$(cmd)" discards exit status from cmd'=
 part
> of Jonathan's patch?

Sorry, I was confused.

Please disregard the above; it took me a while to realize that this
5-patch series is a re-roll of what I queued, which in turn Jonathan's
nitpick is based on, and you took the advice while redoing 2/5.

Thanks.
