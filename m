From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/3] Tests for merge-recursive rename-options
Date: Wed, 24 Feb 2016 10:38:44 -0800
Message-ID: <xmqqpovmt0ln.fsf@gitster.mtv.corp.google.com>
References: <1456278091-6564-1-git-send-email-felipegassis@gmail.com>
	<CALMa68rbsfLK36cemQrybw5Pk3kqvqWLa7kPyCuqs65m49rkuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Felipe =?utf-8?Q?Gon=C3=A7alves?= Assis 
	<felipegassis@gmail.com>
To: Felipe =?utf-8?Q?Gon=C3=A7alves?= Assis <felipeg.assis@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 19:38:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYeKp-0002VQ-Hk
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 19:38:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758667AbcBXSit convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Feb 2016 13:38:49 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60219 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758422AbcBXSir convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Feb 2016 13:38:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B0F4A45CD5;
	Wed, 24 Feb 2016 13:38:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vOptC6QAxDLO
	zK4qaCreoCXe/ck=; b=q1aVzupZybbJAzRGN81jq/RevF4Z2iaGsEdsxZHJbS64
	M1Ki/yDx2+blE/Y1BArzPU17exYq2W969E5f5fS6YIz0d7PpF38Tz+5cvQypSyI4
	N35Yb9G6v40PaF2VxQfUdGLKIentbf3xylJt/LHSWmW0D8dq/n4DCZlml2Gmtew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=E9TpLc
	YFHOTC+Aee9r4P/KB3E3FKgj7sNZ9ygLz2cY9kR5Os1uoglauy5ZWQYEEIOBTi/y
	XyYhKqcL1/J0HZVscWCh+eu55TNSE/oNO1VqHBggN1mIqZghVLzqWOfPI5EqEaft
	H6F9Iz5ks9rAbbdeXeIlsfwkINGpFXNvJSlxc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A681245CD4;
	Wed, 24 Feb 2016 13:38:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 15A3D45CD1;
	Wed, 24 Feb 2016 13:38:46 -0500 (EST)
In-Reply-To: <CALMa68rbsfLK36cemQrybw5Pk3kqvqWLa7kPyCuqs65m49rkuw@mail.gmail.com>
	("Felipe =?utf-8?Q?Gon=C3=A7alves?= Assis"'s message of "Wed, 24 Feb 2016
 10:42:26
	-0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D657EDA6-DB25-11E5-B756-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287215>

=46elipe Gon=C3=A7alves Assis <felipeg.assis@gmail.com> writes:

> On 23 February 2016 at 22:41, Felipe Gon=C3=A7alves Assis
> <felipeg.assis@gmail.com> wrote:
>> Just a quick update incorporating Eric's latest comments.
>>
>> Still based on
>> c443d39 (merge-recursive: find-renames resets threshold, 2016-02-21)=
=2E
>>
>
> One thing I just noticed is that the description of c443d39 still has
> a line saying "Add corresponding test.", even though it does not
> include any tests. Could you remove that?

Thanks for sharp eyes.
