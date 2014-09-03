From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCHv2 1/2] am: add gitk patch format
Date: Wed, 03 Sep 2014 16:19:56 -0700
Message-ID: <xmqq38c8waub.fsf@gitster.dls.corp.google.com>
References: <1409736919-22341-1-git-send-email-judge.packham@gmail.com>
	<1409782918-26133-1-git-send-email-judge.packham@gmail.com>
	<1409782918-26133-2-git-send-email-judge.packham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 01:20:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPJqX-0004G2-HY
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 01:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934533AbaICXUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 19:20:01 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63790 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934802AbaICXT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 19:19:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 69A1B3857B;
	Wed,  3 Sep 2014 19:19:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bqViU6Oi+7HZfqKtGgFdNnRfsLc=; b=MJXK2J
	033Zr9yovRPeO+ak85Qslor6w+foeBzBIWEtEBWGTIoOIvFlbTAlc+eR4nLxSjVC
	6QIW1FOnvOcByYayqZIEcihLLhBJlXuo2k+0j120DDGh3B28eMKV9kKIZovPTDk6
	UnfqQ85Pc63sKPZEcTW9ZOQQKSfv4HOuO1uNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CpjRS5a++IphJrxEbfh/DtA+PLIV+G1k
	0UL3wWULMDRxSGIPvs7HxB65CFrs3rAkjQ1gHC3K9lde2OTB9q9X0gJ/8YGRiEZ3
	1v6MKQvwSm3YT0Z5AiM8G1chxp+2pxwOY/7SJ547hCQRV5gKxddGH0fa5+5t2zj3
	OaeuMjXNDgk=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 610C83857A;
	Wed,  3 Sep 2014 19:19:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D9D0C38577;
	Wed,  3 Sep 2014 19:19:57 -0400 (EDT)
In-Reply-To: <1409782918-26133-2-git-send-email-judge.packham@gmail.com>
	(Chris Packham's message of "Thu, 4 Sep 2014 10:21:57 +1200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D210C3B6-33C0-11E4-8420-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256430>

Chris Packham <judge.packham@gmail.com> writes:

> Patches created using gitk's "write commit to file" functionality (which
> uses 'git diff-tree -p --pretty' under the hood) need some massaging in
> order to apply cleanly.

Shouldn't that output routine be the one to be corrected, then?  We
really do not need yet another format to express the same thing,
especially from the same suite of programs.
