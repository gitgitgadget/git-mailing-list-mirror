From: Miles Bader <miles.bader@necel.com>
Subject: Re: [PATCH 1/3] git-bisect: war on "sed"
Date: Thu, 15 Nov 2007 18:53:58 +0900
Message-ID: <buotznnesw9.fsf@dhapc248.dev.necel.com>
References: <20071115081807.06fe092b.chriscool@tuxfamily.org>
	<7voddv6fxz.fsf@gitster.siamese.dyndns.org>
	<buozlxfeu0z.fsf@dhapc248.dev.necel.com>
	<995F69D5-4ABC-44E7-BA2B-5E276479EDA1@wincent.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 10:55:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsbR8-0002wa-Vt
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 10:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756160AbXKOJyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 04:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755843AbXKOJyo
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 04:54:44 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:45252 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112AbXKOJyn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 04:54:43 -0500
Received: from relay11.aps.necel.com ([10.29.19.46])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id lAF9qw74026546;
	Thu, 15 Nov 2007 18:53:58 +0900 (JST)
Received: from relay31.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay11.aps.necel.com with ESMTP; Thu, 15 Nov 2007 18:53:58 +0900
Received: from dhapc248.dev.necel.com ([10.114.112.215] [10.114.112.215]) by relay31.aps.necel.com with ESMTP; Thu, 15 Nov 2007 18:53:58 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id 04F8143B; Thu, 15 Nov 2007 18:53:58 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <995F69D5-4ABC-44E7-BA2B-5E276479EDA1@wincent.com> (Wincent Colaiuta's message of "Thu\, 15 Nov 2007 10\:36\:02 +0100")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65101>

Wincent Colaiuta <win@wincent.com> writes:
> the shorter form without sed is arguably more readable:
>
> -		echo "$head" | sed 's#^refs/heads/##' >"$GIT_DIR/head-name"
> +		echo "${head#refs/heads/}" >"$GIT_DIR/head-name"

Er, I suppose -- if you are acquainted with that particular shell
variable syntax (I suspect knowledge of sed is far more widespread).

[personally, I know that syntax has something to do with replacing
something with something else, but really haven't much clue other than
that, and I always _thought_ it was bash-specific and so avoided using
any of that stuff.]

-miles
-- 
People who are more than casually interested in computers should have at
least some idea of what the underlying hardware is like.  Otherwise the
programs they write will be pretty weird.  -- Donald Knuth
