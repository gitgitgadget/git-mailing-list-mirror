X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: spurious .sp in manpages
Date: Sat, 16 Dec 2006 04:08:28 -0800
Message-ID: <7v1wn0hwlf.fsf@assigned-by-dhcp.cox.net>
References: <20061216095242.GC13144@socrates.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 16 Dec 2006 12:08:35 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061216095242.GC13144@socrates.priv> (Tom Prince's message of
	"Sat, 16 Dec 2006 02:52:42 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34610>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvYLA-0005XV-W5 for gcvg-git@gmane.org; Sat, 16 Dec
 2006 13:08:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030885AbWLPMI3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 07:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030887AbWLPMI3
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 07:08:29 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:58327 "EHLO
 fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1030885AbWLPMI3 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 07:08:29 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061216120828.PRZK20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Sat, 16
 Dec 2006 07:08:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id zQ7o1V00D1kojtg0000000; Sat, 16 Dec 2006
 07:07:49 -0500
To: Tom Prince <tom.prince@ualberta.net>
Sender: git-owner@vger.kernel.org

Tom Prince <tom.prince@ualberta.net> writes:

> On Wed, Dec 13, 2006 at 12:58:28AM -0800, Junio C Hamano wrote:
>> This is just a random hack to work around problems people seem
>> to be seeing in manpage backend of xmlto (it appears we are
>> getting ".sp" at the end of line without line break).
>> 
>> Could people test this out?
>> 
>
> This fixes the files available in the man branch of git.git.

Thanks.

> P.S. I have this fragment in config.mak to install the manpages without
> asciidoc. 
>
> man:
> 	git-archive --format=tar --prefix=${prefix}/man/ man | tar xP
> install: man
>
> .PHONY: man

It's tempting to take it, but that is chicken and egg for me
;-).
