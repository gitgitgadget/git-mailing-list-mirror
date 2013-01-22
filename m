From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/8] Add --unannotate
Date: Tue, 22 Jan 2013 08:04:32 -0800
Message-ID: <7vobghb3vz.fsf@alter.siamese.dyndns.org>
References: <1357012655-24974-1-git-send-email-greened@obbligato.org>
 <1357012655-24974-3-git-send-email-greened@obbligato.org>
 <7v623ga8vs.fsf@alter.siamese.dyndns.org>
 <87sj6kfsbz.fsf@waller.obbligato.org>
 <CABVa4NhK3FR-NsTq6Vt6yrgneQmMxF5ANmN6pF8k3fHeOLd0JA@mail.gmail.com>
 <878v7lfvz7.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Nylen <jnylen@gmail.com>, git@vger.kernel.org
To: greened@obbligato.org
X-From: git-owner@vger.kernel.org Tue Jan 22 17:04:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxgLJ-0006sG-RY
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 17:04:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309Ab3AVQEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 11:04:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44826 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753643Ab3AVQEf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 11:04:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20B2FBB71;
	Tue, 22 Jan 2013 11:04:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7mrV+/idtVjfF0JRXTR0NPFqg5o=; b=K3EH+W
	I6vixtjEMrKaFwsZxu+sgLL8QEmBGF+fUxBet2wWstEZmZWFx5r1qjiWdk4hanVL
	yyRumH8uoRXTT52G++wh/WtyQyiernHyM+kei+keOabia6PkkoRbNQBaIvRa5ki9
	nfFUqvT8NVvm3sEyr9S6jUrHB7uPJ9han3TwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=csdl9hynUJJ47zxf6NKcm86UxB1pqxRH
	J9QR1fIUqAMFqPVcpL/GREtg/K8mXEgYEIIhr8KIXkw6316Cw/xun9ZECND88HRl
	Bq+a9Xdhhe/qp3nAE3t1chdMhHg6jsADbi8U/T2cKugtk5B3DMWLaMd3nieW5s22
	IrzTnpI2J2M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14EA0BB70;
	Tue, 22 Jan 2013 11:04:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 70561BB65; Tue, 22 Jan 2013
 11:04:33 -0500 (EST)
In-Reply-To: <878v7lfvz7.fsf@waller.obbligato.org> (greened@obbligato.org's
 message of "Tue, 22 Jan 2013 02:44:12 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6961E75C-64AD-11E2-B8A4-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214235>

greened@obbligato.org writes:

> Junio, is there a policy for backward-compatability in contrib?  I hope
> that since that directory is for stuff not yet in mainline, there is
> some room to massage the user interface.

I do not think there is anything more than "we wish there were fewer
such end-user facing changes."

The purpose of having anything in contrib/ is to give them a way to
gain more visibility than they otherwise would as standalone
projects on their own. I don't want to control the day-to-day
quality issues in them.  That is what we have "guilty parties" for
contrib/ subdirectories for, so that they can decide how mature
their pieces in contrib/ are and what kind of b/c break is
acceptable ;-)

Thanks.
