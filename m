From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Add a suffix option to git-format-patch
Date: Wed, 17 Jan 2007 09:33:44 -0800
Message-ID: <7vejptsglj.fsf@assigned-by-dhcp.cox.net>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com>
	<87ps9d7j6t.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 17 18:33:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7EfX-0003ul-S9
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 18:33:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbXAQRdr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 17 Jan 2007 12:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbXAQRdr
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 12:33:47 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:45459 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932591AbXAQRdq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jan 2007 12:33:46 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070117173345.FLRD3976.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Wed, 17 Jan 2007 12:33:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id CHa21W00c1kojtg0000000; Wed, 17 Jan 2007 12:34:03 -0500
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37018>

David K=E5gedal <davidk@lysator.liu.se> writes:

> "Josh Boyer" <jwboyer@gmail.com> writes:
>
>> I use git quite a bit to track my changes and then use
>> git-format-patch to generate patches to send on to others.  For the
>> most part, it works great but I find myself constantly doing:
>>
>> mv xxxx-foo.txt xxxx-foo.patch
>
> Seconded. I would even prefer .patch to be default, but I guess a
> config parameter would help me there.

Two minor objections to changing the default are: (1) it's a
change and any change is bad ;-) and (2) the reason I changed it
to .txt before submitting the original format-patch to Linus was
because Emacs wanted to go into its "diff" mode when files are
named with .patch suffix, which had two annoyances (read-only by
default, and editing patch tried to automatically recount diff
and its recounting screwed up in some cases I do not remember
the details about).

I do not have a problem with a config or an option, though.
