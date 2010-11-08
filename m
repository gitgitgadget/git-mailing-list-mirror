From: Junio C Hamano <gitster@pobox.com>
Subject: Re: first para of man gitignore should refer to 'git rm --cached'
Date: Mon, 08 Nov 2010 12:17:46 -0800
Message-ID: <7vbp5zpo2d.fsf@alter.siamese.dyndns.org>
References: <AANLkTim=QCcJDb0600Je-jePvXSXfFMe7FAQ0WMhZKn7@mail.gmail.com>
 <20101107191425.GA32302@kytes>
 <AANLkTinznLY3M4z7k-WeeFhGSR1xWHXj_zOrwMvZDfLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 21:18:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFYAE-0005nW-Qs
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 21:18:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462Ab0KHUR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 15:17:56 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39622 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957Ab0KHURz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 15:17:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 47D063D25;
	Mon,  8 Nov 2010 15:17:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DpExP2ZcRM+rK37u5A4cnw1GyeQ=; b=BE15yt
	vGp9pQWMMncdoSxUCU3oHIBn6r3wCvC9F8pjsynzpkkS1n6r6osSUhT0B5yfGfmc
	IbWygCdmUFZV0WIBCp73aARJyHYHSKtazkXXOoSJ5IsE5KaxN9IcaMhIveZahWjz
	DmxzIIHPG7TBttiex5DU3MwjfH2vUlLKPnMec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RIzBU+Z/MWX5IURDOSOCvCf8wUcb6qBO
	va9a2e4bkngXi+heQ/VrbDPcbAEjWuWxT1UM7BzzVZjkNs2NftvbOrBYJm7pB5JL
	S21GZ61/1fPbffkDu+fyKiNHZvVtMpNuvZWgGjPxvVw0QZ6Aptd0iWswswxCn4wq
	YXqddUqUMko=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 007F03D21;
	Mon,  8 Nov 2010 15:17:54 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DFC373D1F; Mon,  8 Nov 2010
 15:17:50 -0500 (EST)
In-Reply-To: <AANLkTinznLY3M4z7k-WeeFhGSR1xWHXj_zOrwMvZDfLQ@mail.gmail.com>
 (Sitaram Chamarty's message of "Mon\, 8 Nov 2010 10\:16\:20 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 453B31FC-EB75-11DF-8886-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160982>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> I'm just saying that ignoring uncommitted changes to already tracked
> files is *not* the most common question I see when it comes to
> gitignore,...

I actually think it is much more commonly asked around here than "I added
paths that I do not want by mistake and I mistakenly thought adding it to
gitignore would make git forget it".
