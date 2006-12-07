X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add config example with respect to branch
Date: Thu, 07 Dec 2006 11:20:47 -0800
Message-ID: <7v8xhjtsvk.fsf@assigned-by-dhcp.cox.net>
References: <4577B687.5080907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 19:20:58 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <4577B687.5080907@gmail.com> (Aneesh Kumar K. V.'s message of
	"Thu, 07 Dec 2006 12:06:55 +0530")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33608>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsOnc-00051U-BG for gcvg-git@gmane.org; Thu, 07 Dec
 2006 20:20:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937997AbWLGTUt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 14:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937969AbWLGTUt
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 14:20:49 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:55335 "EHLO
 fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S937997AbWLGTUs (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 14:20:48 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061207192047.WBKN4226.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Thu, 7
 Dec 2006 14:20:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id vvLx1V00r1kojtg0000000; Thu, 07 Dec 2006
 14:20:58 -0500
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Sender: git-owner@vger.kernel.org

I've tolerated patches in attachments, but please do not do
this:

    This is a multi-part message in MIME format.
    --------------010006030902030700040300
    Content-Type: text/plain; charset=ISO-8859-1; format=flowed
    Content-Transfer-Encoding: 7bit


    --------------010006030902030700040300
    Content-Type: text/plain;
     name="0001-Add-config-example-with-respect-to-branch.txt"
    Content-Transfer-Encoding: 7bit
    Content-Disposition: inline;
     filename="0001-Add-config-example-with-respect-to-branch.txt"

    From: Aneesh Kumar K.V <aneesh.kumar@gmail.com>

    Update config.txt with example with respect to branch
    config variable. This give a better idea regarding
    how branch names are expected.

    Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
    ---
     Documentation/config.txt |    5 +++++
     1 files changed, 5 insertions(+), 0 deletions(-)


Instead have the proposed commit log message (and From: line if
you are forwarding somebody else's patch, or if your MUA does
not record your own name correctly) in the first part (which is
empty in your message).

