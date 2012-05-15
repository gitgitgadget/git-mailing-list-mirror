From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] completion: add new __git_complete helper
Date: Tue, 15 May 2012 10:03:57 -0700
Message-ID: <7v1umlfkaq.fsf@alter.siamese.dyndns.org>
References: <1337009718-1164-1-git-send-email-felipe.contreras@gmail.com>
 <7vvcjyhd5n.fsf@alter.siamese.dyndns.org>
 <CAMP44s1pb+J_SAzZ66QVcWq4V=LauUQ2VmzMD8KBtnhjubkkVg@mail.gmail.com>
 <7vmx5ahbrm.fsf@alter.siamese.dyndns.org>
 <CAMP44s1h=MPT8vx6JrGjMZWJzRjndxYKoYgo+1Y_Mmv+gWXzaQ@mail.gmail.com>
 <7vaa1ah95p.fsf@alter.siamese.dyndns.org>
 <CAMP44s2L=s4bd-sDcY3RWLWe9=YzLgC7UavgnE6K0akMCJSK4w@mail.gmail.com>
 <7v62bxfkeh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 15 19:04:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SULAM-0008BT-H3
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 19:04:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933293Ab2EOREA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 May 2012 13:04:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53186 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933285Ab2EORD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2012 13:03:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93BC58602;
	Tue, 15 May 2012 13:03:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mHUVAL+/VVAhjLn5OnwrwI2lrTA=; b=hpKNLE
	LA5H37b7fceCSR7GnJVvajU76O626pobzrBMufyjKrgfRSViJBIDMoWmu2cCCUnn
	10wU+CFbOoB/Zf4hoBu8nO8fe5NUL9BsQscLHaAuDwJFdqEVtTpcOUM6RC5omACg
	QsWVnwYhnf+/tytn9dngg7E3aNprquj6GNMmM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eVt0ZmbqjCNeUHnfniPZvYlUO3CWJJok
	owAOXUZjh1d8U0QSgifxfOLF0saOk0daByJKz1gvtXvcmhhO430West670GTv493
	p65IMfm33altgPDXxBWHmFTgS49ciF3JZ6Rv6CUQwOdnrPhAo2wS6W1W8J/gGnLI
	VbmlOBZRieA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 897C08601;
	Tue, 15 May 2012 13:03:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E20885FE; Tue, 15 May 2012
 13:03:59 -0400 (EDT)
In-Reply-To: <7v62bxfkeh.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 15 May 2012 10:01:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F69695EC-9EAF-11E1-9AB4-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197842>

Junio C Hamano <gitster@pobox.com> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
> ...
>> If so, then yeah, I agree.
>>
>> Is there something actionable?
>
> Like adding an explanation, preferrably a better one, there, so that the
> next person do not have to wonder and waste time like I did?

s/a better one/& than my attempt in the message you are replying to/;
