From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Suggested improvements to the git-p4 documentation
 (branch-related)
Date: Sat, 23 Feb 2013 11:11:04 -0800
Message-ID: <7v1uc6977b.fsf@alter.siamese.dyndns.org>
References: <CAFXk4bqt_pMVDtVKF-JiQuGbSpy2+_rGOg5RTTE+0pNKFcZh3w@mail.gmail.com>
 <20130105212517.GA30315@padd.com>
 <CAFXk4bp0MBNxOD7w1zn7peN-ufWmV=DthMdHmjmj+Sci4MGneg@mail.gmail.com>
 <7va9qvc13r.fsf@alter.siamese.dyndns.org> <20130223144803.GA5444@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Olivier Delalleau <shish@keba.be>, git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 20:11:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9KVY-0002jY-H8
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 20:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758000Ab3BWTLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 14:11:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49674 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757580Ab3BWTLI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 14:11:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66EB3BFD8;
	Sat, 23 Feb 2013 14:11:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iI2gIBSIo2v4UA5jsWrg1YVQQ60=; b=HcjTIQ
	CDmDazsTvt4EHx9+NaqO6wLq1Vh2p4O1ERpGVNVOPhFi8CEJBgQ5UxtUZchtgWIR
	sRZ3oGGC47bpBT3MyEzTb5BSkdzrbhPNO1IRKaktONV275GDw71h/9dVHeSNHDeo
	6fQ2AQ//XdHGb5VUSGGaUdoRsonOqdcTxfC6A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YhxOmR2ffE4IIQe71KWMB8qjXV1bruLc
	tO55vI8b/nflbAwu8nI+7T0Det8xB4PbqYC58Cdg8ALPVjYcAquosalqebjracgY
	9jxYuvz5Qlz70Mpi8RG2pUj+qHT4U/YRW4dvaxDMjJ+2V8MZpUS2HBFr/D+bGc71
	FLjUl8Qfquw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B111BFD7;
	Sat, 23 Feb 2013 14:11:06 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D3F82BFD5; Sat, 23 Feb 2013
 14:11:05 -0500 (EST)
In-Reply-To: <20130223144803.GA5444@padd.com> (Pete Wyckoff's message of
 "Sat, 23 Feb 2013 09:48:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C5CBDA22-7DEC-11E2-9B43-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216910>

Pete Wyckoff <pw@padd.com> writes:

> All of it is in master now, via 801cbd7 (Merge branch
> 'pw/p4-branch-fixes', 2013-01-21).
>
> I should have commented on this thread too.  Thanks for following
> up!

Thanks.
