From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 09/13] help: reuse print_columns() for help -a
Date: Fri, 03 Feb 2012 15:05:14 -0800
Message-ID: <7v1uqbmsb9.fsf@alter.siamese.dyndns.org>
References: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
 <1328276078-27955-10-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 00:05:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtSC3-0005Mf-BD
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 00:05:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754335Ab2BCXFS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 18:05:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41040 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753828Ab2BCXFQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2012 18:05:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E9E76BEA;
	Fri,  3 Feb 2012 18:05:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=70TJbtIM/8ai
	8+XhNnW6jQ/ZjnE=; b=W18EVKyJuVas/FMF2fMGtV78Nz0aWXJCdvoYDAMkmHf1
	rTE70Hgb13giwPWbD/R5DywQ2/bh8KFNoxS1LLM/v1vFZu7R8KDKjNdGovFrwgm+
	PoqfHg92jgd3pdBKc7Nnsh90OezoSbIquPXeZBWQEVLaxJHpwjcY/RiTAjRVGzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=IHM4yI
	Jq/t7CHWBp9t/4r5sB87bsURPYH/s05/3vucTxz9Ll+7+n3dsxx8TAVu/7GcJmaY
	6PaQ39x53HeinRtM8x53fJVbLoEGCLW9lgHAFUf5nADSWvG9WYmXlf5rqSIYfL3s
	oim8jH6oeisAVGXVMXnCiMzqIGnf6QvljrStw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05B156BE9;
	Fri,  3 Feb 2012 18:05:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 919FF6BE8; Fri,  3 Feb 2012
 18:05:15 -0500 (EST)
In-Reply-To: <1328276078-27955-10-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 3 Feb
 2012 20:34:34 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 88A313EC-4EBB-11E1-94EE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189823>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  help.c |   47 +++++++++++++----------------------------------
>  1 files changed, 13 insertions(+), 34 deletions(-)

Nice.
