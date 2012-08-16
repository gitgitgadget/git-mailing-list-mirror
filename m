From: Miklos Vajna <vmiklos@suse.cz>
Subject: Re: [PATCH] man: git pull -r is a short for --rebase
Date: Thu, 16 Aug 2012 21:45:52 +0200
Message-ID: <20120816194552.GA3167@suse.cz>
References: <20120816095018.GD5489@suse.cz>
 <7v1uj63iyx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 21:46:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2617-00060I-QR
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 21:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933185Ab2HPTqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 15:46:00 -0400
Received: from cantor2.suse.de ([195.135.220.15]:45594 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757488Ab2HPTp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 15:45:59 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 39055912E4;
	Thu, 16 Aug 2012 21:45:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v1uj63iyx.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Aug 16, 2012 at 09:22:14AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> I am not sure if this is worth it, as it comes from a natural
> "abbreviated options" support, i.e.
> 
> 	-r|--r|--re|--reb|--reba|--rebas|--rebase)
> 		rebase=true

I sent the patch as a (newcomer) friend today asked if it's intentional
that -r is undocumented in 'man git-pull'.

> And I do not think we particularly want to do
> 
>     +-r::
>     +--r::
>     +--re::
>     +--reb::
>     +--reba::
>     +--rebas::
>      --rebase::
>             Rebase the current...
> 
> for obvious reasons.

I agree, however, we already document -q and --quiet, or -v and
--verbose in the same manpage, so I think it would be consistent to have
-r there as well.

Thanks,

Miklos
