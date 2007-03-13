From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/5] add the ability to select more email header fields to output
Date: Mon, 12 Mar 2007 19:34:16 -0700
Message-ID: <7vodmxoorb.fsf@assigned-by-dhcp.cox.net>
References: <11737291282223-git-send-email-dzickus@redhat.com>
	<11737291281648-git-send-email-dzickus@redhat.com>
	<7vveh6nes9.fsf@assigned-by-dhcp.cox.net>
	<68948ca0703121821h72f6c08ak9f38cae40240ac59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Don Zickus" <dzickus@redhat.com>, git@vger.kernel.org
To: "Don Zickus" <dzickus@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 03:34:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQwqD-0005rk-Dh
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 03:34:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043AbXCMCeS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 22:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753052AbXCMCeS
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 22:34:18 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:49963 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043AbXCMCeR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 22:34:17 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070313023417.JTXX28911.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Mon, 12 Mar 2007 22:34:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id a2aG1W00M1kojtg0000000; Mon, 12 Mar 2007 22:34:17 -0400
In-Reply-To: <68948ca0703121821h72f6c08ak9f38cae40240ac59@mail.gmail.com> (Don
	Zickus's message of "Mon, 12 Mar 2007 21:21:25 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42105>

"Don Zickus" <dzickus@gmail.com> writes:

> On 3/12/07, Junio C Hamano <junkio@cox.net> wrote:
>> Don Zickus <dzickus@redhat.com> writes:
>>
>> > This is useful when scripts need more than just the basic email headers to
>> > parse.  By specifying the "-x=" option, one can search and output any header
>> > field they want.
>>
>> It probably is useful, but that is rather difficult to judge,
>> unless you have a specific use in the scripts (am/applymox).
>
> I have my own custom clone of git-am I am using to extract the
> Message-id, In-Reply-To, and References fields.  For awhile I had the
> fields hardcoded in my version of git-mailinfo.  But instead of
> maintaining it, I was hoping I could push it upstream.  One less thing
> to maintain on my own.  :-)

Fair enough.

> oops.  left over comment from old code.  I'll clean that up.

I've applied 1, 3, 4 and 5 for now, but have't pushed the
results out (I have other patches to tend first).
