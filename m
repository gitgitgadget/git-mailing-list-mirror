X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Tue, 07 Nov 2006 23:59:17 -0800
Message-ID: <7vbqniv06i.fsf@assigned-by-dhcp.cox.net>
References: <7v8ximwrm3.fsf@assigned-by-dhcp.cox.net>
	<eis1j6$vug$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 8 Nov 2006 07:59:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <eis1j6$vug$2@sea.gmane.org> (Jakub Narebski's message of "Wed,
	08 Nov 2006 08:40:07 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31128>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhiLC-0005d2-GV for gcvg-git@gmane.org; Wed, 08 Nov
 2006 08:59:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754412AbWKHH7T convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006 02:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754421AbWKHH7T
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 02:59:19 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:22661 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S1754412AbWKHH7S
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006
 02:59:18 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061108075918.LWBT18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Wed, 8
 Nov 2006 02:59:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id k7yu1V0081kojtg0000000; Wed, 08 Nov 2006
 02:58:55 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> =A0 =A0Jakub Narebski (4):
> [...]
>> =A0 =A0 =A0 gitweb: Output also empty patches in "commitdiff" view
>
> I think that this patch is a bit premature. Without "new improved pat=
chset
> view" the empty patches are just that: totally empty. It is new heade=
r and
> especially outputting extended header information which makes outputt=
ing
> "empty" patches (with no diff) in "commitdiff" view usefull. By "empt=
y"
> patches I mean pure type change, pure rename, pure copy and type chan=
ge and
> rename.
>
> The "new improved patchset view" is prepared to send in two stages...

At least this does not break the page even without these two
follow-ups.  If the follow-ups come in time and do not break the
page, they are very welcome post -rc1 fixes to have before the
final release.  On the other hand, even if they don't, it's not
the end of the world ;-).

