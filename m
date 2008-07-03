From: Tim Stoakes <tim@stoakes.net>
Subject: Re: about c8af1de9 (git status uses pager)
Date: Thu, 3 Jul 2008 11:45:41 +0930
Message-ID: <20080703021541.GK18147@mail.rocksoft.com>
References: <alpine.LNX.1.10.0806212319410.22036@fbirervta.pbzchgretzou.qr> <19f34abd0806211430x3d7195d8idc61b7103f899947@mail.gmail.com> <7vzlpe8nyo.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.10.0806212343560.18093@fbirervta.pbzchgretzou.qr> <alpine.LNX.1.10.0806221107540.15126@fbirervta.pbzchgretzou.qr> <7vtzflolis.fsf@gitster.siamese.dyndns.org> <7vtzfln5zw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 09:00:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEInq-0002Wt-3G
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 09:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754780AbYGCG7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 02:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754449AbYGCG5j
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 02:57:39 -0400
Received: from hosted01.westnet.com.au ([203.10.1.211]:60194 "EHLO
	hosted01.westnet.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635AbYGCCkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 22:40:25 -0400
X-Greylist: delayed 1453 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Jul 2008 22:40:24 EDT
Received: from hosted01.westnet.com.au (hosted01.westnet.com.au [127.0.0.1])
	by hosted01.westnet.com.au (Postfix) with SMTP id 7C64F2BF031;
	Thu,  3 Jul 2008 10:16:09 +0800 (WST)
Received: from mail.stoakes.net (dsl-202-173-137-105.sa.westnet.com.au [202.173.137.105])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hosted01.westnet.com.au (Postfix) with ESMTP id 157182BEFD4;
	Thu,  3 Jul 2008 10:16:08 +0800 (WST)
Received: from noodle.stoakes.net (unknown [192.168.20.209])
	by mail.stoakes.net (Postfix) with ESMTP id 35FE728C172;
	Thu,  3 Jul 2008 21:16:07 +0930 (CST)
Received: by noodle.stoakes.net (Postfix, from userid 1000)
	id 33EF27F033; Thu,  3 Jul 2008 11:45:41 +0930 (CST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vtzfln5zw.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-PMX-Branch: TNG-Outgoing
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87223>

Junio C Hamano(gitster@pobox.com)@220608-03:01:
> Having said all that, I have to say I am regretting to have accepted that
> patch to enable pager on status, not because it bothers me personally (it
> doesn't primarily because I practically never run git-status because I
> consider the command useless and living almost always in Emacs helps), but
> because in principle changing anything that existing users are used to is
> bad.
> 
> Jeff had a patch to allow boolean configuration variable "pager.<command>"
> to override the built-in pager settings during 1.5.6 cycle, and I think it
> was a reasonable approach to take.  People who want to page output from
> git-status can then set "pager.status = true" in their configuration (and
> then we can revert c8af1de (make git-status use a pager, 2008-04-23)).
> Alternatively we could keep the current status-quo for the default, and
> people can say "pager.status = false" in their configuration.

I'd really like to see this. Setting core.pager to `less -FSRX` or
similar is not useful for me - I *want* to have -X for eg. `git diff`,
but I don't want paging at all for status.

This was quite a nasty change to sneak on people I think.

Tim

-- 
Tim Stoakes
