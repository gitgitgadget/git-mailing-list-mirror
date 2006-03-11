From: Junio C Hamano <junkio@cox.net>
Subject: Re: bug?: stgit creates (unneccessary?) conflicts when pulling
Date: Fri, 10 Mar 2006 22:46:15 -0800
Message-ID: <7vfylpxyvc.fsf@assigned-by-dhcp.cox.net>
References: <20060227204252.GA31836@diana.vm.bytemark.co.uk>
	<20060227222600.GA11797@spearce.org> <tnx1wxmig75.fsf@arm.com>
	<20060301145105.GB3313@spearce.org>
	<b0943d9e0603010708l72cb14d1w@mail.gmail.com>
	<20060301155043.GA3706@spearce.org>
	<b0943d9e0603091400o2cd0291h@mail.gmail.com>
	<7vslpr2ojz.fsf@assigned-by-dhcp.cox.net>
	<b0943d9e0603100313l37f67f62h@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	"Shawn Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 11 07:46:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHxrp-0000WC-MN
	for gcvg-git@gmane.org; Sat, 11 Mar 2006 07:46:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWCKGqR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Mar 2006 01:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWCKGqR
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Mar 2006 01:46:17 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:9935 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751261AbWCKGqR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Mar 2006 01:46:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060311064430.MQBT6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 11 Mar 2006 01:44:30 -0500
To: "Catalin Marinas" <catalin.marinas@gmail.com>
In-Reply-To: <b0943d9e0603100313l37f67f62h@mail.gmail.com> (Catalin Marinas's
	message of "Fri, 10 Mar 2006 11:13:41 +0000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17494>

"Catalin Marinas" <catalin.marinas@gmail.com> writes:

> On 09/03/06, Junio C Hamano <junkio@cox.net> wrote:
>
>> Yup, it was originally done to improve the performance of
>> resolve merge strategy, but I am glad somebody else has found
>> use for it.
>
> Actually, I asked for it about 6 months ago:
>
> http://marc.theaimsgroup.com/?l=git&m=112677889118711&w=2
>
> and I got the reply from you :-):
>
> http://marc.theaimsgroup.com/?l=git&m=112690084826630&w=2
>
> Anyway, it's good we have it...

I had this one in mind:

        http://marc.theaimsgroup.com/?t=113874460800001&r=1&w=2

Specifically, this message:

	http://marc.theaimsgroup.com/?l=git&m=113874886615202&w=2

It seems that this has been an recurring issue.
