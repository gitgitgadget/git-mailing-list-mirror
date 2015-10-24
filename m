From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ancestor and descendant ~ clarification needed
Date: Sat, 24 Oct 2015 09:42:55 -0700
Message-ID: <xmqqy4esmd4g.fsf@gitster.mtv.corp.google.com>
References: <CAAF+z6HEeFEYD9R+6Uz3ebRYNMpy5Gh0Fo9EjpaTYwSbqyDLgQ@mail.gmail.com>
	<xmqqfv12r6vn.fsf@gitster.mtv.corp.google.com>
	<CAAF+z6H+wwCOhPCU-_Uh-Odc=411N+G+d_iE_AKX+JxVMDtsMQ@mail.gmail.com>
	<xmqqsi51plpz.fsf@gitster.mtv.corp.google.com>
	<CAAF+z6Guy4h8XDHkgkAmxLftfTTsXrDAd_ezFCQzdiWncvVSTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>
To: Xue Fuqiao <xfq.free@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 24 18:43:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zq1uK-0003Hk-By
	for gcvg-git-2@plane.gmane.org; Sat, 24 Oct 2015 18:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbbJXQm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2015 12:42:59 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51447 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751766AbbJXQm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2015 12:42:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5AE5522E45;
	Sat, 24 Oct 2015 12:42:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=69Vb4Es5cUOFXK82oRDki2k1bH0=; b=UbATIl
	l8RMiSGSkiXNxDN9feUI6fJv2vFjuHnLTp5oboA6yAws7JPFHpabS/Y9Ys+fM4Ss
	FxqOyfNMZlpufq5pG1z3R/KWX5LJzAgnu4vIG826zoVLYuh+Qt7F/+VxG0av4rGV
	ZvF3Kmkh2IqYTcooicBjByY+ZtA/7G6QwWe7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J14YGt+aYiRKOys+NMcpZ6X0QKhX40lq
	CHDuP77WWEIGrB3t1qYnw2p61bYdAzIW0wYXPV5rfwNy37ipXHS08R93ZpoP6OB3
	Qsjvri1Pjz0zcaZ9Vh9BVANLWopnEcdoR6CpQNWrThGxFtS7uYpQvky0OpnEHIJB
	XZdORyHPd4o=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 526CB22E43;
	Sat, 24 Oct 2015 12:42:57 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CCA6A22E3F;
	Sat, 24 Oct 2015 12:42:56 -0400 (EDT)
In-Reply-To: <CAAF+z6Guy4h8XDHkgkAmxLftfTTsXrDAd_ezFCQzdiWncvVSTg@mail.gmail.com>
	(Xue Fuqiao's message of "Sat, 24 Oct 2015 07:11:33 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4774C39C-7A6E-11E5-B9F7-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280128>

Xue Fuqiao <xfq.free@gmail.com> writes:

> On Sat, Oct 24, 2015 at 12:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> I see.  Thank you.  What do you think about the following minor patch
>>> for user-manual.txt?
>>
>> While the updated text is more correct than the original, I do not
>> know if that is sufficient, or we would also want to mention the
>> "Already up-to-date!" case here while at it.
>
> I thought about that, and IMHO it's not needed.  The section name is
> "Fast-forward merges" and intends to introduce the "fast-forward"
> concept, which is irrelevant to "Already up-to-date!".

Okay.
