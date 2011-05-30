From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-sh-i18n--envsubst: add SYNOPSIS section to the
 documentation
Date: Mon, 30 May 2011 01:09:41 -0700
Message-ID: <7vaae4obi2.fsf@alter.siamese.dyndns.org>
References: <BANLkTikjfyxAzLu2e5aJFVhgKq8UBiJAQw@mail.gmail.com>
 <1306666835-8978-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 30 10:09:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQxXx-0007Da-9c
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 10:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756057Ab1E3IJu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2011 04:09:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64142 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952Ab1E3IJt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2011 04:09:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DEB316FA5;
	Mon, 30 May 2011 04:11:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=M3l8NE7jB5jl
	QSkDqcPRZ4cNQSI=; b=GM6hcAG8gi9/lvw8qvViwZHv7PK92ux+uIGRnQYkJVol
	9uLgUa2SIUSwtGA4FcF4rALA/2TCGjiaKAFdxSSt0KebdGLUGHuz3Zk812pH0K5N
	ZUNKAUHwB3pLJhS38+R92Zbbv6eBWnvoEzP3Dx8m7pSeI+fAsvMNfqxWB/2iFQE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=S2LLqT
	RL+uNDLIrNmqqt6bClGKvrMrIO1xg/Lu+BHN3SNmMNIMEkMX2YKbxM9ImVsbonBt
	1LHvZswWp0M4I/FZMtYQmf4x4BcrQxT+G+38fuQ1z7bgnoxbc4GdFw+JesiUQGUB
	i21vfgl3VMkHhE+dm/vAbrZI25RO/0b5yxi5A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BB5EE6FA4;
	Mon, 30 May 2011 04:11:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E68006FA3; Mon, 30 May 2011
 04:11:51 -0400 (EDT)
In-Reply-To: <1306666835-8978-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 29 May
 2011 11:00:35 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7B241F7C-8A94-11E0-94E9-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174731>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Not having a SYNOPSIS section caused the "doc" target to fail on
> Centos 5.5 with asciidoc 8.2.5, while building with 8.6.4 on Debian
> works just fine.

So does FC13 and FC15, both of which has 8.4.5.

Will queue; thanks.
