From: Junio C Hamano <junkio@cox.net>
Subject: Re: Change set based shallow clone
Date: Thu, 07 Sep 2006 15:14:18 -0700
Message-ID: <7vlkovtjd1.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910609071252ree73effwb06358e9a22ba965@mail.gmail.com>
	<edpuut$dns$1@sea.gmane.org>
	<9e4733910609071341u7e430214j71ddcbefa26810ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 00:14:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLS8b-0002S9-3e
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 00:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbWIGWOL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 18:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751910AbWIGWOL
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 18:14:11 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:25082 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932166AbWIGWOD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 18:14:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060907221402.ISSC6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Thu, 7 Sep 2006 18:14:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KaDt1V00p1kojtg0000000
	Thu, 07 Sep 2006 18:13:55 -0400
To: "Jon Smirl" <jonsmirl@gmail.com>
In-Reply-To: <9e4733910609071341u7e430214j71ddcbefa26810ca@mail.gmail.com>
	(Jon Smirl's message of "Thu, 7 Sep 2006 16:41:20 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26662>

"Jon Smirl" <jonsmirl@gmail.com> writes:

> Does an average user do these things? The shallow clone is there to
> address the casual user who gags at a five hour download to get an
> initial check out Mozilla when they want to make a five line change or
> just browse the source for a few minutes.
>...
> Maybe the answer is to build a shallow clone tool for casual use, and
> then if you try to run anything too complex on it git just tells you
> that you have to download the entire tree.

For that kind of thing, "git-tar-tree --remote" would suffice I
would imagine.  The five line change can be tracked locally by
creating an initial commit from the tar-tree extract; such a
casual user will not be pushing or asking to pull but sending in
patches to upstream, no?
