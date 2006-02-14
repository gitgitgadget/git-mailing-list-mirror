From: Junio C Hamano <junkio@cox.net>
Subject: Re: several quick questions
Date: Tue, 14 Feb 2006 12:41:57 -0800
Message-ID: <7vmzgtr7u2.fsf@assigned-by-dhcp.cox.net>
References: <43F20532.5000609@iaglans.de>
	<Pine.LNX.4.64.0602140845080.3691@g5.osdl.org>
	<87k6bxvmj6.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0602141026570.3691@g5.osdl.org>
	<87fymlvgzv.wl%cworth@cworth.org> <20060214202728.GE31278@pasky.or.cz>
	<Pine.LNX.4.63.0602142136250.23659@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 21:42:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F96zt-0001of-Lw
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 21:42:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161063AbWBNUmA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 15:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161073AbWBNUmA
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 15:42:00 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:4063 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1161063AbWBNUl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 15:41:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060214203917.FFNT26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 14 Feb 2006 15:39:17 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0602142136250.23659@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 14 Feb 2006 21:37:39 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16170>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Tue, 14 Feb 2006, Petr Baudis wrote:
>
>> [...]
>>
>> It works by creating a new branch cg-seek-point and storing the seeked
>> point there; if HEAD is already on the branch, it merely changes the
>> seek point and resets the working tree appropriately. cg-seek without
>> any arguments will then return to your original head, whose name was
>> stored in .git/head-name.
>
> And if you want to prevent accidental commit, just "chmod a-w 
> $GIT_DIR/index".

That is a wrong answer.  It is perfectly sane to modify index
without an intention to commit that change (you can always say
"git reset").
