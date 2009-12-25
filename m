From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Branch shuffling after 1.6.6 release plans
Date: Fri, 25 Dec 2009 12:30:34 +0100
Message-ID: <200912251230.48243.trast@student.ethz.ch>
References: <7vpr65kwnt.fsf@alter.siamese.dyndns.org> <7vljgrgar9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 25 12:30:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NO8Nl-0001W0-4u
	for gcvg-git-2@lo.gmane.org; Fri, 25 Dec 2009 12:30:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413AbZLYLav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Dec 2009 06:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752074AbZLYLav
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Dec 2009 06:30:51 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:23397 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752024AbZLYLav (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Dec 2009 06:30:51 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.213.0; Fri, 25 Dec
 2009 12:30:49 +0100
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Fri, 25 Dec
 2009 12:30:48 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.5-0.1-desktop; KDE/4.3.85; x86_64; ; )
In-Reply-To: <7vljgrgar9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135671>

Thanks for 1.6.6!

Junio C Hamano wrote:
>      * tr/maint-merge-ours-clarification (2009-11-15) 1 commit
>       - rebase: refuse to rebase with -s ours
> 
>      I do not think we reached a concensus for solving conflicts between "give
>      them rope" and "protect users from clearly meaningless combinations".  The
>      author obviously is for the latter (and I am inclined to agree); Dscho
>      seems to think otherwise.

I can try hacking some internal option into the merge helpers, by
which they declare to be (in)compatible with rebasing.  I think this
what Dscho or Sverre mentioned in the corresponding thread, but I
forgot about it when I noticed you had already promoted the above to
'next'.

>      * tr/reset-checkout-patch (2009-11-19) 1 commit
>       - {checkout,reset} -p: make patch direction configurable
> 
>      I do not particularly like a configuration like this that changes the
>      behaviour of a command in a drastic way---it will make helping others
>      much harder.

I think it's not quite as drastic as you make it sound ;-)

But I don't need this feature, and Peff mentioned something about
being happy except for the patch editing mode.  Unfortunately the
above pretty much hits the limits of add--interactive's flexibility,
so an interactive direction toggling feature would need some rewiring.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
