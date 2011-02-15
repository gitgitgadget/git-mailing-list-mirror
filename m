From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/2] CHERRY_HEAD
Date: Tue, 15 Feb 2011 14:10:24 -0800
Message-ID: <7vk4h1lzjj.fsf@alter.siamese.dyndns.org>
References: <1297805034-3512-1-git-send-email-jaysoffian@gmail.com>
 <AANLkTik2NM+mxKgZy_9dCwydz+An4sFM_a4U9mdrJBq3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 23:10:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpT6W-0004KG-9P
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 23:10:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756096Ab1BOWKg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Feb 2011 17:10:36 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43477 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754752Ab1BOWKe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 17:10:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2516748CE;
	Tue, 15 Feb 2011 17:11:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=kx34UIxnGOqR
	l9FcSvpLvVhDVmg=; b=HFcezxLLU8FEjSkXWUKlpkmjZnZgM2eTP4HyRSauI31J
	IlnlcySL8R/yBymxZivotBpCLfLA02s3p0XXPJNRK70sonppaehJg3i82YZqtcI8
	cE4SGmi0NtWBPRovl5Pdmt/EYQmKxviud8/sx9Av9wj2Voprs9DWFB9Rdvx0cuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=lItO2a
	0x8H4UJmTtsGsLWKPGz/Xb4OgGmBAUTKOm/AYRdkKyT8t62aWDPucV7XoeUvFNLm
	mqZxFaUYuApJnvRijh0lwDO+hfGp5vpx7XcFACmnqHG2kbwR6RJHhRZPSNZYgKWx
	vsOQy1PqPV2uC0aS754C251SA7HvkEco8cU1c=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E824348CD;
	Tue, 15 Feb 2011 17:11:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D0FCD48CC; Tue, 15 Feb 2011
 17:11:31 -0500 (EST)
In-Reply-To: <AANLkTik2NM+mxKgZy_9dCwydz+An4sFM_a4U9mdrJBq3@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue\, 15 Feb
 2011 22\:51\:41 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8DBAE57A-3950-11E0-B4F7-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166883>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I've read this over, haven't run it, but I really like the idea. It
> sucks that you have to save away the commit sha1 somwhere after a
> failed cherry-pick to use it again. It should just behave like `git
> rebase --continue`, which this implements.

I don't understand.  What do you think rebase does to be able to contin=
ue?
Doesn't it have to save the commit object name away somewhere?
