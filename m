From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2012, #04; Wed, 14)
Date: Thu, 15 Nov 2012 14:47:57 -0800
Message-ID: <7vip968ov6.fsf@alter.siamese.dyndns.org>
References: <7vhaorajrh.fsf@alter.siamese.dyndns.org>
 <CAMP44s1-bMjr3_XUwkG2XSNzq_aUzHXrs0ZieHDCn+JBYOQMoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 23:48:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZ8EK-0006dq-VT
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 23:48:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765Ab2KOWsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 17:48:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50296 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750733Ab2KOWsB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 17:48:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FF79A7B4;
	Thu, 15 Nov 2012 17:48:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VNR5ObxeU/hu1CGqmGcpI3EDBwU=; b=ReiEji
	0/+KvE2hu31hklCk9nLxIhGLtmpXaJ4lhAaydqe6fd5s2kFhmjfIlmSqvWqjlmfu
	j2IS+R0VfhOM7Q0ulB0AH2nJnuQ69loNNoqDe63qeK99hII9xaZHUDx38jQ2zmPm
	drndEGfMpvaJcWzFM2qqWu0R64OGla9HPH+e0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pQbXApp92IDRCIsvIyktSvima5UAVcMT
	fU/pcIepKgq58Szf3/62zws+YW4+3Uz2sTJkCZa99FAf4iUJLEpS9xaQMz/tgGSx
	kL+gqhHGdg9n2TDBVq4effFoHxIWDfwbARR3t3GK3DLEdJZ0Jj3hAVnD1JEBsPRH
	uMJ+7VXm00I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1F44A7B3;
	Thu, 15 Nov 2012 17:47:59 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 710DFA7B2; Thu, 15 Nov 2012
 17:47:59 -0500 (EST)
In-Reply-To: <CAMP44s1-bMjr3_XUwkG2XSNzq_aUzHXrs0ZieHDCn+JBYOQMoQ@mail.gmail.com> (Felipe
 Contreras's message of "Thu, 15 Nov 2012 02:22:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8131CD6E-2F76-11E2-9D2A-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209850>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Wed, Nov 14, 2012 at 11:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> * fc/completion-test-simplification (2012-10-29) 2 commits
>>  - completion: simplify __gitcomp test helper
>>  - completion: refactor __gitcomp related tests
>>
>>  Clean up completion tests.
>>
>>  There were some comments on the list.
>>
>>  Expecting a re-roll.
>
> This was already re-rolled
> http://article.gmane.org/gmane.comp.version-control.git/209382

Thanks --- will take a look and replace but not today (I was
spending most of my time on the 'master' integration front).
