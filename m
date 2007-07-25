From: Junio C Hamano <gitster@pobox.com>
Subject: Re: submodule init problem
Date: Tue, 24 Jul 2007 18:49:26 -0700
Message-ID: <7vir89fe1l.fsf@assigned-by-dhcp.cox.net>
References: <d4b731510707241709pcad0a4bj85b71892cd2de84c@mail.gmail.com>
	<d4b731510707241730u45755c0dwfde5e0b14b14f1da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Ricky Nite" <ricky.nite@gmail.com>
To: Lars Hjemli <hjemli@gmail.com>, Sven Verdoolaege <skimo@kotnet.org>
X-From: git-owner@vger.kernel.org Wed Jul 25 03:49:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDW0J-0006YU-6z
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 03:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbXGYBt2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 21:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758897AbXGYBt2
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 21:49:28 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:38524 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757377AbXGYBt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 21:49:27 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070725014928.DOUF1349.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Tue, 24 Jul 2007 21:49:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TdpR1X00k1kojtg0000000; Tue, 24 Jul 2007 21:49:26 -0400
In-Reply-To: <d4b731510707241730u45755c0dwfde5e0b14b14f1da@mail.gmail.com>
	(Ricky Nite's message of "Wed, 25 Jul 2007 08:30:22 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53664>

"Ricky Nite" <ricky.nite@gmail.com> writes:

> This problem doesn't seem to occur if I rename my submodules (but I
> really don't want to):
>
> rnite@linuskarl:~/git_dev$ mkdir moduleA
> rnite@linuskarl:~/git_dev$ mkdir moduleB
> ...
> rnite@linuskarl:~/git_dev/myproj2$ ~/bin/git submodule init
> Submodule 'moduleA' (/home/rnite/git_dev/moduleA/.git) registered for
> path 'moduleA'
> Submodule 'moduleB' (/home/rnite/git_dev/moduleB/.git) registered for
> path 'moduleB'
>
> help,
> RickyN
>
> On 7/25/07, Ricky Nite <ricky.nite@gmail.com> wrote:
>> Hello,
>>
>> I encountered this message in "git submodule init":
>> "No url found for submodule path '<submodule>' in .gitmodules"
>>
>> But when I look at .gitmodules, the <submodule> url is there.
>> Subsequently, I cannot do "git submodule update"
>>
>> Here's the full log:
>> rnite@linuskarl:~/git_dev/myproj$ ~/bin/git --version
>> git version 1.5.3.rc2.g11308
>> rnite@linuskarl:~/git_dev$ mkdir flash
>> rnite@linuskarl:~/git_dev$ mkdir flashboard

Ok, this appears it most likely to be related to the fact that
one is a prefix of the other in problematic case.

Lars, Sven?
