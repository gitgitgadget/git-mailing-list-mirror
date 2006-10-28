X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Add "next" link to commitdiff view
Date: Sat, 28 Oct 2006 12:00:49 -0700
Message-ID: <7vzmbg8dum.fsf@assigned-by-dhcp.cox.net>
References: <200610230037.57183.jnareb@gmail.com>
	<200610281810.36892.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 28 Oct 2006 19:01:31 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200610281810.36892.jnareb@gmail.com> (Jakub Narebski's message
	of "Sat, 28 Oct 2006 18:10:36 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30386>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdtQO-0003S7-7j for gcvg-git@gmane.org; Sat, 28 Oct
 2006 21:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964851AbWJ1TAw convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006 15:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbWJ1TAw
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 15:00:52 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:54773 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S964851AbWJ1TAv
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006
 15:00:51 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061028190050.FPN16798.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Sat, 28
 Oct 2006 15:00:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id fv0u1V00V1kojtg0000000 Sat, 28 Oct 2006
 15:00:55 -0400
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Jakub Narebski wrote:
>> Add a kind of "next" view in the bottom part of navigation bar for
>> "commitdiff" view.
>>=20
>> For commitdiff between two commits:
>> =A0 (from: _commit_)
>> For commitdiff for one single parent commit:
>> =A0 (parent: _commit_)
>> For commitdiff for one merge commit
>> =A0 (merge: _commit_ _commit_ ...)
>> For commitdiff for root (parentless) commit
>> =A0 (initial)
>> where _link_ denotes hyperlink. SHA1 is shortened to 7 characters on
>> display, everything is perhaps unnecessary esc_html on display.
>>=20
>> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
>> ---
>>=20
>> Junio (and others), is it what you wanted? The idea was to change
>> "commitdiff" view only in minimal way, and preserve similarity
>> to "commit" format.
>
> Any reasons not to accept this patch?

Nothing other than it was lost in the noise (I am partly
responsible for) that followed the patch.

	Message-ID: <200610230037.57183.jnareb@gmail.com>

Who acked this in the discussion?  I'd like to add "Acked-by:"
for them when I make the commit.
