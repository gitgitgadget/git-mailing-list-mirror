From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: Change the default compiler from "gcc" to "cc"
Date: Tue, 20 Dec 2011 16:01:10 -0800
Message-ID: <7vr4zyiyih.fsf@alter.siamese.dyndns.org>
References: <1324424447-7164-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 21 01:01:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rd9cV-0001MJ-Jp
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 01:01:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753313Ab1LUABP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Dec 2011 19:01:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46178 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752597Ab1LUABN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Dec 2011 19:01:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A08256215;
	Tue, 20 Dec 2011 19:01:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=H48q2LLVDndx
	32NWy3hFNe+T7Qk=; b=DClLl5W2EUbrwLpk01IIFxSSA0t/WPFud0Ydm/tcyieu
	ogaVxO6aozS3d29x9ZG4icnjsKb8dkaPGWO63vPVtByCvrRf+auRPPflszeM86QA
	v44qaFil6gtadQ7cb6eojZrJDxmu5ue/3iKXEvSnabPug/d6x2iKBjOtiktRZuw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=bpRXtL
	RX0XYTtvXAILS9TeF0uf9VMYfiWZnCdTQ8hmXbo/j5mKgQ7Zx3Tti19O+RJAEVcF
	3xRXZBm5z1aBiD7DurtMYwx3RPVQbNYuUzWek2bCnSSFUgOrjlY05ZzHoy5Zdmlp
	OBksGgQFoWMCIrN/nC+HExfEVqmD7dYbPJ5QI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 989316214;
	Tue, 20 Dec 2011 19:01:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D4166213; Tue, 20 Dec 2011
 19:01:12 -0500 (EST)
In-Reply-To: <1324424447-7164-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 20 Dec
 2011 23:40:47 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4BB50F4-2B66-11E1-8882-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187537>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> However unlike Linux Git is written in ANSI C and supports a multitud=
e
> of compilers, including Clang, Sun Studio, xlc etc. On my Linux box
> "cc" is a symlink to clang, and on a Solaris box I have access to "cc=
"
> is Sun Studio's CC.
>
> Both of these are perfectly capable of compiling Git, and it's
> annoying to have to specify CC=3Dcc on the command-line when compilin=
g
> Git when that's the default behavior of most other portable programs.

Would this affect folks in BSD land negatively?
