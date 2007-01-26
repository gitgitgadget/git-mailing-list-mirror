From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fmt-merge-msg: detached HEAD
Date: Fri, 26 Jan 2007 01:59:48 -0800
Message-ID: <7vveiuyup7.fsf@assigned-by-dhcp.cox.net>
References: <87zm875d9u.fsf@gmail.com>
	<7vireu63rg.fsf@assigned-by-dhcp.cox.net>
	<8aa486160701260145i4c50d564n90967a07f7ee62a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 26 10:59:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HANsE-0006j3-9h
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 10:59:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161009AbXAZJ7u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 26 Jan 2007 04:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161021AbXAZJ7u
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 04:59:50 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:65044 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161009AbXAZJ7u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jan 2007 04:59:50 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070126095949.LCTH9717.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Fri, 26 Jan 2007 04:59:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Flyr1W00L1kojtg0000000; Fri, 26 Jan 2007 04:58:52 -0500
In-Reply-To: <8aa486160701260145i4c50d564n90967a07f7ee62a9@mail.gmail.com>
	(Santi =?iso-8859-1?Q?B=E9jar's?= message of "Fri, 26 Jan 2007 10:45:38
 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37830>

"Santi B=E9jar" <sbejar@gmail.com> writes:

>> > diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
>> > index 87d3d63..8cef425 100644
>> > --- a/builtin-fmt-merge-msg.c
>> > +++ b/builtin-fmt-merge-msg.c
>> > @@ -331,7 +331,8 @@ int cmd_fmt_merge_msg(int argc, const char **a=
rgv, const char *prefix)
>> >                       printf(" of %s", srcs.list[i]);
>> >       }
>> >
>> > -     if (!strcmp("master", current_branch))
>> > +     if (!strcmp("master", current_branch) ||
>> > +         !strcmp("HEAD", current_branch))
>> >               putchar('\n');
>> >       else
>> >               printf(" into %s\n", current_branch);
>>
>> Hmph.
>>
>> The reason is?
>
> For me, 'Merge ... into master' and 'Merge ... into HEAD' are equally
> useful, so do not show them by default. And git always merges into
> HEAD.

I was wondering if people might prefer rewording it to "into
detached HEAD".
