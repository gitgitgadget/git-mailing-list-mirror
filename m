From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] test-lib: tests skipped by GIT_SKIP_TESTS say so
Date: Mon, 03 Mar 2014 15:13:39 -0800
Message-ID: <xmqqsiqynae4.fsf@gitster.dls.corp.google.com>
References: <1393842298-5944-1-git-send-email-ilya.bobyr@gmail.com>
	<CAPig+cQgYOz7rDax=HFNG9mr-H1FaoL-ss2mgdpMazPS4pWbNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilya Bobyr <ilya.bobyr@gmail.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <tr@thomasrast.ch>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 00:13:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKc3R-0005Rk-Aa
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 00:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430AbaCCXNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 18:13:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47720 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755282AbaCCXNo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 18:13:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A80E6BA9B;
	Mon,  3 Mar 2014 18:13:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3EHC73/ivjON5FA/TlvDnvCDSpk=; b=gKi42u
	IKuMGRyRqeXf9RogYDiQpXROaDtUOsCv5ZCFBfrGZyabD4BGsiVBwHQgK6PBe3eJ
	mj+Tpjmpd8syH5F+MhMDTDD/TNLi1GtQ1zlZ3ciw7tn2XlPoskt1BULbtMwbszs8
	Tv8eFrKv07riNB5K537yv+S4yTdliD6qqw9/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZbVhBxVfgU+wXy9AWLcV9aNaUtdTFK+q
	c63yu05XHF2n5zKVASyP7VzPs3tT4sW4SimRlKl0CMes8IBBSFnWtvHOUZPRjGzO
	uRJc8FjRs6E/truHX9w1x3gO2nc2FcV2RCY++QvIg+zVqY1e+dn1jxgAfSn0KmiW
	qN8P2gICEok=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 370E76BA9A;
	Mon,  3 Mar 2014 18:13:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E33E96BA95;
	Mon,  3 Mar 2014 18:13:40 -0500 (EST)
In-Reply-To: <CAPig+cQgYOz7rDax=HFNG9mr-H1FaoL-ss2mgdpMazPS4pWbNQ@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 3 Mar 2014 17:59:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 755F3D78-A329-11E3-AD35-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243304>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Mar 3, 2014 at 5:24 AM, Ilya Bobyr <ilya.bobyr@gmail.com> wrote:
>> We used to show "(missing )" next to tests skipped because they are
>> specified in GIT_SKIP_TESTS.  Use "(matched by GIT_SKIP_TESTS)" instead.
>
> Bikeshedding: That's pretty verbose. Perhaps just say "(excluded)"?

Sounds good, or at least better than matched GIT_SKIP_TESTS, to me ;-).

Thanks.
