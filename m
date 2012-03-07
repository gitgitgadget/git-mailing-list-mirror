From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] nd/stream-more updates
Date: Wed, 07 Mar 2012 09:13:37 -0800
Message-ID: <7vsjhknxku.fsf@alter.siamese.dyndns.org>
References: <7vty21twqc.fsf@alter.siamese.dyndns.org>
 <1331117661-19378-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 18:13:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5KQs-0006zu-S4
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 18:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759079Ab2CGRNl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Mar 2012 12:13:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62185 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756375Ab2CGRNk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Mar 2012 12:13:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2A5467BD;
	Wed,  7 Mar 2012 12:13:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=EIf1RdmDQHmh
	E4Y5tuXbLbDZYzI=; b=Lh0YKanrIZ9V6bhrrI//rYg7gedgipSC+sHRl+33NoWG
	MTqE3Ds9BdSfyqXlcOP+pjK9HhAAdhNz/0CdeV5nnEn8G1fvmm5JR7seLuZUeuy9
	tnxT+oEO/a60HLydAJBPcOdFzq7fpoNh6hCjpdX0F+AXlLtHZNFJ6tlqekunsXw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=AFqZr3
	Okh1uWvrXKrIYEcPgKPNNgB9HcgF6Y7JjgKhY3FFmNd6ZNfPjitdfVtfofYueDq1
	Q+YZDKC87AQxaZJlnTvVG0dzBtmGR4bKMV0cMzTf2VMlYhIDJpcPz8J45lgSyhqX
	2BLz6h1GjmGPm1BDpx7C8AbIq0jTFARm/uQdY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E676767BC;
	Wed,  7 Mar 2012 12:13:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C5E767BB; Wed,  7 Mar 2012
 12:13:39 -0500 (EST)
In-Reply-To: <1331117661-19378-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 7 Mar
 2012 17:54:14 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E2057282-6878-11E1-9AC6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192463>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> As discussed, this series removes test_expect_failure that are still
> not fixed in the end. It also adds update-server-info patch. I'll hol=
d
> off the rest of the previous series until 1.7.10 comes out.

Thanks; all look good.  Will queue and let's aim for 1.7.10-rc1 if
not earlier.
