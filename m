From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] git-log.txt: fix description of <since>..<until>
Date: Sun, 21 Apr 2013 00:19:09 -0700
Message-ID: <7vhaj0wdua.fsf@alter.siamese.dyndns.org>
References: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
	<1366458313-7186-4-git-send-email-artagnon@gmail.com>
	<20130420222528.GA10043@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 09:19:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UToYa-0000fW-8R
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 09:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146Ab3DUHTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 03:19:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58516 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751944Ab3DUHTM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 03:19:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5906E13DDC;
	Sun, 21 Apr 2013 07:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/d+Jm0w/12/BTiG3OMuL/V2Xo2Q=; b=Ost5El
	KINjRww1aRX+pD2CNL0MJKT/mf8ZyNITCDPKN+9huOQ1KtO8Zta7om8QaYGyiELL
	erqOR0Pi+ASroH2bKpHc+oDcQerHc8r4eX1JKIhqPg9ANyUywRNcCcSSwi7XJ8hL
	BisEC/2KY6XXW14xG9U3l0xJqk+h7eJb5xUzk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N8Lo+bcb/Rn+N5DRvlPNW8IFa0w8+nQn
	Q+Ono+aUGdpJQz6k9HNlIAxuxo1dMrooRnHDeLb94x/IsBuKi2u8B3QJXrJea/l4
	NgyT/5OEePCoZsK66LkkjI+kBcgMjqbXlcNM7qPOT8ki4UhYaRSUrHRAVCWBgKA4
	QZr2wcMR8lg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BCC413DDB;
	Sun, 21 Apr 2013 07:19:11 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BECA613DD9;
	Sun, 21 Apr 2013 07:19:10 +0000 (UTC)
In-Reply-To: <20130420222528.GA10043@elie.Belkin> (Jonathan Nieder's message
	of "Sat, 20 Apr 2013 15:25:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C32AB278-AA53-11E2-B75D-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221903>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Ramkumar Ramachandra wrote:
>
>> First, <since> and <until> are ways to specify "revisions", not
>> "commits", as gitrevisions.txt would indicate.
>
> What's the difference between a revision and a commit?  The definition
> in gitglossary(7) only confuses me.

They are the same, but I think it is irrelevant.  We do not want
revision or commit there, anyway.  We want a revision range there.
This is "git log" not "git show".
