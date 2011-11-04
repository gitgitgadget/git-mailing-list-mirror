From: Junio C Hamano <junio@pobox.com>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Fri, 04 Nov 2011 14:22:28 -0700
Message-ID: <7v39e3bn1n.fsf@alter.siamese.dyndns.org>
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
 <CA+55aFzstE-+NzfSAWMEokB7-rYsZOcZe9Ez-LxPNOKnciJ3UQ@mail.gmail.com>
 <7vlirvbq47.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Shawn Pearce <spearce@spearce.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-ide-owner@vger.kernel.org Fri Nov 04 22:22:34 2011
Return-path: <linux-ide-owner@vger.kernel.org>
Envelope-to: lnx-linux-ide@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-ide-owner@vger.kernel.org>)
	id 1RMRDd-0002mW-5n
	for lnx-linux-ide@lo.gmane.org; Fri, 04 Nov 2011 22:22:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753712Ab1KDVWc (ORCPT <rfc822;lnx-linux-ide@m.gmane.org>);
	Fri, 4 Nov 2011 17:22:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47191 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753413Ab1KDVWb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Nov 2011 17:22:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A679677A;
	Fri,  4 Nov 2011 17:22:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vIIXSyXe7o1VFMfjn8+AAJ1PBWg=; b=p2qOxv
	wg1BS87U81i8F8bvOZw8qe53nBruyrKUNA+SpmUAajYcda+FqiMcRIcMgnNSPXGD
	vL3sVpaLZT1DViWxQImWhX2iTEW034RemUanMYnkZ9SO1RPVX14qYcnjfTkcUD2U
	32iZ1miQiEPNtRBusFCiWH0xUnduxtbjtYs1E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KUtZtKMvFC/ZxPm9Bq1yrk2/4P8uCcEY
	HSE2HT9Tp8G8TQJOuJVQYZi6j9+vo1av4Quwkww4Uet8JfzpjT+IGzD50GECtkWw
	i+3thbzvdxR2eRFMszGy48wd3YBKacFKKcNsTUB2Svyhp/hMLz8cwWQDclaxNCsv
	ghmGpHi7ATI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F70D6779;
	Fri,  4 Nov 2011 17:22:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2AE86778; Fri,  4 Nov 2011
 17:22:29 -0400 (EDT)
In-Reply-To: <7vlirvbq47.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 04 Nov 2011 13:16:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1A003230-072B-11E1-8EED-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184805>

Junio C Hamano <gitster@pobox.com> writes:

> However we would need to audit so that we do not accidentally record the
> tag object names in the "parent" headers in the merge commits, which is
> what I'll be doing next.

Just reporting my findings.

builtin/merge.c was updated to use want_commit() that uses peel_to_type()
to commit to make sure we do not get fed anything funky, and also uses
struct commit_list to pass around list of parents to be recorded, so we
should be OK in this department.
