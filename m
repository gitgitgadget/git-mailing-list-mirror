From: Arjen Laarhoven <arjen@yaph.org>
Subject: Re: [PATCH] t/annotate-tests: Use echo & cat instead of sed
Date: Thu, 5 May 2011 09:43:43 +0200
Message-ID: <20110505074343.GA17328@regex.yaph.org>
References: <1304570617-17603-1-git-send-email-brian@gernhardtsoftware.com> <7vk4e5bt90.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 05 09:43:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHtDx-0002vj-VJ
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 09:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548Ab1EEHnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 03:43:45 -0400
Received: from regex.yaph.org ([94.142.240.24]:38111 "EHLO regex.yaph.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751744Ab1EEHnp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 03:43:45 -0400
Received: by regex.yaph.org (Postfix, from userid 1000)
	id 0998F5B7D7; Thu,  5 May 2011 09:43:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vk4e5bt90.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172813>

On Wed, May 04, 2011 at 10:39:55PM -0700, Junio C Hamano wrote:
> An earlier patch from Arjen Laarhoven
> 
>   From: Arjen Laarhoven <arjen@yaph.org>
>   Subject: [PATCH] annotate.sh: Fix failing test on OS X
>   Date: Wed,  4 May 2011 15:36:21 +0200
>   Message-ID: <1304516181-92364-1-git-send-email-arjen@yaph.org>
> 
> seems to attempt to address the same issue but with a twist to deal with
> an incomplete line at the end of file.
> 
> Arjen, does Brian's patch look good to you, too?  It is much less tricky
> and should look obviously correct even to people who sees the code in
> question for the first time.

Yup, this looks much better than my fix.  At least I learned something
about the sed incompatibilities ;-)

Arjen

-- 
Arjen Laarhoven

The presence of those seeking the truth is infinitely to be preferred to 
those who think they've found it.
                                -- Terry Pratchett, "Monstrous Regiment"
