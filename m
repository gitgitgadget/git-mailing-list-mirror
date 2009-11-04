From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update packfile transfer protocol documentation
Date: Tue, 03 Nov 2009 16:40:00 -0800
Message-ID: <7vbpjjp1gf.fsf@alter.siamese.dyndns.org>
References: <d411cc4a0911011518q15a8267bn642e6937be8c9ab1@mail.gmail.com>
 <7vzl74trmc.fsf@alter.siamese.dyndns.org>
 <20091102235707.GV10505@spearce.org>
 <7vtyxctpf8.fsf@alter.siamese.dyndns.org>
 <20091103005815.GW10505@spearce.org>
 <d411cc4a0911031405x60ea2396o35eea78a0b07fda9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 01:40:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5TvB-0003ob-NU
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 01:40:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbZKDAkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 19:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbZKDAkI
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 19:40:08 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47437 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbZKDAkH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 19:40:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0672C9143C;
	Tue,  3 Nov 2009 19:40:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LSTJcWH8CKIb7ToO79KEKDXNDQg=; b=wr3IyD
	KanX7QgNwoDPOww1ruIaHZXiQRgu+aUyM3/vmOlKRhIROFLK+PR9yn8JCwmk9npJ
	QgPozczuwTzYJsteCDfjJllgHBMbCyWiO4D5lwxMN9ojuVPDf/Tyw4QKXRavX5aV
	d3jOAOnfvblaTsaGv88Ywrq/YvuBn+SnM0x2g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mhyYTnxBHdE7AKPl61G1bTOgMqlkx/MT
	2JLF0an7XNS0klwf2hysBC45iMkIiM39LbKugckWEwEMiVVO96AIHpHJgbylOw0R
	io4mIUCdhaamA7pFyAx2SQY7iQu37oj181s/TpYCt+j2RqxIzQivgOQMlJJuoo9E
	MnYNpPNkGw0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CE7C89143B;
	Tue,  3 Nov 2009 19:40:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 808F59143A; Tue,  3 Nov 2009
 19:40:02 -0500 (EST)
In-Reply-To: <d411cc4a0911031405x60ea2396o35eea78a0b07fda9@mail.gmail.com>
 (Scott Chacon's message of "Tue\, 3 Nov 2009 14\:05\:12 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 994C37E6-C8DA-11DE-8C02-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132011>

Scott Chacon <schacon@gmail.com> writes:

> Would you prefer that I try to incorporate all these comments and
> submit another patch, or are you going to modify it in-tree?

I prefer to not munge other people's patches if the modification will
involve more than ten lines and if I know the original submitter can be
trusted to do the right thing.

I would rewrite other's patch myself heavily _only_ after I tried the
usual "suggest to improve" and found that it would not be worth my time to
wait for yet more rounds that would require more suggestions, major part
of which will eventually be forgotten or ignored again, iow, when I sense
that the communication with the contributor is hopelessly inefficient.

Needless to say, you have been here long enough to be in the "trusted"
category.

Thanks.
