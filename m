From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to update a cloned git repository
Date: Tue, 11 Sep 2012 09:05:52 -0700
Message-ID: <7v1ui8k0in.fsf@alter.siamese.dyndns.org>
References: <k2n4v2$88t$1@ger.gmane.org> <vpq7gs0es4f.fsf@bauges.imag.fr>
 <006f01cd900e$fce59a60$f6b0cf20$@schmitz-digital.de>
 <vpqy5kgdctm.fsf@bauges.imag.fr>
 <007001cd9016$8f980f80$aec82e80$@schmitz-digital.de>
 <vpq4nn4d968.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Joachim Schmitz" <jojo@schmitz-digital.de>,
	git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 11 18:06:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBSyS-0007jm-7d
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 18:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842Ab2IKQF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 12:05:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45615 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750726Ab2IKQFz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 12:05:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E14E06BDF;
	Tue, 11 Sep 2012 12:05:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nKg4oSitt5bUzKVybpfajNjUqYo=; b=liWyrU
	DWFfnKhmO/JvqlYs9coxkLYcdX5MV7V52RX7bmoHaZhBGkFGEzyF7TuECByShxwj
	HY2ElsapQAYz62DI6E8zNI1tWP+sf82mMcHv4+dyMzqkHPxNAzxRGcJyTL4yIAdR
	R1olC7MXLGVB2tIalnJYgKKJsA1g3mTlh06Ig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c7+YevHoxoTWNznQcj2WAm/tPc4CEKx+
	1Yv5tzQsZOGY86H4gvC3zppcrkunOsazfnGipN39tTWpk1Q1yDHYWi2CWQdBMObA
	27ISwF7Xk2V0mFX5ENGQSk0GqWj2cUcoA3fnnsBOYUdXVwej/j0+0ROTZw9G6OHu
	JBKBgz/qyas=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB9856BDD;
	Tue, 11 Sep 2012 12:05:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 438686BD8; Tue, 11 Sep 2012
 12:05:54 -0400 (EDT)
In-Reply-To: <vpq4nn4d968.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Tue, 11 Sep 2012 14:40:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 909D7368-FC2A-11E1-950B-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205243>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> [ Re-adding git@vger in Cc, I guess it was meant to be so ]
>
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
>
>>> Then, work on the tip of the topic branch you depend on instead of pu.
>>> These are more stable, as they will be rewritten only if this particular
>>> topic branch changes.
>>
>> These are not available from git hub. Or are they? How?
>
> I think they exist in some of the repos junio pushes to, but I don't
> remember how/which one.
>
> Anyway, you can easily get it from the commit that merges the branch
> (it's the-merge-commit^1).

I think it is the-merge-commit^2; contrib/git-resurrect.sh might be
of interest, too.
