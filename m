From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 11/11] Documentation: add documentation for 'git interpret-trailers'
Date: Mon, 07 Apr 2014 12:34:52 -0700
Message-ID: <xmqq4n25lyqr.fsf@gitster.dls.corp.google.com>
References: <xmqqk3b4ogwu.fsf@gitster.dls.corp.google.com>
	<CAP8UFD38TE=5zxvkDvLRsDTpC6zDo6EN5q_HJMQPbUBcfJVsSg@mail.gmail.com>
	<xmqq4n25nkt0.fsf@gitster.dls.corp.google.com>
	<20140407.205800.839733420387302333.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: christian.couder@gmail.com, jrnieder@gmail.com,
	git@vger.kernel.org, josh@joshtriplett.org,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Apr 07 21:35:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXFJt-0006Sg-8w
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 21:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755615AbaDGTe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 15:34:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59850 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753765AbaDGTe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 15:34:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B36F7B4F5;
	Mon,  7 Apr 2014 15:34:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=daGcG3j+xCLMLxRVKBq6wL954/E=; b=qpjgvM
	Q+phYbhYNQGSipBgCqhzwnE22bUbj/GV2OI4xLM/xMfgnvI2jWT8F26pptlgzY3c
	wG4dEa/yvzyIFV+oBQxy/S7BOwaGj2pzLfaLv2NUhAjHXx66dN9GueZRKsnaZyyT
	ELrvmAk9AnheV1dRv5Jr9JbbI8SFHTzWKzHWY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fh4qsNZ7bAdFYXuJrIwgLxNTPs71wJfH
	nJsIBiKBK+vXsX2jahdzJOBZ+YRCWD+g0EaPp+9CUIFMRFkkNZOmWuw2tcY7stPN
	fDijQ6aXXGxhdSuWqkVb6mkSp4XYfDEysBYxQJDfqzZ2bq5CKL8rYFjcRyLEz3+K
	7XX65MTAjP0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87D117B4F3;
	Mon,  7 Apr 2014 15:34:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CAAE7B4E7;
	Mon,  7 Apr 2014 15:34:54 -0400 (EDT)
In-Reply-To: <20140407.205800.839733420387302333.chriscool@tuxfamily.org>
	(Christian Couder's message of "Mon, 07 Apr 2014 20:58:00 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B1D6ABD8-BE8B-11E3-9124-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245894>

Christian Couder <chriscool@tuxfamily.org> writes:

>> I do not see these two as valid arguments to make the command line
>> more complex to the end users
>
> I don't think that it makes the command more complex to the end users.
>
>> ---who now need to know that only this
>> command treats its command line in a funny way, accepting a colon in
>> place of an equal sign.

I meant that it makes learning the "command line syntax of Git" more
complex to new users.  If one is too narrowly focused on this single
command, it may not seem that "the command" is not made more
complex, but I am more interested in making sure that the entire Git
command line experience does not get unnecessarily harder to learn.
