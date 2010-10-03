From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: mention environment variables
 GIT_CONFIG_NO(GLOBAL|SYSTEM)
Date: Sun, 03 Oct 2010 16:27:10 -0700
Message-ID: <7vvd5ieu29.fsf@alter.siamese.dyndns.org>
References: <20101003235329.6f4d2572@jk.gs>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>
To: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Mon Oct 04 01:29:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Xzd-0004vR-AC
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 01:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485Ab0JCX1W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 19:27:22 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42016 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091Ab0JCX1V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Oct 2010 19:27:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AC4ADB19B;
	Sun,  3 Oct 2010 19:27:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=aCDoMZSdSff9
	9txKbHqvbelx/yI=; b=S+ybFEPRD6TurkQobrJPZqfQBOW+MdYMoPhdtinFJv3y
	kBB3d2TFiLTJBd3MvWh/9j7a3XeB5ZWaxjLfIOHI6PVrvjTmSaeZIjO2PDASVve3
	MvPBZ7MwHWZmxJ9xlAQgC2yxyCa71W87PX7+ZNMTWaHCvPzLxPxwcNN/yiXHNN8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ZIVMlA
	SWp9besmlaHNKRCcIr21bCaWiv19KBfZkehYG4/GdUHt33/HHDoLi2tlF06oDO1+
	xAcwZJK1JyRzpVO0cK45p1+Li4nSgAIm9PVIOBoDTDDDuRoiFX5V17f+qm1lbBAe
	AiUa0/EEDGbUaFGd8lmK9rv0bOUXLj+PghRIk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EAED1DB19A;
	Sun,  3 Oct 2010 19:27:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 556E7DB199; Sun,  3 Oct
 2010 19:27:12 -0400 (EDT)
In-Reply-To: <20101003235329.6f4d2572@jk.gs> ("Jan =?utf-8?Q?Kr=C3=BCger?=
 =?utf-8?Q?=22's?= message of "Sun\, 3 Oct 2010 23\:53\:29 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C16EA8B8-CF45-11DF-8192-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157946>

Jan Kr=C3=BCger <jk@jk.gs> writes:

> The environment variables GIT_CONFIG_NOGLOBAL and GIT_CONFIG_NOSYSTEM
> which have the opposite effect of the --global and --system switches =
to
> git-config are completely undocumented. This mentions them in the
> 'files' and 'environment' sections of the manpage for git-config wher=
e
> GIT_CONFIG is already mentioned.
>
> Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>

Aren't they undocumented because the use case for them is pretty much
limited to the test scripts and nowhere else?  I am not absolutely sure
about GIT_CONFIG_NOGLOBAL, but NOSYSTEM surely was started that way.
