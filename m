From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2011, #01; Sun, 1)
Date: Mon, 02 May 2011 15:42:16 -0700
Message-ID: <7vsjswk9mf.fsf@alter.siamese.dyndns.org>
References: <7vd3k2q8lt.fsf@alter.siamese.dyndns.org>
 <BANLkTikFK9k=7hGB8AJ4mz88sff=roXd5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue May 03 00:42:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QH1pK-0001hj-8x
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 00:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759422Ab1EBWm1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2011 18:42:27 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51188 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759192Ab1EBWmZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2011 18:42:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B3BCA5E8D;
	Mon,  2 May 2011 18:44:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CFFAXryg97bd
	9sPZp1GxLiPW9ak=; b=pP23huPpjCDtbXsSW5KuZ0oP9gnMHSeNIMFss8lS2Wjc
	QLCBP8TnhonEgoNpfFyfkiP674Vdq73JZDRXbzWaUyHPoojtWRgp+2MZ9zml2AHV
	818v1TnCYD2dAd9mn7V6toFYL59p01WuiciX2MYiXLN/zZI0CzYkeXasPb9qfjs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=SmZxqq
	minDyisQ/t8sJJLWDDcyBWIhTfFCNLv/RjIuiQn7VnyYn2ZOs/pEFRgEAoj+mieY
	WatmgWH9dgW/5REMRmSk4jYNRWdBkkoY5+kYhDQFFnTspzPMB76QGoWaiXdHdza2
	ki/8NDj9P0szO57ZbJ2fJAn+XaItnkW9o9Xrs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8FEDD5E8B;
	Mon,  2 May 2011 18:44:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7BA185E8A; Mon,  2 May 2011
 18:44:21 -0400 (EDT)
In-Reply-To: <BANLkTikFK9k=7hGB8AJ4mz88sff=roXd5g@mail.gmail.com> (Erik
 Faye-Lund's message of "Tue, 3 May 2011 00:32:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BA72064A-750D-11E0-AC87-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172637>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> On Mon, May 2, 2011 at 1:55 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> * kk/maint-prefix-in-config-mak (2011-04-28) 1 commit
>> =C2=A0- Honor $(prefix) set in config.mak* when defining ETC_GIT* an=
d sysconfdir
>>
>> Wait for msysgit folks to Ack, and then merge to "next".
>
> This patch works fine for me in msysGit.

Thanks.
