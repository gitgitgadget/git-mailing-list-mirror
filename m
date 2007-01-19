From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation: Fix git.7 dependencies.
Date: Fri, 19 Jan 2007 11:53:47 -0800
Message-ID: <7vtzymg5dg.fsf@assigned-by-dhcp.cox.net>
References: <873b67735m.fsf@gmail.com>
	<7vbqkuhlhi.fsf@assigned-by-dhcp.cox.net>
	<8aa486160701191138v7fc29e53xbf809b1495e30b3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 20:53:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7zo8-0004uD-QL
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 20:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbXASTxu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 19 Jan 2007 14:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932862AbXASTxu
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 14:53:50 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:45224 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932854AbXASTxt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jan 2007 14:53:49 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070119195349.HFQW15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Fri, 19 Jan 2007 14:53:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id D7u61W00B1kojtg0000000; Fri, 19 Jan 2007 14:54:06 -0500
To: =?iso-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>
In-Reply-To: <8aa486160701191138v7fc29e53xbf809b1495e30b3d@mail.gmail.com>
	(Santi =?iso-8859-1?Q?B=E9jar's?= message of "Fri, 19 Jan 2007 20:38:52
 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37198>

"Santi B=E9jar" <sbejar@gmail.com> writes:

> On 1/19/07, Junio C Hamano <junkio@cox.net> wrote:
>> > -git.7 git.html: git.txt core-intro.txt
>> > +git.7 git.html: git.txt core-intro.txt $(cmds_txt)
>>
>> I do not think this is needed; doesn't doc.dep catch cmds_txt as
>> well?
>
> It's not needed. I didn't see the doc.dep.

Thanks for sanity-checking.

The reason for the first hunk I gave in my previous message was
wrong, by the way; there is no circular dependency.  The first
hunk is a good change nevertheless, because what will be in
cmds-*.txt command list does not depend on what is in git.txt.
