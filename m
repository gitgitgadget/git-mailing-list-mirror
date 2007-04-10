From: Junio C Hamano <junkio@cox.net>
Subject: Re: Feature request - Subtree checkouts
Date: Tue, 10 Apr 2007 13:28:17 -0700
Message-ID: <7vslb8ug7y.fsf@assigned-by-dhcp.cox.net>
References: <20070410074444.GA18541@curie-int.orbis-terrarum.net>
	<20070410132011.GH5436@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 04:51:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbMx9-0001rW-3v
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 22:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030582AbXDJU2W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 16:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030576AbXDJU2V
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 16:28:21 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:59597 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030582AbXDJU2S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 16:28:18 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070410202818.KFZL1266.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Apr 2007 16:28:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id lYUH1W00x1kojtg0000000; Tue, 10 Apr 2007 16:28:18 -0400
In-Reply-To: <20070410132011.GH5436@spearce.org> (Shawn O. Pearce's message of
	"Tue, 10 Apr 2007 09:20:11 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44167>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> "Robin H. Johnson" <robbat2@gentoo.org> wrote:
>> P.S. Does this list do some weird spam-blocking? I've tried 3 times now
>> to use git-send-email to send an unrelated minor patch set
>> (--subject-prefix for git-format-patch), and it has never shown up on
>> the list :-(.
>
> Yes.  It has cut down on our spam, but it has also caused some
> things to be blocked, almost without good reason.  ;-)
>
> I send a fair number of patches to this list (at times anyway) and
> am also unable to use git-send-email.  If I have the email also CC
> back to me it does make it through a number of SMTP server hops,
> including my own spam filters, but it never makes it through the
> Git mailing list.  So I dump the patches to an mbox with --stdout,
> open them up in mutt and resend them there.  I've bound shift-G
> to resend-message for that purpose...

Well, we need to do something about this.  I haven't seen
Robin's patch neither on the list nor in my mailbox (if they
were CC'ed to me).

One thing that people need to be careful about is which SMTP
server they use.  I had an impression (I do not use send-email
myself) that it defaulted to local MTA, so the mail trail would
look like your local MTA receives from the MUA (which is
send-email), which forwards it to whereever destination (or
intermediaries).  On the other hand, I suspect many people use
their ISP's SMTP server when using their usual MUA, so the mail
trail would look different.  I do not know what filtering vger
does, but if it is filtering based on the MTA address
(dul.dnsbl.sorbs filtering comes to mind), that would make a
difference.
