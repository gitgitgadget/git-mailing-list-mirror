From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] gitweb: apply fallback encoding before highlight
Date: Wed, 04 May 2016 12:34:53 -0700
Message-ID: <xmqqeg9hhb1e.fsf@gitster.mtv.corp.google.com>
References: <xmqqbn4ouz7u.fsf@gitster.mtv.corp.google.com>
	<1462280451-43388-1-git-send-email-shin@kojima.org>
	<xmqq7ffbng8p.fsf@gitster.mtv.corp.google.com>
	<20160504083449.GA46041@skmba.local>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christopher Wilson <cwilson@cdwilson.us>,
	Jakub Narebski <jnareb@gmail.com>
To: Shin Kojima <shin@kojima.org>
X-From: git-owner@vger.kernel.org Wed May 04 21:35:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay2Za-0005XQ-I4
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 21:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753481AbcEDTe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 15:34:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59563 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753407AbcEDTe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 15:34:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F5E7172ED;
	Wed,  4 May 2016 15:34:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nK+KX1FFrSbDRpn98vFfCR62t58=; b=k0+tP5
	C0Y6ZIoDBgXWCu06uKUD3wm0B5SXSrSkrndQWx9e9R1w9zxK+ibG3oclL8zd8hur
	77FCfVTKNU13N/9TUT2t01Z006/ibVcqWrdRax7giCIWMLaDwXB7VbqFTlP9TPq0
	rbnMlxhnvkMFtVAHL+XeoJ3cqfXX4ta2A5kOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O6ix5SKYcjXPL4mGHfioFOhSHMQlhr8r
	o2Ijykz/DOEmKzCIEblo+DGL11w2yor5oCGMGGZ9qi3RKQNt5stVuHF7Dgja0ScX
	lxp5a0kzsD7Buva2BdoF6EwJ6h3P2sRvrjag32+7JinLc40Raao30hxugvaE6rBK
	/xBJKf32H+A=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 18267172EC;
	Wed,  4 May 2016 15:34:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 895A2172EB;
	Wed,  4 May 2016 15:34:55 -0400 (EDT)
In-Reply-To: <20160504083449.GA46041@skmba.local> (Shin Kojima's message of
	"Wed, 4 May 2016 17:34:55 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 479EFDFC-122F-11E6-8318-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293576>

Shin Kojima <shin@kojima.org> writes:

> I can say this patch, to consider $fallback_encoding while
> highlighting, is fairly rational.  But I also feel this is too much
> just for specific outdated character encodings, it is completely
> useless for the most part of gitweb users in the world.

Oh, don't get me wrong. I do think what the patch does is very
sensible and have no intention of rejecting it.

Unless somebody finds a new bug in it, but in that case, we won't be
rejecting it but would be improving on it.

As I said, the question was "Just out of curiosity", since it's been
so long since I was in any part of software work done in Japan.
