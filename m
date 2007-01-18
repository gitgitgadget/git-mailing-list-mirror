From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/POLL] git-format-patch: the default suffix is now .patch, not .txt
Date: Thu, 18 Jan 2007 00:43:24 -0800
Message-ID: <7v64b4ohcj.fsf@assigned-by-dhcp.cox.net>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com>
	<87ps9d7j6t.fsf@morpheus.local>
	<7vejptsglj.fsf@assigned-by-dhcp.cox.net>
	<625fc13d0701171218i31585558wf89374eae9485341@mail.gmail.com>
	<7vsle9p8pg.fsf@assigned-by-dhcp.cox.net>
	<7vd55dp5a3.fsf_-_@assigned-by-dhcp.cox.net>
	<81b0412b0701172359y1ef4f936pcdcb2de53d6bd468@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Josh Boyer" <jwboyer@gmail.com>, git@vger.kernel.org,
	davidk@lysator.liu.se
X-From: git-owner@vger.kernel.org Thu Jan 18 09:43:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7Srv-0006SU-Ms
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 09:43:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbXARIn0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 03:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752024AbXARIn0
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 03:43:26 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:61296 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbXARInZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 03:43:25 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070118084325.FYXH20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Thu, 18 Jan 2007 03:43:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id CYiW1W00J1kojtg0000000; Thu, 18 Jan 2007 03:42:31 -0500
To: "Alex Riesen" <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0701172359y1ef4f936pcdcb2de53d6bd468@mail.gmail.com>
	(Alex Riesen's message of "Thu, 18 Jan 2007 08:59:21 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37068>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> I'd like to see ".patch" there, but...
>
> I have to mention, though, that the majority of the editing
> programs is used on that stupid thing called windows ...

Even if majority of git target audience were on Windows, I
thought majority of Windows users are on either VFAT or NTFS and
not DOS 8.3 filesystems these days.

> Also, how many mail clients know that .patch is actually
> a text and not application/binary? It'll make patch
> reviewing harder for some (not sure if I'd like a review
> of such a person, though).

Is it common for popular MUAs to have a single command that lets
you specify a file and depending on its suffix paste it inline
or make it an attachment?  I had an impression that most have
separate commands for "read text from file (as opposed to
typing)" and "attach a file (of random type, not necessarily and
more often than not text)".

The output of format-patch is not meant to be used as an
attachment (it is "read text from file" kind), so I do not think
your worry applies here.  Maybe something I am missing?
