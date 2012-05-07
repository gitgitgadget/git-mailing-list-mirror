From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: simplify __git_complete_revlist_file
Date: Mon, 07 May 2012 10:15:23 -0700
Message-ID: <7vehqv7w0k.fsf@alter.siamese.dyndns.org>
References: <1335897776-3726-1-git-send-email-felipe.contreras@gmail.com>
 <7vfwbj79od.fsf@alter.siamese.dyndns.org>
 <CAMP44s0z5ghcDQOeL1TrJJ7nw4=tN5MhACqcmf4EjxsNNWiQnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 19:15:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRRX4-0002nY-GK
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 19:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757470Ab2EGRPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 13:15:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62677 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757398Ab2EGRP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 13:15:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABE2B7E5D;
	Mon,  7 May 2012 13:15:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EIU6ZGxhHP/xkD1msb3g56GgRDE=; b=Fom81F
	r93AyWywn1zN5yaBB/i26BOY72qIrAE/C+fif3lDMxfz8KdX//U52razV47ZEKP3
	4/Yw+L7h8TCjKiz0C8sYieu7+toxAnTxj0/2ayarBRPGw5Nvu40RMrDKd2Vqa1Gc
	RHh51d8s0bJCcJKA0G+dZzVuOkRGxs0pCaBNo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DXfsP78dy+w8DC88D/qiVV5AOJ5Cn9KG
	9SUscSPBudMbb2VK4jEr2A7xBcjDfqUAu2GADIblxHZvRQVphVKINcdkIp2fQ7q7
	zguE4Gt3aV0taK9GpblP5sS70Jn5m3csKSuBc3z3ZMZ+UNR3OoNnt6eQPP5FcLH9
	pSdGtJdGE10=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A30627E5C;
	Mon,  7 May 2012 13:15:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F6537E5B; Mon,  7 May 2012
 13:15:25 -0400 (EDT)
In-Reply-To: <CAMP44s0z5ghcDQOeL1TrJJ7nw4=tN5MhACqcmf4EjxsNNWiQnA@mail.gmail.com> (Felipe
 Contreras's message of "Wed, 2 May 2012 01:46:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3C547DD6-9868-11E1-B082-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197284>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Wed, May 2, 2012 at 1:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> This seems to be based on 'maint', which has 31f714d, but I see two hits
>> with "git grep 'COMPREPLY.*compgen' contrib/completion" there, so I am not
>> sure if that is where you wanted it to apply.
>
> The last place that is not the __gitcomp* functions, of course.

OK, that is what you meant by "uses ... _directly_".  With SG's Ack, will
queue.
