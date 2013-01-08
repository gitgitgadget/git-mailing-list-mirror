From: Junio C Hamano <gitster@pobox.com>
Subject: Re: troublesome branch name in remote repo causes .git/config
 inconsistency in cloned repo
Date: Tue, 08 Jan 2013 10:59:39 -0800
Message-ID: <7v38ybec10.fsf@alter.siamese.dyndns.org>
References: <CADDfn-L_VWk5Rkn_P8aTf3pwBcbbYT=PZTrG=pFvJpNjgRg-5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pavel =?utf-8?B?UG9zcMOtxaFpbA==?= <pospispa@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 20:00:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TseP3-0000m1-SB
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 20:00:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757192Ab3AHS7m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jan 2013 13:59:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39367 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757171Ab3AHS7l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jan 2013 13:59:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C28EB266;
	Tue,  8 Jan 2013 13:59:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=lEBX2pFh3LXt
	tO+pCJKyoDkk+gs=; b=ZtixiUAoJpg9IXRudcNm4AsTB6o7ELDYnY8SdiOdg2Ig
	i8MeJhFRZI3IgRdVTHZtXLXpEGz+rfj3abHS/8hncW19F5MfOgW4fRKao8qZe7ZV
	genVopPLs4n9CD/RTb+Vy6j7J/XmbbHofa8x+S2yHpWjzRbTX98rqppFlgLWlKw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cDL95C
	LTC8+0CAHODuiGVNtTRpoK/CWO3hNwqcD1AYgfKjRu6c0r75BtvsqKB9VtH2KlNW
	MQGodkxQd4Eqph6brX84iHSayEroQALox4p6AakEqMzQ6i2vU6XTYF8tFyyQBk9o
	5lyBnVNa8rj3Ug2toW/6tXU/U4bIqJf/w/KUs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41566B265;
	Tue,  8 Jan 2013 13:59:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B52BAB263; Tue,  8 Jan 2013
 13:59:40 -0500 (EST)
In-Reply-To: <CADDfn-L_VWk5Rkn_P8aTf3pwBcbbYT=PZTrG=pFvJpNjgRg-5A@mail.gmail.com> ("Pavel
 =?utf-8?B?UG9zcMOtxaFpbCIncw==?= message of "Tue, 8 Jan 2013 19:30:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8E6D48FE-59C5-11E2-A485-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212997>

Pavel Posp=C3=AD=C5=A1il <pospispa@gmail.com> writes:

> I think that the problem may be with the branch name length. I think
> that git branch allows to created branches with very long names,
> however, such long name are not allowed in .git/config ...

I think we lifted this limit back in 1.8.0.1 timeframe.
