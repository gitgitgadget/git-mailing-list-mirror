From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: use {asterisk} in rev-list-options.txt
 when needed
Date: Tue, 28 Feb 2012 13:18:36 -0800
Message-ID: <7vhayay7v7.fsf@alter.siamese.dyndns.org>
References: <1330443348-5742-1-git-send-email-cmn@elego.de>
 <20120228194551.GC11725@sigill.intra.peff.net>
 <1330460423.691.15.camel@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Tue Feb 28 22:20:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2UTJ-0008UU-TA
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 22:20:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965394Ab2B1VSk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Feb 2012 16:18:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52164 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965122Ab2B1VSj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2012 16:18:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C94C37F29;
	Tue, 28 Feb 2012 16:18:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XTLjqjlJOFBs
	9S4ZpfQ9YmXO6Io=; b=ydBoHewrpuC/in9kc6mbWaN4ZPFSoClHv/sQzl3Qehp0
	XcJtQyIUHLJMWYLYJIOIvrdvtX0mM6NZfw4ujgxDRHWCp8uGTOFXdm5Kmf7D2Lts
	W5kV2qVvohppkX0+kSzTCa8v5jrypRLUbkriQp2DuIRq96vUMmL6IDxHKyDxEiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Ab/ptQ
	6HJb+70B+V/wBnMHaudED3r4rQdPmZOmsPKMuuqzHU9TOfLbMLaotgT5+62QpEZz
	pPbJpekiPtlUxLkX+Hd7Lw73EzewhYkJYpsogy6zJsdE1tnNueib2khWr/TsjL0d
	EgUFdJdunaMHksLo5okzpv9uR3ctqlO9SXe+Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1B507F28;
	Tue, 28 Feb 2012 16:18:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A8A27F26; Tue, 28 Feb 2012
 16:18:38 -0500 (EST)
In-Reply-To: <1330460423.691.15.camel@centaur.lab.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Tue, 28 Feb 2012 21:20:23
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7E1C702-6251-11E1-9216-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191785>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> On Tue, 2012-02-28 at 14:45 -0500, Jeff King wrote:
>> On Tue, Feb 28, 2012 at 04:35:48PM +0100, Carlos Mart=C3=ADn Nieto w=
rote:
>>=20
>> > Text between to '*' is emphasized in AsciiDoc which made the
>>=20
>> s/to/two/
>
> Oops. Thanks. Can you squash that in, Junio?

Thanks; done.
