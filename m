From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v2.0.0-rc0
Date: Sun, 20 Apr 2014 14:14:50 -0700
Message-ID: <7vk3ajln3p.fsf@alter.siamese.dyndns.org>
References: <xmqqk3ambf9k.fsf@gitster.dls.corp.google.com>
	<53541b1214393_1f08dd12ece5@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 23:13:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wbz36-00088G-CI
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 23:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbaDTVNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 17:13:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51408 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971AbaDTVNL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 17:13:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 441A07E041;
	Sun, 20 Apr 2014 17:13:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FpnpI5N37lUT2M1ovXEYdD7sN9M=; b=a8Tpx3
	2R9JXbPgmhyu9tHwWgr2KVMZcJ8Rt8LgRE6HgEl+4YynJ732vfKV1vMWua3K6ppY
	tdCwajvHMmLBqjoxqptRAYmomNYZNqq3lR5IF+vSvQqC3K14d77Smz3jg+INilk4
	5Uka1MU+L1/jl8nxs0l3ERHiAq8qWExW9lFd8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b2tSFF3FKTnpO+MvhcoIxNI7bNqWmYNL
	MwAxv536+lClqYxuYHc8cMIV41WZJwV0uSItpkft0o/OWdyNOZ1Nmq8xhZuWAdcq
	TyPWb3W9BcccwgOxIgKkhiIcPyJnEklyu7Ekb7fE0SOp9HG6u3GcPUDousNPeiJS
	JvPxHN8ARUU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 249017E040;
	Sun, 20 Apr 2014 17:13:11 -0400 (EDT)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 209C17E03E;
	Sun, 20 Apr 2014 17:13:09 -0400 (EDT)
In-Reply-To: <53541b1214393_1f08dd12ece5@nysa.notmuch> (Felipe Contreras's
	message of "Sun, 20 Apr 2014 14:08:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: 92B862E2-C8D0-11E3-9026-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246585>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>>  * transport-helper, fast-import and fast-export have been updated to
>>    allow the ref mapping and ref deletion in a way similar to the
>>    natively supported transports.
>
> Have they?

Yikes, no.  This was me mischaracterizingg the merge at 90e6255a6d01
(Merge branch 'fc/transport-helper-fixes', 2014-03-18).  It was
about letting the transport respond to 'force', and not about ref
mapping, I think.

Thanks for spotting.

Will remove that section from the release notes in the meantime.  As
to the resurrection of the series, that will have to cook outside
'master' at least for the remainder of this cycle.
