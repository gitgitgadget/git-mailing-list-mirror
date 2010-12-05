From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2010, #01; Sat, 4)
Date: Sun, 05 Dec 2010 12:23:14 -0800
Message-ID: <7v62v8ufyl.fsf@alter.siamese.dyndns.org>
References: <7voc90wx36.fsf@alter.siamese.dyndns.org>
 <20101205101333.GA7466@home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@free.fr>
X-From: git-owner@vger.kernel.org Sun Dec 05 21:23:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPL7I-0008AG-O6
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 21:23:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754409Ab0LEUXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Dec 2010 15:23:24 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57158 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754197Ab0LEUXX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Dec 2010 15:23:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5770E3724;
	Sun,  5 Dec 2010 15:23:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=0/+ZtBZ2sL0FXzgESNAiHj3COck=; b=FswK5stAZ3sHAqf5hceuYKS
	Q5IVQG8pJcuH0CK0D7F0Fxw1C2BzSJDYGXi/ceuEyKItinsG6Z2kc4FRNZOoCzhY
	WolkZ6uzsxlfQXILuQ/RbPVtzW8HIo2I2frWUhaZoRelnitPo4DwjHEAXu8g/poH
	n3NbSKc5Xt9eJwxPEaeY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Ayo4IT7WbJstT+VbOQE/FAi87xQipjo0jSeDxqGteqaMQBU3Y
	C/JBi/kIcB8mVP+cLt3tPx5faw69vvyAznPUNSZFRsyq+sTRIzMkddTR1RPPW01c
	dbmo2iU6W/fKUov7Tf+hqfoMCJ2P8/NRTi05YYkRC8kLFKMT4+XIYalnh4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 36A1E3723;
	Sun,  5 Dec 2010 15:23:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0E1BE371F; Sun,  5 Dec 2010
 15:23:37 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8CB1071C-00AD-11E0-A83C-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162960>

Yann Dirson <ydirson@free.fr> writes:

> On Sat, Dec 04, 2010 at 10:30:21PM -0800, Junio C Hamano wrote:
>> * kb/diff-C-M-synonym (2010-11-29) 1 commit
>>  - diff: add --detect-copies-harder as a synonym for --find-copies-harder
>> 
>> Will merge to 'next' soon.
>
> If we go this way, don't we want to deprecate --find-copies-harder as well ?

Why?

We are being nice to people who did not know --find-copies-harder but
learned the --detect-renames long name before learning it, which by
definition is are people because the long names have been there only for
the last few months; they may expect "detect" to work there.  That is the
sole purpose of the additional synonym.

I do not think we would get much benefit from panalizing people who knew
about and have used the --find-copies-harder option for long time by
marking it to be deprecated.
