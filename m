From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] user-manual: new "getting started" section
Date: Tue, 17 Nov 2009 14:19:36 -0800
Message-ID: <7v4ooseqvb.fsf@alter.siamese.dyndns.org>
References: <7vr5ss64e5.fsf@alter.siamese.dyndns.org>
 <94a0d4530910250243k4cbc3c18l5e018a05e5afdb2d@mail.gmail.com>
 <20091025111438.GA11252@progeny.tock>
 <94a0d4530911111515q643e263bn3adc6b47cd968d3d@mail.gmail.com>
 <4AFBF18E.7070906@drmicha.warpmail.net>
 <20091114060600.6117@nanako3.lavabit.com>
 <94a0d4530911161452xe82858el322a1985341bf13c@mail.gmail.com>
 <20091117210625.6117@nanako3.lavabit.com>
 <20091117172815.GH31767@fieldses.org>
 <7vocn1dn5d.fsf@alter.siamese.dyndns.org>
 <94a0d4530911171400ub3b093ai668fd2404b12272f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Hannu Koivisto <azure@iki.fi>, Jeff King <peff@peff.net>,
	Wincent Colaiuta <win@wincent.com>,
	Matthias Lederhofer <matled@gmx.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 23:20:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAWPD-0005VT-Ds
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 23:20:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756384AbZKQWT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 17:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756380AbZKQWT7
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 17:19:59 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48061 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756377AbZKQWT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 17:19:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6268F9F9F9;
	Tue, 17 Nov 2009 17:20:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9JO/dKxAAUENSpjKov4ix2obNLc=; b=QCFT6K
	jNG+GQ94Y37cfc9/BSFBepcYhvf9FZhngfC9o8dUHGfTW+sYn2aWZ45FuEZv1uf4
	G7CMfdGRn0WDmiJSjTsc0Vd9DwFX8bcUC/WnGL2U/aNHEcKcgBlGS8qh1dUCjWjz
	jXtD03F6t3J+tkzq92PHbMBfH+kgAJoEFTkls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EOqLdBjjT9A934Dy7nnXDCMLoB83V6wr
	6IZzXkljE7R7UdmbTmE4m/3TE6q/cbw3IcP3aODMKg/62fYw0e6f9Bn1GbuEnjTB
	FvyjYyrUOkuWiRlDtdiewekpoFaJoJd337q96TGiuwzvHZP4HasH7sKB0bWDibRE
	5DLiExOL5fc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AA1EB9F9F3;
	Tue, 17 Nov 2009 17:19:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E91049F9EC; Tue, 17 Nov 2009
 17:19:37 -0500 (EST)
In-Reply-To: <94a0d4530911171400ub3b093ai668fd2404b12272f@mail.gmail.com>
 (Felipe Contreras's message of "Wed\, 18 Nov 2009 00\:00\:46 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 54731D2C-D3C7-11DE-AF87-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133106>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> That could be easily fixed by making explicit in the syntax that these
> are not typical refs: i.e. @stage and @work.

The message I get from that suggestion is that the most sensible approach,
if we are going to add something from this discussion to "git diff", is to
do what you did _not_ quote from my message, which is:

    As to --tree-vs-index counterproposal (was it a counterproposal?),
    except for that I think they are too long to type in practice and need
    to be shortened to be useful, I do not have a fundamental objection
    against it.

IOW, this is about options, and should not be done as syntax sugar that
does a half-baked job of pretending to be refs.
