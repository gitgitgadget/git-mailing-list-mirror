From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/7] Fix some problems with reflog expiration
Date: Mon, 02 Mar 2015 14:09:16 -0800
Message-ID: <xmqqbnkb9hmb.fsf@gitster.dls.corp.google.com>
References: <1425288597-20547-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 02 23:09:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSYWh-0002xI-0Q
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 23:09:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753757AbbCBWJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 17:09:19 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59071 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751266AbbCBWJS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 17:09:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BBCFE3D0A8;
	Mon,  2 Mar 2015 17:09:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n1VdqWD6/CwTYxswLRuiPNL+EIQ=; b=SCCtD6
	PGIvEuR6oHBqLNBoyQVXIAWQZBb5tB/oQ1OH524ymKrtL7XovWPiLx4heBrl3TQC
	ID1m/LiYaBJi/T4/Sk/FuZR251Zn8hWcX+s8EF8cHo4BoQsoFVPjUUQP+9PbZejb
	LgggZ4YIBRS59yGfJ0cxJV11yK5HlJKs8qLdM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C1xGs7rZgE+p+lNNn5zuvf14yjWBCm+3
	/ZCR56EMMxoDKVq5S3OMoGe0zPw260DGpImHzDYaFWlCLukbzXkLht8PVtbeU1li
	YEWumjhs8weopoSrCBFNRbjef0FhfzthdQNucF2tg9+jv7Lknc9TmKZguInmfwuC
	ZtD4/o2njMs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B3AD23D0A6;
	Mon,  2 Mar 2015 17:09:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 271093D0A3;
	Mon,  2 Mar 2015 17:09:17 -0500 (EST)
In-Reply-To: <1425288597-20547-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Mon, 2 Mar 2015 10:29:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C4CB17CE-C128-11E4-9266-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264628>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This is v2 of the patch series. Thanks to Eric Sunshine, Stefan
> Beller, Peff, and Junio for their comments about v1 [1].

Thanks for a pleasant read.  Will replace what has been queued.
