From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5570: use explicit push refspec
Date: Sun, 15 Apr 2012 13:18:03 -0700
Message-ID: <7vpqb8zr44.fsf@alter.siamese.dyndns.org>
References: <20120414182907.GA3915@ecki> <20120414183225.GB3915@ecki>
 <7viph1288e.fsf@alter.siamese.dyndns.org> <20120415001133.GB32140@ecki>
 <7v7gxg2461.fsf@alter.siamese.dyndns.org> <20120415195231.GB1960@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Zbigniew =?utf-8?Q?J?= =?utf-8?Q?=C4=99drzejewski-Szmek?= 
	<zbyszek@in.waw.pl>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Apr 15 22:18:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJVuC-0001x1-VV
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 22:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442Ab2DOUSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 16:18:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50721 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751405Ab2DOUSG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 16:18:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81A4E7853;
	Sun, 15 Apr 2012 16:18:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C+COVdtF/r8vgar0QGhaiUoSqPs=; b=fptFcP
	SrTNOkwyHK1hWgk4SXPe304alpVlD19POdziJiGInOvW8QN74Si39fPdMEG5OZPB
	aLMQNXhOf/J1651mT/LE6SexNItp8wJWT8EUPZm/K4znaD03HEM/iADBv6sN0Y3F
	uORUhmVZitCFUuXbmpK1peMOQexj5dIyzc8Ys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yhjh36fLhVnxKl4UOOBi/+4jicAdwNi4
	2qbN60H8iTav3qNZCIdW8WNXQJy2g4HG4DfEGg6Gxh/mJwgZB1PeQMwbLAs6BNMZ
	TCtN8WDyuyx0o9FKJzRLPJOUX9aIU/bf6D4CJhaN2QRnPY98R6/4NNzybA8+kCgG
	pLrlg90X7PY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61AD97852;
	Sun, 15 Apr 2012 16:18:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C01A47850; Sun, 15 Apr 2012
 16:18:04 -0400 (EDT)
In-Reply-To: <20120415195231.GB1960@ecki> (Clemens Buchacher's message of
 "Sun, 15 Apr 2012 21:52:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1B9D4AAA-8738-11E1-91C5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195586>

Clemens Buchacher <drizzd@aon.at> writes:

> In my opinion, this change is also an improvement in itself, since now
> we can more easily pass extra arguments to test_remote_error. Maybe the
> scratching of heads can be alleviated by amending the commit message
> like so?
>
> -->o--
> Subject: [PATCH] t5570: use explicit push refspec
>
> The default mode for push without arguments will change. Some warnings
> are about to be enabled for such use, which causes some t5570 tests to
> fail because they do not expect this output.
>
> Fix this by passing an explicit refspec to git push. To that end, change
> the calling conventions of test_remote_error in order to accomodate
> extra command arguments.
>
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>

Sounds good.  Thanks.
