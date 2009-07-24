From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git init: optionally allow a directory argument
Date: Fri, 24 Jul 2009 16:36:31 -0700
Message-ID: <7vab2t64cg.fsf@alter.siamese.dyndns.org>
References: <20090725065928.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 01:36:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUUJf-0006ex-AY
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 01:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755210AbZGXXgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 19:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754424AbZGXXgg
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 19:36:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56027 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672AbZGXXgf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 19:36:35 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 153F1108AE;
	Fri, 24 Jul 2009 19:36:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 12B84108A6; Fri, 24 Jul 2009
 19:36:32 -0400 (EDT)
In-Reply-To: <20090725065928.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Sat\, 25 Jul 2009 06\:59\:28 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D3C7CF6E-78AA-11DE-ACC9-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123977>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> When starting a new repository, I see my students often say
>
>     % git init newrepo
>
> and curse git.  They could say
>
>     % mkdir newrepo; cd newrepo; git init
>
> but allowing it as an obvious short-cut may be nicer.
>
> Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>

Hmm, I didn't realize this is so common a wish among new people.

The patch seems clean.  Anybody has comments, both on code and the use
case?
