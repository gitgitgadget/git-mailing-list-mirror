From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] New files in git weren't being downloaded during CVS update
Date: Sun, 21 Jan 2007 23:16:09 -0800
Message-ID: <7v8xfvv8ee.fsf@assigned-by-dhcp.cox.net>
References: <200701211425.12971.andyparkins@gmail.com>
	<7vmz4bwzy4.fsf@assigned-by-dhcp.cox.net>
	<46a038f90701212302v458019fcxcde72a34aa46e7bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	"Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 22 08:16:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8tPa-0001fD-KZ
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 08:16:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbXAVHQM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 02:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751888AbXAVHQM
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 02:16:12 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:62618 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557AbXAVHQK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 02:16:10 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070122071610.DRJT18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Mon, 22 Jan 2007 02:16:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id E7GT1W00P1kojtg0000000; Mon, 22 Jan 2007 02:16:28 -0500
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90701212302v458019fcxcde72a34aa46e7bd@mail.gmail.com>
	(Martin Langhoff's message of "Mon, 22 Jan 2007 20:02:29 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37402>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

>> I do not have anything other than the real CVS running on a
>> Linux box to try this change (most notably I do not do Eclipse
>> nor Tortoise) myself and I am reluctant to touch things I cannot
>> personally test at this stage near the release.
>
> Fair enough. I'll give it whirl later tonight. For a quick test, you can always
>
> export CVS_SERVER=/home/martin/src/git/git-cvsserver.perl
> cvs update

Yes, that's what I did (what I meant was I can test with cvs as
client but not other clients that talk CVS remote protocols).

>> tested this for his own use in his environment, but I would
>> really appreciate a third party Ack from an environment
>> different from the originator of the patch.
>
> Yup. Will test later tonight.

Thanks.
