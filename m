From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: "git help stage" doesn't display git-stage man page
Date: Wed, 03 Dec 2008 10:29:22 +0200
Message-ID: <87bpvtmzkt.fsf@iki.fi>
References: <7vvdu1hj41.fsf@gitster.siamese.dyndns.org>
	<87myfdn2ga.fsf@iki.fi> <7vwsehfzf7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 09:31:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7n8H-0005dW-Ac
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 09:30:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbYLCI3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 03:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbYLCI3h
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 03:29:37 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:42103 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751208AbYLCI3g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 03:29:36 -0500
Received: from mithlond.arda.local (80.220.180.181) by kirsi2.inet.fi (8.5.014)
        id 48FC5B8901FF2490; Wed, 3 Dec 2008 10:29:33 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1L7n6o-00037H-Nf; Wed, 03 Dec 2008 10:29:22 +0200
In-Reply-To: <7vwsehfzf7.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 03 Dec 2008 00\:14\:36 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102227>

Junio C Hamano (2008-12-03 00:14 -0800) wrote:

> By the way, I think this should fix it, although it is very late and I
> have no time to test it tonight myself.

It does fix it for me. Thanks.


> diff --git i/Makefile w/Makefile
> index 9577d6f..5158197 100644
> --- i/Makefile
> +++ w/Makefile
> @@ -320,6 +320,7 @@ BUILT_INS += git-merge-subtree$X
>  BUILT_INS += git-peek-remote$X
>  BUILT_INS += git-repo-config$X
>  BUILT_INS += git-show$X
> +BUILT_INS += git-stage$X
>  BUILT_INS += git-status$X
>  BUILT_INS += git-whatchanged$X
