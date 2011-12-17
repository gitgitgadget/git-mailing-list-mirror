From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3 (resend)] gitweb: Various to_utf8 / esc_html fixes
Date: Sat, 17 Dec 2011 11:27:46 -0800
Message-ID: <7vty4zdmml.fsf@alter.siamese.dyndns.org>
References: <1324113743-21498-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Juergen Kreileder <jk@blackdown.de>,
	John Hawley <warthog9@kernel.org>, admin@repo.or.cz
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 17 20:27:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbzvG-0005e0-I5
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 20:27:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684Ab1LQT1u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Dec 2011 14:27:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43520 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440Ab1LQT1t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Dec 2011 14:27:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B53F7686;
	Sat, 17 Dec 2011 14:27:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=sTVyx/ro9ljx
	Fbx9JIbcZK/dkec=; b=EG1O2sUn077WQ30rF+z+Akp4muTjalatscvOGOP2xmua
	GMLWzMw5No5nVRgW72pEhCwNqT7lATeWUgUJRCVOv1QlGaW7ua7TqkhCm0JOn+KY
	KLILgUcE3caTMQGMgekshXE3q+AwCNARCU/IhiACtRJtdy2qE42opLKnM9cTNgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=KZ7V+o
	IjUom4M3ka1YvgssmbdEqWZ97dSq+9ww4SOPvwFuNmAI3v7cr8GafSVYUFnkJqvO
	hg0tTtUtHlwKZNPQQCDwqv+uSoRmXHMBUUCVZlhnkFOWjOdcPLkCVMnVYf4BgCON
	7etcVfPoimVoYytnoy80A3BIWK2RZvO/wwwbw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 423077685;
	Sat, 17 Dec 2011 14:27:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D11017684; Sat, 17 Dec 2011
 14:27:47 -0500 (EST)
In-Reply-To: <1324113743-21498-1-git-send-email-jnareb@gmail.com> (Jakub
 Narebski's message of "Sat, 17 Dec 2011 10:22:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 33C02DD4-28E5-11E1-9A60-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187401>

Jakub Narebski <jnareb@gmail.com> writes:

> Sorry for resend of this series, but I forgot to generate patches in
> UTF-8 instead of i18n.logoutputencoding=3Diso-8859-2
>
>
> This is post-release resend of J=C3=BCrgen patches (which were sent
> during feature-freeze).
>
> I have slightly extended commit messages, and added my ACK.
>
> J=C3=BCrgen Kreileder (3):
>   gitweb: Call to_utf8() on input string in chop_and_escape_str()
>   gitweb: esc_html() site name for title in OPML
>   gitweb: Output valid utf8 in git_blame_common('data')
>
>  gitweb/gitweb.perl |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)

Thanks.
