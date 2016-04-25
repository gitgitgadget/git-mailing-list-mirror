From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] githooks.txt: Minor improvements to the grammar & phrasing
Date: Mon, 25 Apr 2016 11:33:13 -0700
Message-ID: <xmqqinz5les6.fsf@gitster.mtv.corp.google.com>
References: <1461529229-15222-1-git-send-email-avarab@gmail.com>
	<1461529229-15222-3-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 20:33:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aulJz-0006l0-Mk
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 20:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933371AbcDYSdS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2016 14:33:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63592 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933242AbcDYSdR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2016 14:33:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C0BF146D9;
	Mon, 25 Apr 2016 14:33:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XM3Y5x+hV3yA
	KvKIXtcQpwbkvmk=; b=mtylZkV3+yZR3TfuAVempzOsJAhpTkv2zZHTfpvMb3gh
	zgQwO+dcrUZhh2en5ZAM/bCN/seoGp3Fn0es6p/tJZxw0Kssd78GDvR5cJsgDqAQ
	hw8VIwgZMyp1ufDWehu+EuOo8pBR/l6dLLzIv/C0dq1YO3587F9rRk/V3LP7cRE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XlV3lT
	/CNoOynZYgvNfA/VT0jv/58T76UkmQbErYh+T5hSLZOhbmVEAsv7bk8OuzK3a/bQ
	Rn52fRNVu8cQUVm3C0tSdd+/EUjunv+lk5CSwAMGO1O5zIT/YhMQ0eLaIKsw7fbt
	J4akHxsjy8ee4hJFCSKcGEATQdaUZAnnq9+ss=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 940EE146D7;
	Mon, 25 Apr 2016 14:33:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 11D42146D6;
	Mon, 25 Apr 2016 14:33:15 -0400 (EDT)
In-Reply-To: <1461529229-15222-3-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 24 Apr
 2016 20:20:29 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2C3D3118-0B14-11E6-9568-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292540>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> -This hook is invoked by 'git am' script.  It takes a single
> +This hook is invoked by 'git am'.  It takes a single

Good, as it does not matter to the readers that "am" happens to be
implemented as a script.

>  parameter, the name of the file that holds the proposed commit
> -log message.  Exiting with non-zero status causes
> -'git am' to abort before applying the patch.
> +log message.  Exiting with non-zero causes 'git am' to abort
> +before applying the patch.

I am not sure why you dropped "status" from here.  The result is
harder to grok, at least to me.  Perhaps "with a non-zero status"?

>  The hook is allowed to edit the message file in place, and can
> -be used to normalize the message into some project standard
> -format (if the project has one). It can also be used to refuse
> -the commit after inspecting the message file.
> +be used to e.g. normalize the message into some project standard
> +format. It can also be used to refuse the commit after inspecting
> +the message file.

OK.  Or we can even drop "e.g." and the result still reads perfectly
fine.

>  This hook is invoked by 'git commit', and can be bypassed
> -with `--no-verify` option.  It takes no parameter, and is
> +with the `--no-verify` option.  It takes no parameters, and is
>  invoked before obtaining the proposed commit log message and
> -making a commit.  Exiting with non-zero status from this script
> -causes the 'git commit' to abort.
> +making a commit.  Exiting with a non-zero status from this script
> +causes the 'git commit' command to abort before creating a commit.

Good.  And you kept "status" here, which is doubly good.
