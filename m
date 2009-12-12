From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] commit/status: "git add <path>" is not necessarily
 how to resolve
Date: Sat, 12 Dec 2009 01:24:27 -0800
Message-ID: <7vbpi4v92s.fsf@alter.siamese.dyndns.org>
References: <1260608523-15579-1-git-send-email-gitster@pobox.com>
 <1260608523-15579-2-git-send-email-gitster@pobox.com>
 <1260608523-15579-3-git-send-email-gitster@pobox.com>
 <20091212091556.GA30509@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 12 10:24:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJODT-0000wj-0y
	for gcvg-git-2@lo.gmane.org; Sat, 12 Dec 2009 10:24:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759500AbZLLJYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2009 04:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758855AbZLLJYb
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Dec 2009 04:24:31 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46093 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758781AbZLLJYa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2009 04:24:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AD3787989;
	Sat, 12 Dec 2009 04:24:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9pP/Zf7rjR4DS+05zSu/GJSgU/o=; b=Nr3B0v
	GbjDrY0Gw7/UN5bSlm+8GhfagMhxqC7FELNHbYaE+PRD+ZcIXX0/USbhfviNyXNW
	1BTGTuGTZ0ayb1/u7wrsduAIQMO+CxlcKyN7VDgddmxjKskFgqVFzwkYxEhy/NCw
	1Y5O1O8PXjuFN3092EKQ70jchZWkfaRgs+2u8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZCopvGQYc2m2liody7x6y4YCtyq+6fwe
	AVStC7xn7Z5mMJlVnkVx6ue4xmFAzP2mKoUoxirl4cE0YHoDszD29K9NHxlNmCCY
	HqcH4wh2DTWk6128j67CRjnLMRUdGfIMGiOv2l151kF8mpWojpovXqjyZzgFlzi4
	TZJTFsZOvY0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FB2587988;
	Sat, 12 Dec 2009 04:24:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0863F87987; Sat, 12 Dec
 2009 04:24:28 -0500 (EST)
In-Reply-To: <20091212091556.GA30509@coredump.intra.peff.net> (Jeff King's
 message of "Sat\, 12 Dec 2009 04\:15\:56 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 283CBE6A-E700-11DE-8AD8-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135132>

Jeff King <peff@peff.net> writes:

> On Sat, Dec 12, 2009 at 01:02:02AM -0800, Junio C Hamano wrote:
>
>> When the desired resolution is to remove the path, "git rm <path>" is the
>> command the user needs to use.  Just like in "Changed but not updated"
>> section, suggest to use "git add/rm" as appropriate.
>
> I no longer even see these messages due to advice.statushints, but the
> overall direction of the series looks sane to me.
>
> However:
>
>> -	color_fprintf_ln(s->fp, c, "#   (use \"git add <file>...\" to mark resolution)");
>> +	color_fprintf_ln(s->fp, c, "#   (use \"git add/rm <file>...\" as appropriately to mark resolution)");
>
> This should be "as appropriate".

Heh, I kant speel.  Fixed and re-pushed out on 'pu'.

Thanks.
