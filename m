X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-PS1 bash prompt setting
Date: Mon, 27 Nov 2006 00:48:24 -0800
Message-ID: <7vy7pxjmw7.fsf@assigned-by-dhcp.cox.net>
References: <BAYC1-PASMTP037FDA6C6465F0541AC613AEE90@CEZ.ICE>
	<Pine.LNX.4.63.0611261524130.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	<20061126094212.fde8cce7.seanlkml@sympatico.ca>
	<20061126150523.GB18828@hermes.lan.home.vilz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 08:48:47 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061126150523.GB18828@hermes.lan.home.vilz.de> (Nicolas Vilz's
	message of "Sun, 26 Nov 2006 16:05:23 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32401>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GocAK-0000Ub-DZ for gcvg-git@gmane.org; Mon, 27 Nov
 2006 09:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757458AbWK0Is0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 03:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757464AbWK0Is0
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 03:48:26 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:27808 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S1757458AbWK0IsZ
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 03:48:25 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061127084824.QJWZ18207.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Mon, 27
 Nov 2006 03:48:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id rkoY1V00J1kojtg0000000; Mon, 27 Nov 2006
 03:48:33 -0500
To: Nicolas Vilz <niv@iaglans.de>
Sender: git-owner@vger.kernel.org

Nicolas Vilz <niv@iaglans.de> writes:

> I glued that in my system bashrc with the extension, that it shows to me
> user.email out of repo-config, which is also very handy. So I am always
> reminded to set my user.credentials in .git/config and i always know which 
> role i play in the repository i am working at.

I think there is something wrong if the user needs to be
_constantly_ reminded who he is.  Care to explain?

There was a talk on the list about making "git-commit" (and
"git-merge" that does not do a fast-forward) refuse to proceed
until user.nameemail are explicitly set in the configuration.  I
think that particular implementation is a bad idea because it
punishes people who have set up their GECOS and hostname sanely,
but at the same time I do understand that people who just
started to use git would be very unhappy to learn that their
names were misspelled in GECOS field only after accumulating a
couple dozen commits.

