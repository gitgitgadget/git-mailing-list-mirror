From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/12 v2] apply: run setup_git_directory_gently() sooner
Date: Sun, 15 Aug 2010 20:39:19 -0700
Message-ID: <7vhbivdy54.fsf@alter.siamese.dyndns.org>
References: <20100806030844.GJ22369@burratino>
 <1281918972-27207-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>, avarab@gmail.com,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 16 05:39:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkqYC-0005F8-KM
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 05:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310Ab0HPDje convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Aug 2010 23:39:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51083 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551Ab0HPDjd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Aug 2010 23:39:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D90C5CD5C1;
	Sun, 15 Aug 2010 23:39:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=CA4TwvxIqNorj4MHSsf6UoCx7
	Jk=; b=VkER+AqTzUAvQRWrHZrRQZxkZI3ZyB1DEK+L5r/+CDmvJPu0DacEIavMp
	wCxxlZMHba/qVhem1sLFvz5mJTVvpOfGRDDEmKSnIt23HiRXuy3u34h5IBagQL8x
	E2Ep8BQSmjzI8IVr2DA7+oJzFYezhaJALJoGFqlcLXxf5/AinI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=mpL7toR7BhrbpCt42l9
	2rpqa78z3WD3NnPD0KnYzFk+QJePSDHWh5RnN/mO425gTARmatp1DBGg5iAr54gm
	VQ1uWsAuv77oIpfQSQt7HM5f8HbScRFpJKEMO7cJdnDPXsvd/GaTJclm1bPztFgt
	NOy+da6JbZjceSiWd1w001Ng=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D929CD5BD;
	Sun, 15 Aug 2010 23:39:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 09D78CD5BB; Sun, 15 Aug
 2010 23:39:20 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DE99B9FC-A8E7-11DF-8072-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153647>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> As v1.7.2~16^2 (2010-07-14) explains, without this change,
> =E2=80=9Cgit --paginate apply=E2=80=9D can ignore the repository-loca=
l
> =E2=80=9C[core] pager=E2=80=9D configuration.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  This is a replacement for 4ce097c (apply: run
>  setup_git_directory_gently() sooner) in pu, branch jn/paginate-fix,
>  which fixes prefix loss in 4ce097c.

Thanks for a quick fix.
