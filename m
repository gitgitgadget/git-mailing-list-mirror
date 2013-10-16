From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/16] Make Gnome Credential helper more Gnome-y and support ancient distros
Date: Wed, 16 Oct 2013 14:38:43 -0700
Message-ID: <xmqqsiw06gm4.fsf@gitster.dls.corp.google.com>
References: <1379962157-1338-1-git-send-email-bcasey@nvidia.com>
	<xmqqppr6b1jl.fsf@gitster.dls.corp.google.com>
	<525DC7B1.5090406@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	"john\@szakmeister.net" <john@szakmeister.net>,
	"pah\@qo.cx" <pah@qo.cx>,
	"felipe.contreras\@gmail.com" <felipe.contreras@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <bcasey@nvidia.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 23:38:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWYnq-00080L-2r
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 23:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131Ab3JPViq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 17:38:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52265 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754040Ab3JPVip (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 17:38:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F5FA4BD46;
	Wed, 16 Oct 2013 21:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=loHq2ZFciUBnEhqxx2tegmmD4YE=; b=D906k5vYcXRdtJQgXL05
	KKPgMUlfq7knoa3W1vFh5NaWe4lCPHcrcMJVOUelyW82fYTQEv2xY70w7jT9qCS3
	qtkZtCy4zDc/+Ws4epEYWgQW1Wezi9WTL/GcEmKM4LBU6HcyrC4FfCTtYcg7atFr
	T9GPsl425Wi51TIJtWMXgHo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=K6/gunx4wfVmLh2MkR9Nl5YBLiv45o0uOCCNpuL7dpzjPR
	6qNnX7iICLa2BLfrsMV6b1FNSrsvh9Z1ZRIfIM6WotJbuvU7ehIxduEEK6VXt6MS
	rf/ksXvSP2PQfOLM7jgS3PN848ovzj8nQWoyqmigKfISnEOcC2wRDm9B8IbP0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 220E74BD44;
	Wed, 16 Oct 2013 21:38:45 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 80C3F4BD3F;
	Wed, 16 Oct 2013 21:38:44 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 550BBE10-36AB-11E3-8CCC-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236265>

Brandon Casey <bcasey@nvidia.com> writes:

> On 10/15/2013 3:40 PM, Junio C Hamano wrote:
>> This seems to post-date what Jonathan has kept in his 'pu'; is this
>> the latest (I have a huge backlog to wade through, so I'd rather
>> skip it if another reroll is coming and move on to other topics).
>> 
>> Thanks.
>
> This is the latest.
>
> I didn't have anything else planned.  I think Philipp planned to submit
> some style cleanups on top for areas of the code I didn't touch.

Thanks; will requeue.
