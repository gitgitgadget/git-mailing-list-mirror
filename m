From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: What's cooking in git.git (Jul 2013, #03; Tue, 9)
Date: Mon, 15 Jul 2013 18:51:49 +0100
Message-ID: <51E436B5.6000303@ramsay1.demon.co.uk>
References: <7vr4f7tjo0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 19:53:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uymxt-0003Ds-ER
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 19:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570Ab3GORxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 13:53:33 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:49065 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753544Ab3GORxb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 13:53:31 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id CBB4E1280A8;
	Mon, 15 Jul 2013 18:53:29 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 1E4441280CB;
	Mon, 15 Jul 2013 18:53:29 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP;
	Mon, 15 Jul 2013 18:53:28 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <7vr4f7tjo0.fsf@alter.siamese.dyndns.org>
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230500>

Junio C Hamano wrote:
[ ... ]
> * rr/send-email-ssl-verify (2013-07-06) 6 commits
>  - SQUASH??? update to support SSL_ca_file as well as SSL_ca_path
>  - SQUASH??? send-email: cover both smtps and starttls cases
>  - fixup! send-email: squelch warning from Net::SMTP::SSL
>  - SQUASH??? send-email giving default value to ssl-cert-path with ||= assignment
>  - send-email: introduce sendemail.smtpsslcertpath
>  - send-email: squelch warning from Net::SMTP::SSL
> 
>  The issue seems a lot deeper than the initial attempt and needs
>  somebody to sit down and sort out to get the version dependencies
>  and lazy loading right.

This causes test failures for me, since send-email can't load the
IO/Socket/SSL.pm module. (on Linux, cygwin and MinGW!)

[ ... ]

> --------------------------------------------------
> [Stalled]
> 
> * rj/read-default-config-in-show-ref-pack-refs (2013-06-17) 3 commits
>  - ### DONTMERGE: needs better explanation on what config they need
>  - pack-refs.c: Add missing call to git_config()
>  - show-ref.c: Add missing call to git_config()
> 
>  The changes themselves are probably good, but it is unclear what
>  basic setting needs to be read for which exact operation.
> 
>  Waiting for clarification.
>  $gmane/228294

Sorry, still on my TODO list. (Having said that, I'm no longer sure
that these patches do the right thing! ;-)

ATB,
Ramsay Jones
