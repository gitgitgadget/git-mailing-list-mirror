From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v2.0.0-rc0
Date: Tue, 22 Apr 2014 15:47:48 -0700
Message-ID: <xmqqbnvt2d7v.fsf@gitster.dls.corp.google.com>
References: <xmqqk3ambf9k.fsf@gitster.dls.corp.google.com>
	<475e137b5095e45c92a87a9969f58f0@74d39fa044aa309eaea14b9f57fe79c>
	<20140422185829.GB15516@google.com>
	<xmqq4n1l3yyf.fsf@gitster.dls.corp.google.com>
	<20140422210002.GC15516@google.com>
	<xmqqy4yx2gz9.fsf@gitster.dls.corp.google.com>
	<20140422221148.GD15516@google.com>
	<20140422222519.GC144079@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Wed Apr 23 00:47:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcjTq-0004ew-7R
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 00:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbaDVWrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 18:47:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48816 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750860AbaDVWrw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 18:47:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B7607F1F7;
	Tue, 22 Apr 2014 18:47:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OD1NJN0qAbPQOq6cQDJ/HFdeyI0=; b=gAj0hO
	9Xyu2tlawx8vUr3o/w8vz76XeiF3jJZVyadM4ij5GCNon/M+Qe51jVXuy+WOpH/0
	WXfvKBueXGaup47L8ihhNA8rhgX9A9ubTbWQZElNsuqINJiYuGdGzxy1P91y1WA+
	NNaLHzR3To9fRFVSQnnStd6XPC+KoJGK0or8w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jsy9UY52qGAiGgLwtyFDkL0lQ/r3VuLT
	LHaNQRy2+oBap+wPy5nFtSOvtrGdzrLfry8dM0xhybYo6t59PjiMtULjHN31G+6K
	JDx8vimSfaep4C3A8emOtcvrM8JMJJajvrLEDkd2KwKXgm5E/JsVeMnGkDN/ajZh
	H1JzvYGFvjk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E29FF7F1F6;
	Tue, 22 Apr 2014 18:47:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A3A67F1F1;
	Tue, 22 Apr 2014 18:47:50 -0400 (EDT)
In-Reply-To: <20140422222519.GC144079@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Tue, 22 Apr 2014 22:25:19 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 21B9CF76-CA70-11E3-8F13-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246801>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Tue, Apr 22, 2014 at 03:11:48PM -0700, Jonathan Nieder wrote:
>> Another possibility would be to require Perl 5.8.9 or newer.  It was
>> released in 2008.
>
> RHEL 5 and CentOS 5 are still shipping with 5.8.8.  They are still
> security-supported until 2017, and believe it or not people still
> develop on them.  I am personally fine with this change, though.
>
> What we could do instead is simply require a newer version of
> Getopt::Long, which would let people continue using their ancient OSes
> and install a newer version from CPAN if necessary.  It's also the
> proper way to specify the dependency.

Yes, but if its inability to properly grok --option="" is the only
reason we want to add a dependency, wouldn't it suffice to simply
state in the documentation (1) how to recognise the symptom to see
if the version the user has is too old, e.g. "if you see this error
message", "run 'perl -v' to see if your perl is older than X",
etc. and (2) how to work it around, i.e. "instead of giving an empty
value with --option='', say --option ''"?
