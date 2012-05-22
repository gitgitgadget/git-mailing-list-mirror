From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] completion: rename _git and _gitk
Date: Tue, 22 May 2012 11:00:18 -0700
Message-ID: <7vsjes3xl9.fsf@alter.siamese.dyndns.org>
References: <1337395295-29162-1-git-send-email-felipe.contreras@gmail.com>
 <1337395295-29162-2-git-send-email-felipe.contreras@gmail.com>
 <20120522082406.GA6001@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Carsten Mattner <carstenmattner@googlemail.com>,
	Jeff King <peff@peff.net>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue May 22 20:00:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWtNq-0007yd-0A
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 20:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758467Ab2EVSAY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 May 2012 14:00:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37606 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757423Ab2EVSAV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 May 2012 14:00:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63B9082F7;
	Tue, 22 May 2012 14:00:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=IjQDHUhMJ7Mi
	pafC675nvKgUrlA=; b=LrqZM1ndkyeTo1UQ8fNAyg2Og8oR7wxqxWm7sb3xXqYo
	1l9RbXu8ztpc2Q6waQVQan7SPsdg63G0/CTUC1fkrVF3LRw/YOT2juQPrgCWusEs
	+s/H2/w/3EbYUlWlw/O7S5PFRqEwF91zLEBrnnsxDZeeeJE0QNtVcuImUTzrguM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=D5OTwt
	b0ZK+VR00cj0W1Cu7AuhggUCfOFKhp+YoSX5KS8BICY37Kb4BFuECFuMLT4neaaB
	j44+WLc75CfBQRlKjKh3S4RTESbZ7sKfvGDqol4Hye/zW/Ukyr24NAff0hlCnJi7
	Pq6o1bmoTY/XUhiV7dqHpVRb9djokkC0itWq4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59AE382F5;
	Tue, 22 May 2012 14:00:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB09082F3; Tue, 22 May 2012
 14:00:19 -0400 (EDT)
In-Reply-To: <20120522082406.GA6001@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1b?=
 =?utf-8?Q?or=22's?= message of "Tue, 22 May 2012 10:24:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FE98985C-A437-11E1-ABC7-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198217>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

>> -_git ()
>> +_main_git ()
>
>> -_gitk ()
>> +_main_gitk ()
>
> After all those namespace discussions the names of these functions
> should start with _git or __git.

As these are pure implementation internal details that are called from
very limited places, I do not think Felipe minds a patch to update them=
=2E

Personally I would find _git_git or __git_git even more mysterious and
begs one-liner comments above their definition, though.

Thanks.
