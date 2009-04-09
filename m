From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] graph API: Added logic for colored edges
Date: Wed, 08 Apr 2009 17:29:31 -0700
Message-ID: <7vocv6is9g.fsf@gitster.siamese.dyndns.org>
References: <20090331235922.GA7411@linux.vnet>
 <20090407185724.GA9996@linux.vnet>
 <7vd4bnpodt.fsf@gitster.siamese.dyndns.org>
 <20090408214129.GA20764@linux.vnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 09 02:31:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LriAk-0008Uz-3T
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 02:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756651AbZDIA3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 20:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756329AbZDIA3k
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 20:29:40 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39896 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755996AbZDIA3j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 20:29:39 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D2157DCB8;
	Wed,  8 Apr 2009 20:29:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 178F2DCB7; Wed, 
 8 Apr 2009 20:29:32 -0400 (EDT)
In-Reply-To: <20090408214129.GA20764@linux.vnet> (Allan Caffee's message of
 "Wed, 8 Apr 2009 17:41:29 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 821406E4-249D-11DE-8571-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116134>

Allan Caffee <allan.caffee@gmail.com> writes:

> The problem with making it an index into the column_colors array is that
> we don't have a convenient place to test whether the user actually wants
> color.  We can't do it in strbuf_write_column because AFAIK there's no
> way to get the rev-info to test the options.  I suppose we could define
> GIT_NOT_A_COLOR to -1 and just set the color to that when we don't
> intend to use color.  (Either way I should probably change that to an
> unsigned short.)  What do you think?

Sounds sensible.
