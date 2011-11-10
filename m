From: Junio C Hamano <junio@pobox.com>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Thu, 10 Nov 2011 07:15:15 -0800
Message-ID: <7vaa84t3ek.fsf@alter.siamese.dyndns.org>
References: <20111026202235.GA20928@havoc.gtf.org>
 <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike>
 <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org>
 <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <7vwrbjlj5r.fsf@alter.siamese.dyndns.org>
 <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>
 <7vk47jld5s.fsf@alter.siamese.dyndns.org>
 <CA+55aFz7TeQQH3D4Tpp31cZYZoQKeK37jouo+2Kh61Wa07knfw@mail.gmail.com>
 <CAJo=hJv5nAKH_ptYSWfMvFQv0Dj+naPXK35wSzKYkfPOYsWkxg@mail.gmail.com>
 <CA+55aFx0oCd6-sh0psYxho-s=sHAK0RHXJHfLewRuUcdXzxZbg@mail.gmail.com>
 <CA+55aFwXu=+HdQ5nW11Ts5p-V=KgpxjyagKqB+Xv+qBOEEWXvQ@mail.gmail.com>
 <7v62j1gitn.fsf@alter.siamese.dyndns.org>
 <7vvcr1f38j.fsf@alter.siamese.dyndns.org>
 <CA+55aFyRawm9CoJMiEXDFCX4YTidPOiV4oqSS2d7nNv7Ecw8BQ@mail.gmail.com>
 <7v4nydurzh.fsf@alter.siamese.dyndns.org>
 <CALKQrgfZtELcK3H5ZYvmcW8RrtKMVRACFTvw3s5SidFvmFWkGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Ted Ts'o" <tytso@mit.edu>, Shawn Pearce <spearce@spearce.org>,
	git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Nov 10 16:15:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROWLg-0006cM-O1
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 16:15:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935122Ab1KJPPW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Nov 2011 10:15:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42781 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935113Ab1KJPPT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2011 10:15:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D44194CFA;
	Thu, 10 Nov 2011 10:15:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3T52yBGnQPZW
	xCTnHFA/Nl6oMMQ=; b=tt/gVeVyJTN56gyicvRkJqvh2Z6ch3nv0f3yWusPRl0s
	nP6bOtMtIzBvc8SasHPyRnkEjoNd5BtUKeqG0V3DTxa+YL6U1PQQvDO/8N+HZ/LD
	siLndVIawEyNawkPMZN2A+i67Hv6iUaOp/21b9eLwQWo8rLA4U/5dZXSpwNKtNA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hKMX80
	pQyX8B532msK8U3f1sRLtshRdEgPRT6xDKsq9O+MSD+y1jWBWGlq2waKhEtzHMh/
	XtElF4jBVmKviWOtfdE/7Ug3QDqddEXdysMyilmGoWbVOLzwSfY3Ax3jHCY1HCIy
	4lsgld7s+3AlGlPWJhS+7vExWH5slbbjb50/A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB9534CF9;
	Thu, 10 Nov 2011 10:15:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 54FAD4CF8; Thu, 10 Nov 2011
 10:15:17 -0500 (EST)
In-Reply-To: <CALKQrgfZtELcK3H5ZYvmcW8RrtKMVRACFTvw3s5SidFvmFWkGw@mail.gmail.com> (Johan
 Herland's message of "Thu, 10 Nov 2011 09:02:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CC137F0E-0BAE-11E1-89D2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185233>

Johan Herland <johan@herland.net> writes:

> On Wed, Nov 9, 2011 at 18:26, Junio C Hamano <gitster@pobox.com> wrot=
e:
>> =C2=A0- "git notes" is represented as a commit that records a tree t=
hat holds
>> =C2=A0 the entire mapping from commit to its annotations, and the on=
ly way to
>> =C2=A0 transferr it is to send it together with its history as a who=
le. It
>> =C2=A0 does not have the nice auto-following property that transfers=
 only the
>> =C2=A0 relevant annotations.
>
> True. However, consider these mitigating factors:
> ...
>
> My point is that although "notes" might end up transferring more
> annotations than strictly necessary, I believe that in practice all t=
he
> notes being transferred are already (or will soon become) relevant.

Sorry, but I do not think you are considering what would happen when yo=
u
have many branches with different purposes, whose commits near tips wil=
l
never get merged with each other. "automatic following" semantics like
what "git fetch" does for signed tags is absolutely necessary in such a
case, and the above are not mitigating factors at all in that context.
