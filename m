From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash: complete more options for 'git rebase'
Date: Wed, 28 Oct 2009 00:19:40 -0700
Message-ID: <7viqe0rnn7.fsf@alter.siamese.dyndns.org>
References: <4AD98F72.1060901@gmail.com> <20091028003208.GO10505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Qmr2cm4=?= Gustavsson <bgustavsson@gmail.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 28 08:19:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N32p0-0008Ro-Fy
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 08:19:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbZJ1HTo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Oct 2009 03:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbZJ1HTo
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 03:19:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48220 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932549AbZJ1HTn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Oct 2009 03:19:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 306BB69DFA;
	Wed, 28 Oct 2009 03:19:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=XxHnj6bgf9dYN5suOCxaDrpEH
	JY=; b=lNRveAkRNgryclAyu24ki2SXjwA0+ihKF0N/wXY4YiiYeXSAAi05XFcuW
	IYitugoH+XqwXulUgH8Ob0WUPRrNme3lq5al4GUeKKS+FaND8Vb1RVKKjCS6+0Nz
	Ti3V+Benpe9n8FPBGdhMeTUNez56XSX5QL+OMOfCxEpRQhTgWw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=U5p/YGtz/tc4BVztCGy
	ct64cd9FtL/Yqo3CYxXc2vo14Vxq91BE3pxS8/iu2I9iwT1aOR6y9o/F+XkH74gD
	W25P10HO1hRZYH01UZkbwxDjOJat3dwUY4r+uWrCPMGqp1eXnHiyvqXSBxPgcaQA
	RcgN1tAvXrzAwaDUA+l+VCL0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F2D6169DF8;
	Wed, 28 Oct 2009 03:19:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4AB2369DF4; Wed, 28 Oct
 2009 03:19:41 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 448192A8-C392-11DE-9DF8-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131425>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Bj??rn Gustavsson <bgustavsson@gmail.com> wrote:
>> Complete all long options for 'git rebase' except --no-verify
>> (probably used very seldom) and the long options corresponding
>> to -v, -q, and -f.
>>=20
>> Signed-off-by: Bj=B6rn Gustavsson <bgustavsson@gmail.com>
>
> Acked-by: Shawn O. Pearce <spearce@spearce.org>
>
>> I am primarily interested in having the --whitespace=3D option compl=
eted,
>> but while at it I have added completion for the other potentially us=
eful
>> long options.

Thanks.
