X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-PS1 bash prompt setting
Date: Sat, 18 Nov 2006 22:28:14 -0800
Message-ID: <7vhcww7xxd.fsf@assigned-by-dhcp.cox.net>
References: <20061116130111.921396df.seanlkml@sympatico.ca>
	<20061117083801.GB11468@fry.bender.fht>
	<BAYC1-PASMTP0635A081EAC964E03599B4AEE80@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 19 Nov 2006 06:28:36 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <BAYC1-PASMTP0635A081EAC964E03599B4AEE80@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Fri, 17 Nov 2006 04:20:51 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31828>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlgAG-00012z-UJ for gcvg-git@gmane.org; Sun, 19 Nov
 2006 07:28:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756481AbWKSG2Q (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 01:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756480AbWKSG2Q
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 01:28:16 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:29914 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S1755204AbWKSG2P
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 01:28:15 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061119062815.GHAJ27894.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>; Sun, 19
 Nov 2006 01:28:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id oWTm1V00J1kojtg0000000; Sun, 19 Nov 2006
 01:27:47 -0500
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

Sean <seanlkml@sympatico.ca> writes:

> On Fri, 17 Nov 2006 09:38:02 +0100
> Nicolas Vilz <niv@iaglans.de> wrote:
>
>> Just a note:
>> 
>> this doesn't work with bash 3.2. I think they altered the way of
>> trimming variables in this version.
>> 
>> on systems with bash 3.2 installed, i get
>> [master!linus-2.6/vm/vm]$ 
>> with the example above.
>> 
>> on systems with bash 3.1, it works properly.
>
> Sorry bout that, I knew it was a bit fragile.  Was rather
> comical reading Junio's recent message about all the things not
> to do if you want portable shell code and noticing my 6 line script
> did 90% of them ;o)

Maybe I should have been more explicit when I said "${paremeter##word}
and friends".  Might not have been obvious, but I only meant the
following four: %, %%, # and ##.

${parameter/pattern/string} and ${parameter//pattern/string} are
not even in POSIX.

