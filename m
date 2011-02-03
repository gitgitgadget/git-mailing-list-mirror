From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add case insensitive support in matching pathspec
Date: Thu, 03 Feb 2011 14:14:12 -0800
Message-ID: <7vwrlgzryj.fsf@alter.siamese.dyndns.org>
References: <1296751106-15316-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 03 23:14:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl7Ri-00005H-CT
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 23:14:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282Ab1BCWO0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Feb 2011 17:14:26 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49247 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897Ab1BCWOZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Feb 2011 17:14:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 053EF3B55;
	Thu,  3 Feb 2011 17:15:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6mLn2Vsn/2yQ
	Mz0QgbmgzFIJfIs=; b=uLydydHnfTZ57YnNm3SodfdDOb3ZFeHy7X3/DH8miveD
	BWji84SbZIF23KpJ2+tHoiqb5KtOadhtD9Q2yn6D+D6GX9Yxo/oEvoPg/SUv9Fgf
	y+WHTBjMbcAJzjAn1XXPj71q4eOxHrbFhj8/ehx5d0f7tb4VZCT8+kRSySuWrsY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=CEGTeW
	QM4l7sDxNs6wnmmfz0M8LfkbTSZPmJ0EePXLDKM1ZSST4A4zb6teC4m+0cO1fY66
	soDH5e9d8ynfgr8KuAK9tzr1g2lwg0JGOlcI5U51k2QKD2fWARhb0xJ7BWUtdOC2
	MfINwHWcCWRDMADxSjIl+jX7b22jw+nD0ZTdc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C89523B54;
	Thu,  3 Feb 2011 17:15:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8C8093B53; Thu,  3 Feb 2011
 17:15:09 -0500 (EST)
In-Reply-To: <1296751106-15316-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Thu\,  3 Feb
 2011 23\:38\:26 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 133AFF40-2FE3-11E0-8282-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166004>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

>  On top of nd/struct-pathspec, but requires jj/icase-directory. I can
>  rebase the series on top of master if it causes too many conflicts.

I am in the middle of rewinding 'next' and have already rebased the top=
ic;
I will queue the result in 'pu' so could you check the result when it i=
s
pushed out later?
