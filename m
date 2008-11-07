From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: multiple-commit cherry-pick?
Date: Fri, 7 Nov 2008 08:12:31 +0100
Message-ID: <20081107071231.GA4063@blimp.localdomain>
References: <buoiqr18tdk.fsf@dhapc248.dev.necel.com> <20081106213711.GA4334@blimp.localdomain> <alpine.LFD.2.00.0811061925300.3451@nehalem.linux-foundation.org> <7vskq4gmf5.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 08:13:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyLXT-0007bG-Jg
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 08:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbYKGHMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 02:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbYKGHMf
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 02:12:35 -0500
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:45634 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbYKGHMe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 02:12:34 -0500
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8AE81ptmF
Received: from tigra.home (Fab89.f.strato-dslnet.de [195.4.171.137])
	by post.webmailer.de (klopstock mo23) (RZmta 17.17)
	with ESMTP id I05160kA75EGlH ; Fri, 7 Nov 2008 08:12:31 +0100 (MET)
Received: from blimp.localdomain (unknown [192.168.1.28])
	by tigra.home (Postfix) with ESMTP id 8B8F4277C8;
	Fri,  7 Nov 2008 08:12:31 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 3126836D27; Fri,  7 Nov 2008 08:12:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vskq4gmf5.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100289>

Junio C Hamano, Fri, Nov 07, 2008 06:00:46 +0100:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > On Thu, 6 Nov 2008, Alex Riesen wrote:
> >> 
> >> git format-patch --full-index --binary --stdout <range...> | git am -3
> >> 
> >> This will not work if you want to pick a list, not a range, of
> >> commits.
> >
> > Doesn't "--no-walk" + list commits individually work?
> >
> > So it _should_ be possible to pick a list of commits too. Although I think 
> > that git format-patch will reverse the order.
> 
> Or "git show --pretty=email $commit1 $commit2" ... piped to "am"?
> 

Does not work if there are ranges given :-/
It'd be very nice to have: git show #c1..$c2 $c3 $c4 $c5..$c6
