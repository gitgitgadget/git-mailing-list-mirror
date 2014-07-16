From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/20] ref transactions part 2
Date: Wed, 16 Jul 2014 15:16:33 -0700
Message-ID: <xmqqegxlq799.fsf@gitster.dls.corp.google.com>
References: <1405467258-24102-1-git-send-email-sahlberg@google.com>
	<CAL=YDW=At4isTCtwdeGZ-v3cS=vbGyC7aQ-CwAEzxKN0c_3Jyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 00:16:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7XVG-0001mk-Pq
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 00:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674AbaGPWQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 18:16:43 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64500 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752579AbaGPWQm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 18:16:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 94FAF2AA1F;
	Wed, 16 Jul 2014 18:16:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=o/kEbUENSngXotWZ9VuQEFTzPZo=; b=YuH02u6ihdzmAotc5+kg
	j/ycMQqGjpCxvWZu6lGR+enDY0CZEKtHCN0bAFOHQrWtaYrD026IfmpDJqm7zpBD
	Dly8fD6tLh+Rqtp3VCmd4Y48rEaoQXImlvnLsVE9khniWYWJUG1kI07yqFADPj/D
	YWfZdixrspoKRBWKJ0X/X+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=IGpq2lZkZ06QdTbWTWcUgsEEhaUszfZGUp6sUQlaCpwmn6
	m8dbe29wfQTyOtjEVdcNEtnDogFvdJj2Rrcjra7l7pbxz8tyRyclSi8GuEckfko7
	Lfas7hG9JIFPEJrl6s6FvF+pgOBlSJtLKDgJRaNxSECBqNEUJ9BPcsG5hkkq0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8A5572AA1E;
	Wed, 16 Jul 2014 18:16:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6E48B2AA19;
	Wed, 16 Jul 2014 18:16:35 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D964EE54-0D36-11E4-B7AC-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253700>

Ronnie Sahlberg <sahlberg@google.com> writes:

> On Tue, Jul 15, 2014 at 4:33 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
>> This is the next 20 patches from my originally big patch series and follow
>> the previous 19 patches that is now in juns tree.
>> These patches were numbered 20-39 in the original 48-patch series.
>>
>> Changes since these patches were in the original series:
>>
>> - Addressing concerns from mhagger's review

One patch in the series did not apply cleanly on top of the tip of
the previous series (now queued as rs/ref-transaction-0) and I had
to wiggle it.  Please check the result (queued as three topics, this
one is rs/ref-transaction-1 which is built on the abovementioned
"-0", and the remainder from the previous round is rebased on "-1"
as rs/ref-transaction), all of which are queued on 'jch' (which is
part of 'pu').

Thanks.
