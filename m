From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Weird message when pulling git version 1.6.6.rc1.39.g9a42
Date: Tue, 08 Dec 2009 22:00:00 -0800
Message-ID: <7vskbkvg9r.fsf@alter.siamese.dyndns.org>
References: <hfmijf$dl1$1@ger.gmane.org>
 <7vmy1t6nye.fsf@alter.siamese.dyndns.org>
 <20091209125556.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alejandro Riveira <ariveira@gmail.com>, git@vger.kernel.org,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 07:00:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIFbM-0002ug-Qb
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 07:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbZLIGAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 01:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbZLIGA3
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 01:00:29 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63341 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbZLIGA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 01:00:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D1A7486F65;
	Wed,  9 Dec 2009 01:00:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=z6L4zTrZpgjIaWw168V6b0IXzGY=; b=P4mpokFttDzMdk2TvFoTSHL
	9STBUv2REacg8xCjK95Ce2D0FmlCmLlYaFiKj6qwazQ2uNpA/lfdvMJinKyvJVMy
	QIlfTPrb7cO+FOuQFkpPAmp9JJH7qyetOGE+1FIdEFSJvhFX8cccFaG5M3dPxfi7
	NilS3EedYDYYiWrj8pPk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=NQvrz1Zt+k0Wov9IL09JUmCNx3PxOfEU7AjfW6JCA6MuH/HCy
	VxoFuXYzVSIFAj4z6Dv/jAQrks7SGGfkP4ZKIovMkZ4NPdkaVK3tL5Q01w5TLyFO
	MngbXNZ31hUIuauBITjd/Liw+B1ARvSUDV9lW8K+EIlEUzLvztB6RI/yvU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BCB7186F5F;
	Wed,  9 Dec 2009 01:00:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A4D886F4C; Wed,  9 Dec
 2009 01:00:02 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1CBEACC6-E488-11DE-A6BF-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134941>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>
>
>> Reverting them will still keep 76bf488 (Do not misidentify "git merge foo
>> HEAD" as an old-style invocation, 2009-12-02) that resulted in the change
>> we are reverting here, so we are still ahead ;-)
>>
>>   http://thread.gmane.org/gmane.comp.version-control.git/134103/focus=134145
>
> Sorry for causing too much trouble. I feel bad.

Oh, please don't be.  You reported a real problem, and we do not shoot the
messengers.
