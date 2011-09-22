From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2011, #06; Wed, 21)
Date: Thu, 22 Sep 2011 09:39:19 -0700
Message-ID: <7v62kkzg3s.fsf@alter.siamese.dyndns.org>
References: <7vaa9xyxpf.fsf@alter.siamese.dyndns.org>
 <1316680641.11165.2.camel@bee.lab.cmartin.tk>
 <4E7AFC6C.7080603@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 18:39:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6mJ6-0000yr-HP
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 18:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174Ab1IVQjX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Sep 2011 12:39:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37524 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751781Ab1IVQjX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2011 12:39:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 711875D95;
	Thu, 22 Sep 2011 12:39:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=k1ZabcAaX1/o
	uoQ57VSe9wxfVnI=; b=o/4UfwPv7E3EkUGdTAMtolttihHC2whDRj8APHDVcE4G
	Q8fBts0zBYxs/gnPL7it7AQKinKUgwFUvYL+bjYjoUjOBMSw1+6k99nxs56LJFCC
	XlRvYPWZJIUVTCMSYQ1+xZsF2P9sIHr2HfkmRofbPoSXUfPz1g/A65djg10Jyag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=TpfbIw
	sNUTjU4i4ukBUGPmUiBiIZRqH92U9Nz0oni68mGfHyqIjLKHh3jYS/X2fewRtK3Y
	5yB0rhclPRQgLk7Pr342SJyKDZ/KkkNJDiP3R/SaLrCJHwg/u4k2FzVHOEWJQ6JL
	22j5cTiQpDNIL6yVgOpBmfM4jLLw9uBnUqs9I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68E575D94;
	Thu, 22 Sep 2011 12:39:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC73E5D93; Thu, 22 Sep 2011
 12:39:20 -0400 (EDT)
In-Reply-To: <4E7AFC6C.7080603@elegosoft.com> (Michael Schubert's message of
 "Thu, 22 Sep 2011 11:14:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6C0CE5F0-E539-11E0-9E6D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181899>

Michael Schubert <mschub@elegosoft.com> writes:

> On 09/22/2011 10:37 AM, Carlos Mart=C3=ADn Nieto wrote:
>> On Wed, 2011-09-21 at 22:04 -0700, Junio C Hamano wrote:
>>> * cn/eradicate-working-copy (2011-09-21) 2 commits
>>>  - patch-id.c: use strbuf instead of a fixed buffer
>>>  - Remove 'working copy' from the documentation and C code
>>=20
>> It looks like that first commit sneaked in there. Shouldn't that be =
its
>> own topic?
>
> It's in pu twice:

Thansk for noticing. Will remove.

> On 09/22/2011 07:04 AM, Junio C Hamano wrote:=20
>> * cn/eradicate-working-copy (2011-09-21) 2 commits
>>  - patch-id.c: use strbuf instead of a fixed buffer
>>  - Remove 'working copy' from the documentation and C code
>
>> * ms/patch-id-with-overlong-line (2011-09-21) 1 commit
>>  - patch-id.c: use strbuf instead of a fixed buffer
>
> 64128da and a6c5c60
>
> There's also a minor typo in the last sentence of the commit message.
> Should I resend?

If that is s/user/use/ and nothing else, I can amend locally; otherwise
please do.

The last part of the "rather dumb heiristic" you talk about is designed=
 to
parse "cmd | diff-tree -p --stdin" output. I agree with you that it can
safely tightened a bit by checking that 41st byte is the EOL, but it
probably is not worth it.
