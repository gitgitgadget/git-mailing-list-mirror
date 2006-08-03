From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Wed, 02 Aug 2006 21:56:33 -0700
Message-ID: <7vd5bis9ha.fsf@assigned-by-dhcp.cox.net>
References: <7v1ws0xb9y.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0608020702q2fd4ec83ga43714c15538f7ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 03 06:56:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8VGA-00038Y-4y
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 06:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWHCE4f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 00:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWHCE4f
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 00:56:35 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:56508 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932195AbWHCE4e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Aug 2006 00:56:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060803045634.TGXK6077.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 3 Aug 2006 00:56:34 -0400
To: "Alex Riesen" <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0608020702q2fd4ec83ga43714c15538f7ad@mail.gmail.com>
	(Alex Riesen's message of "Wed, 2 Aug 2006 16:02:26 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24702>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> On 8/2/06, Junio C Hamano <junkio@cox.net> wrote:
>>   - Git.pm by Pasky with help from Pavel Roskin and others.
>>
>>     I'd like to merge this immediately after 1.4.2, unless there
>>     still are concerns about its portability (in which case
>>     please help fixing them up before this hits the "master"
>>     branch).
>
> Completely broken on ActiveState Perl and cygwin. Generated Makefile
> contains pathnames with backslashes and the whole file has
> CRLF line endings.

Anything constructive other than "doctor it hurts when I use
activestate", so you can help improve things to be more
ActiveState friendly?

What's the standard workflow/procedure ActiveState users would
use to build and install .xs extensions?  Maybe they have their
own $(MAKE) equivalent that groks such a Makefile with
backslashed pathnames and CRLF endings?
