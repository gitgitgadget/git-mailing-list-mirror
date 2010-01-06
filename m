From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2010, #01; Mon, 04)
Date: Wed, 06 Jan 2010 09:04:22 -0800
Message-ID: <7vwrzvyxk9.fsf@alter.siamese.dyndns.org>
References: <7vljgei7rs.fsf@alter.siamese.dyndns.org>
 <4B421766.4040506@kdbg.org> <7vhbr1bagk.fsf@alter.siamese.dyndns.org>
 <4B43A5CA.7090104@kdbg.org> <7vzl4r7jyu.fsf@alter.siamese.dyndns.org>
 <4B445312.9090507@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Jan 06 18:04:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSZJL-0007wW-5z
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 18:04:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363Ab0AFREd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 12:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268Ab0AFREc
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 12:04:32 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45155 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755966Ab0AFREa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 12:04:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 047DF8E8AD;
	Wed,  6 Jan 2010 12:04:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=OCfc0y1gJ1mIQ7HVkn/Bq6x9MPE=; b=w3XkIQpa/eE37rDjWDyqvWX
	+7G5zwBC5wHr38gJc+ymcza3b8Nu/rBxFCYm5tUcSb3g7QGu9sJysgNaqx9pSyC6
	sLOCn0CZVG3StXVi2p4eAxzZPquvX4VXFLWpznHaoeV6kA6pQEQwcCJjkHgeFxq8
	3V/lwmJd6GXDwAB+8QCc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=x4zyvXsttQPvHz7eyZVMTFhv/XIWJvQLlyzXgLti35PJ3Jo6T
	ylM93kA6t1q6EtfvgyyQkJEoRvg0DR7kuuQewXfO82DxUWXB+0YQg0K/h+lLzWFb
	h03KwM/5vnYXhUrvqO4Cpvrxd8ITzJZ87BP9UV9mFGQ8R0rN5dbJv/5oUI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D30B18E8A9;
	Wed,  6 Jan 2010 12:04:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 188018E8A5; Wed,  6 Jan
 2010 12:04:23 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8C6FD162-FAE5-11DE-8768-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136273>

Johannes Sixt <j6t@kdbg.org> writes:

> Junio C Hamano schrieb:
>> (1) Does "Windows style path" here mean what $(pwd) returns as opposed to
>>     what is in $PWD?
>
> Yes. $PWD is of the form /c/foo/bar; pwd is a function in test-lib.sh
> that ensures it returns the form c:/foo/bar.
>
>> (2) The patch reads like this:
>> ...
>>     Does "strips everything past the second dq" mean "drops '/hexdump'"?
> Yes.
>
>>     If so, would this also work (I am not suggesting to change it, just
>> ...
> It would work, too, but it would depend on very bogus behavior of the
> MSYS bash.

Thanks.
