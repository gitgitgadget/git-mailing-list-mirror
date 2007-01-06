From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git-remote
Date: Fri, 05 Jan 2007 17:59:52 -0800
Message-ID: <7vvejkap9j.fsf@assigned-by-dhcp.cox.net>
References: <7vfyarokk7.fsf@assigned-by-dhcp.cox.net>
	<8aa486160701050459p4da586cdk2c2ddaabda5b4ca7@mail.gmail.com>
	<Pine.LNX.4.63.0701051448560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<8aa486160701051153h52a93c16k2b190f58e652cb2e@mail.gmail.com>
	<87ac0xgp12.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 06 03:00:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H30qi-0002lP-Oz
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 02:59:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbXAFB7y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 20:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbXAFB7y
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 20:59:54 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:35752 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbXAFB7x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 20:59:53 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070106015953.THEC7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Fri, 5 Jan 2007 20:59:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 7dz41W00H1kojtg0000000; Fri, 05 Jan 2007 20:59:04 -0500
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87ac0xgp12.wl%cworth@cworth.org> (Carl Worth's message of "Fri,
	05 Jan 2007 13:08:25 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36070>

Carl Worth <cworth@cworth.org> writes:

> On Fri, 5 Jan 2007 20:53:22 +0100, "=?ISO-8859-1?Q?Santi_B=E9jar?=" wrote:
>> I was talking about the default name, so you could do:
>>
>> $ git clone\
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>> $ cd linux-2.6
>> $ git remote add \
>> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-2.6.git
>> $ git remote show libata-2.6
>
> Yes.

No.  Because...

> I'd go one further and say that it'd be really nice if git-clone could
> be seen as equivalent, (and basically equivalent internally), to a
> simple sequence of steps that could be performed manually. Something
> like:
>
> 	name=$(basename $url)
> 	mkdir $name
> 	cd $name
> 	git init-db
> 	git remote add $url
> 	git pull $name

you could say "git remote add $name $url" here, having computed
$name already.

But you guessed what I was driving at right ;-).
