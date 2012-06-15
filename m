From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] diff --no-index pager cleanups
Date: Fri, 15 Jun 2012 14:18:15 -0700
Message-ID: <7v1ulg9svc.fsf@alter.siamese.dyndns.org>
References: <20120615202813.GA12253@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 15 23:18:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfduS-0006G3-LG
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 23:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757982Ab2FOVSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 17:18:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33369 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751755Ab2FOVSU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 17:18:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F34E916F;
	Fri, 15 Jun 2012 17:18:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BcnXogYvJDgJVzqA+12+gzvCV94=; b=V7a298
	FNBgqvDsLZqOoMT71vc6zwAPYv8Bkq4IxN/TZ3ujnNGUKGLf8/rCJeIOaJl2121a
	i3OJtn6PaxbLhrpI58Xy6SokAu9kHZhhMPGGxE5oq7z6C5YAaPYIU4il+TYATKqp
	QDF6Y5vit//S/G4wN3t4h6xw16xj+DHtaoFZM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PEp7Q1T7VA0rkRGeQtz644+Rku9HfwaE
	inNWGhCymHrpiN48dpmTYBZkie7R91ELb82vg9MHx7JppTsGGyytOcI3dvtwXgH1
	cGWn0EZvGcHHyp89zEz8PLuY7EUtO76mXR4A9QS/oEkoMPevWsBV8oF3u9q5AMV3
	+Z6yFMiobNE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84EC2916E;
	Fri, 15 Jun 2012 17:18:17 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1AA00916D; Fri, 15 Jun 2012
 17:18:17 -0400 (EDT)
In-Reply-To: <20120615202813.GA12253@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 15 Jun 2012 16:28:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9FDC9B82-B72F-11E1-BE43-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200099>

Jeff King <peff@peff.net> writes:

> While testing Tim's broken case, I noticed a few annoyances with the
> pager handling. These patches should clear them up.
>
>   [1/2]: fix pager.diff with diff --no-index
>   [2/2]: do not run pager with diff --no-index --quiet

Both look sane to me.  Thanks.
