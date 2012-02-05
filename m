From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] completion: be nicer with zsh
Date: Sun, 05 Feb 2012 12:49:32 -0800
Message-ID: <7vipjlgg4j.fsf@alter.siamese.dyndns.org>
References: <1328145320-14071-1-git-send-email-felipe.contreras@gmail.com>
 <20120202084859.GC3823@burratino> <7v8vklvxwh.fsf@alter.siamese.dyndns.org>
 <CAMP44s1gWNG+jJ6M7OnLS-1VA5YPa07LJfnrvdbsQb0MOJB7PA@mail.gmail.com>
 <7vhaz8vkhd.fsf@alter.siamese.dyndns.org>
 <CAMP44s0Fq_BGwcmDM5E1kWNiyoJw6e6Hr=8XaNF6tmQAcdnUmw@mail.gmail.com>
 <7vehuboe5g.fsf@alter.siamese.dyndns.org>
 <CAMP44s2QdJ4+qgg4fF5-DOWHx3Btd0pTivTT9s_E=qqxg16YLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 05 21:49:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ru91o-0000HM-Iv
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 21:49:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330Ab2BEUtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 15:49:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64010 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750763Ab2BEUtf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 15:49:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE65A53C3;
	Sun,  5 Feb 2012 15:49:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w15BxUTtuVDyWbTqZTnwWiM8Xoc=; b=HlS7hp
	lnlUbpNVvO8gWisl0DYqwIOtDpVSUIMnhSsxz/iX3wkkL8Am2ZnxgmMmrkg5pO5D
	xvYCNGBezrLEvB/CwN2u34FfvtpoKg+d7U8ft6yZ6PzyLmIiKLCFY2nKc9+6aTBM
	lgXArTlHnC9dzqFiG5CuHkC4KUDN9THCb5wy4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DUcakJnXxDa3H9oImdRV9R3byjgBRL5j
	moeIhT6pjU17+xLF/TH47FXR347oDkDS+4NHm6YX2KUc1IoHotPmfGZd4Qr78qCm
	PYL85LrGLC/t1HrsTzUIesg/J+VPIOxANFRiPAUBzj746u6eZFJHu2s1Fg1kbGsg
	qXC55CBDZrQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A570153C2;
	Sun,  5 Feb 2012 15:49:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3A27F53C1; Sun,  5 Feb 2012
 15:49:34 -0500 (EST)
In-Reply-To: <CAMP44s2QdJ4+qgg4fF5-DOWHx3Btd0pTivTT9s_E=qqxg16YLQ@mail.gmail.com> (Felipe
 Contreras's message of "Sat, 4 Feb 2012 17:46:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8D62332-503A-11E1-9D34-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189958>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> Do not blame pobox.com; they have nothing to do with the corruption of
>> your headers.
>
> No, but they have everything to do with *silently* dropping it. Why
> couldn't they _at least_ return an error saying that the headers are
> wrong? Note that other servers didn't even complain, they processed
> the mail happily.

Again, please do not blame pobox.com; they fall into your "other servers"
category.  You are probably talking about vger.kernel.org that is extra
picky and wants to avoid wasting their outgoing bandwidth because they get
so much spams.

> % git blame -e -L 947,+7 contrib/completion/git-completion.bash v1.7.9
> ...
> f2bb9f88 (<spearce@spearce.org>> 2006-11-27 03:41:01 -0500 952)

I am glad to see that something useful came out from your digging, and a
fix is being worked on it, while I was away from my machines.  Thanks for
getting the ball rolling.
