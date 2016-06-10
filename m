From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/27] upload-pack: remove unused variable "backup"
Date: Fri, 10 Jun 2016 13:06:28 -0700
Message-ID: <xmqq60tgg663.fsf@gitster.mtv.corp.google.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
	<20160610122714.3341-6-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:06:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBShQ-0007kd-2h
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbcFJUGc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 16:06:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57137 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751719AbcFJUGc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2016 16:06:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 780B5222BD;
	Fri, 10 Jun 2016 16:06:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=LpK1e0X/J/sy
	d2Lw4OiR6qD9Xjw=; b=bmnmawpHIaplDvKgfytLqtN03U3FYMP2r/5Cp7bHL7Fs
	YaFEZ7nDOKNTd7J8CVGs/iL1uBpMh8aL2sL9DNQRMuGbrApjyN+JIzod8dl2PLll
	VJSkElRJUh/3vFhYXylOs+opNT7RlKCzwx/i1CPU4gHQhLehyOtHPUvx7R9JHHI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Yqjt0T
	EqOVs1abLVKTLG61ELcpQ7uLmJvorWHoPt/rSoXI9Lxv3yRpXoYv8Qp7lAFFe9gk
	/YCa1uuiwMr08vnv3EQLaDLaAIEcuGqg1I8mKEM64J3bdDPDrY6gG4t3i16OpyBx
	qwUCslf1qRxizdZynH3ytPUHWvKq8+IASqZU0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 70BEE222BB;
	Fri, 10 Jun 2016 16:06:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EFD0D222BA;
	Fri, 10 Jun 2016 16:06:29 -0400 (EDT)
In-Reply-To: <20160610122714.3341-6-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
	Duy"'s message of "Fri, 10 Jun 2016 19:26:52 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D21179F4-2F46-11E6-9725-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297021>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> After the last patch, "result" and "backup" are the same. "result" us=
ed
> to move, but the movement is now contained in send_shallow(). Delete
> this redundant variable.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

Ah, OK ;-)  Having this as a separate step is OK, too.
