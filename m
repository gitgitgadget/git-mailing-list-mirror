From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Gettext poison rework
Date: Fri, 24 Aug 2012 09:02:04 -0700
Message-ID: <7vwr0o1doj.fsf@alter.siamese.dyndns.org>
References: <1345786986-10826-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 18:02:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4wKu-0003W3-AR
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 18:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759711Ab2HXQCJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Aug 2012 12:02:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61196 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759707Ab2HXQCI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Aug 2012 12:02:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF94A88E6;
	Fri, 24 Aug 2012 12:02:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+tzGgmal2PQP
	hzq5C/Bzb0zckPQ=; b=rBe2oCsLPFzpJATFVJY8M7Kx6NXkH1X84JXuB9oTLoO4
	Bdh0mzAFfYBVYjV4egeDA0mAFx5IjM9aAqrzR0UcKiwD+oYF3SHJHJ4yIfphnflK
	Kon2xj24CLwea0fYZGgjDNLpG7OMgV+vojl/XnHVYcXqk+LmTZ0n8kCbwkXKyoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=EX5706
	7STF99RcLugLkWom7FhC9wwdXHQ/buFgma96iLR0eHbigOs+g/v3T3kEreNxNtJr
	vd1lk85JU9D6ozd44Yw1+Pv9TXYvDyg3p4ZxNyS3jhBjoVzyhoo3lb0+hddgZ6Ro
	M7xCH97RVviS3NiK+MZN6Q3vNEyLTHs3Zp+sU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD29A88E5;
	Fri, 24 Aug 2012 12:02:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 329D188E4; Fri, 24 Aug 2012
 12:02:06 -0400 (EDT)
In-Reply-To: <1345786986-10826-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 24 Aug
 2012 12:43:00 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0D403EF2-EE05-11E1-BDA3-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204217>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> Still WIP but I'm getting closer. I dropped test-poisongen and starte=
d
> to use podebug [2] instead. Less code in git. podebug does not preser=
ve
> shell variables yet. I'll follow that up at upstream [1].

Thanks; this looks promising.
