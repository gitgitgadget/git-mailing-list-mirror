From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [msysGit] Re: Pull request for msysGit patches
Date: Tue, 28 Sep 2010 20:41:47 -0700
Message-ID: <7v4od9rzb8.fsf@alter.siamese.dyndns.org>
References: <87ocbitd33.fsf@fox.patthoyts.tk>
 <7vocbhsn03.fsf@alter.siamese.dyndns.org> <201009282311.01703.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysgit@googlegroups.com,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Sep 29 05:42:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0nYV-0006HH-GI
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 05:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391Ab0I2DmC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 23:42:02 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52377 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106Ab0I2DmA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 23:42:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 60046DAE18;
	Tue, 28 Sep 2010 23:42:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IpGCi2i5UBj6sst44wbUqIpJPo8=; b=kJ4g2A
	1JUUxrz/GvbGjp80bSBXtaVeyTCwhHtNkL/LR4q/3vTsZCq8wvYV+1Fi4nl88pCk
	uJM0SDro+PMcqiXuOreJHFAx30i97WszZyFgWYclI1O184H6rsUJ8Td/BxEE4Ztm
	JueedIfAG1Qx1dvt08Kb4SHFGxX0+KA8+KKac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OeHNwjOqxOgRZFUVOo1sJZQBcLJxPBxI
	QTnMhEsxRVd/a3pZhI9yq2ISCSKNTWxYa4Gy/f8sW89izG/wkYFziGcZ3gpAqW9t
	SBMVXRkU+pGVuPqH3ufyynKmg2+9EaHj6ZPd5zWItLDKQzbJxwzrqqYLP7ZOrdU4
	OzDyof9+pLk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 091CADAE13;
	Tue, 28 Sep 2010 23:41:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC4BBDAE0E; Tue, 28 Sep
 2010 23:41:48 -0400 (EDT)
In-Reply-To: <201009282311.01703.j6t@kdbg.org> (Johannes Sixt's message of
 "Tue\, 28 Sep 2010 23\:11\:01 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 80FFFF5C-CB7B-11DF-960D-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157523>

Johannes Sixt <j6t@kdbg.org> writes:

> On Dienstag, 28. September 2010, Junio C Hamano wrote:
>> git-merge-octopus.sh
>>
>> Why isn't upcasing necessary for all the other uses of environment
>> variables?  For example, we pass reflog action by exporting a variable,
>> and we use GIT_AUTHOR_NAME and friends to override configuration
>> variables.  Do they get upcased?
>
> It is the environment variable *names* that get upper-cased, not the values. 

Ah, of course. I should have noticed it if I read the patch more carefully.

Thanks for an explanation.
