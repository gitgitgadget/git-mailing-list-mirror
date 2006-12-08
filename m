X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add branch.*.localmerge and documentation update
Date: Fri, 08 Dec 2006 13:38:41 -0800
Message-ID: <7vr6vagja6.fsf@assigned-by-dhcp.cox.net>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com>
	<8aa486160612071756s18f9530cr7ed26e4b7b47d1de@mail.gmail.com>
	<200612081823.45565.Josef.Weidendorfer@gmx.de>
	<200612082012.19167.Josef.Weidendorfer@gmx.de>
	<8aa486160612081252t1e245104x58c8a6654d887af5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 8 Dec 2006 21:38:53 +0000 (UTC)
Cc: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>,
	"Junio C Hamano" <junkio@cox.net>,
	"Aneesh Kumar K.V" <aneesh.kumar@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <8aa486160612081252t1e245104x58c8a6654d887af5@mail.gmail.com>
	(Santi =?iso-8859-1?Q?B=E9jar's?= message of "Fri, 8 Dec 2006 21:52:15
 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33750>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsnQd-0000tG-Qw for gcvg-git@gmane.org; Fri, 08 Dec
 2006 22:38:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947273AbWLHVip convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006 16:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947317AbWLHVip
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 16:38:45 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:37498 "EHLO
 fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1947273AbWLHVio convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 16:38:44 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061208213844.YEK20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Fri, 8
 Dec 2006 16:38:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id wMe61V00Q1kojtg0000000; Fri, 08 Dec 2006
 16:38:07 -0500
To: =?iso-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>
Sender: git-owner@vger.kernel.org

"Santi B=E9jar" <sbejar@gmail.com> writes:

> On 12/8/06, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
>> Clarify the meaning of branch.*.merge option and add a similar
>> branch.*.localmerge option, which can be used to specify a local
>> tracking branch to be merged by default.
>>
>> Previously, if branch.*.merge was specified but did not match any
>> ref, the message "No changes." was not really helpful regarding
>> the misconfiguration. This now gives a warning.
>>
>> The value of branch.*.merge can be a list to get an octopus
>> merge. I chose the same way for branch.*.localmerge, and if
>> you specify both options, the octopus merge will have even
>> more parents ;-)
>>
>> Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
>
> Ack for the documentation part. But the localmerge part is almost
> equivalent to my patch to allow the branch.<name>.remote equal to "."=
=2E

I am not so sure about the "localmerge" stuff anymore.

What convenience would it buy us (including but not limited to
new people), and if there is any, would that outweigh the
potential confusion factor to have two different configuration
variables that do exactly the same thing whose sole difference
is which side of the fetched branch namespace it uses to specify
the merge source?

