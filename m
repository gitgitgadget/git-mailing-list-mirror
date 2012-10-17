From: Junio C Hamano <gitster@pobox.com>
Subject: Re: sharedRepository derived from file permissions
Date: Wed, 17 Oct 2012 00:46:56 -0700
Message-ID: <7vfw5dpmkv.fsf@alter.siamese.dyndns.org>
References: <1210080955590.12283@wes.ijneb.com>
 <7vhaq4nc7g.fsf@alter.siamese.dyndns.org> <1210170009180.2113@vega>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Hills <mark@pogo.org.uk>
X-From: git-owner@vger.kernel.org Wed Oct 17 09:47:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOOLO-0000bm-Ey
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 09:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756232Ab2JQHq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 03:46:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60588 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751504Ab2JQHq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 03:46:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA90C681D;
	Wed, 17 Oct 2012 03:46:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=abuBLSCEaV5NatUbYuPTxAwYpns=; b=sAXxM3
	poNBd90cuuWFw0TvH3ILCTqhA39Cpf6oYnzsPMKBW3qPCPJdvD3YmUXk9Lw4R98p
	E7CyWWl3pKo+gtSYp2rglaja8voceq543Oc/sQUkgdrJGSDSpz81glnLip8Xt0K+
	8G+/LJXYaHF6kRQ8H622pDpe4WD0Nxu1qQHW8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JNPJFZ8SAhuOC6PX+eQ302tm0FA2l3uV
	2K4Lgvb2ir9RKWO9r3xIVeqB3NzMQtfmiIMlcPljJww3koelwFsO48wxZHium3y7
	xv+Sgox/rBwcQ39u/Glbmt7DuU75IRBv9/X1ztoH6FLvVb7+zakpxqkS+gfhvgT2
	SaY1lFX8y1w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98357681C;
	Wed, 17 Oct 2012 03:46:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 00BE2681B; Wed, 17 Oct 2012
 03:46:57 -0400 (EDT)
In-Reply-To: <1210170009180.2113@vega> (Mark Hills's message of "Wed, 17 Oct
 2012 00:20:56 +0100 (BST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D412E0C2-182E-11E2-9E14-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207903>

Mark Hills <mark@pogo.org.uk> writes:

>> > It looks like it might be easier (and less confusing to users) to derive 
>> > this attribute from the top-level .git directory?
>> 
>> Hrm, clever ;-)
>> 
>> > Is there a reason why Git doesn't just follow (and echo) the top-level 
>> > permissions?
>> 
>> Other than "we did not trust that all the end users are capable of
>> doing the right 'chmod 2775 .git && chgrp project .git", with a
>> little bit of "we didn't think of that when we wrote the system", I
>> do not recall any.
>
> Thanks. If I understand, you mean it might be worth a try to implement 
> this.

Not really.

I still do not think that all the end users are capable of doing the
right 'chmod 2775 .git && chgrp project .git' themselves.
