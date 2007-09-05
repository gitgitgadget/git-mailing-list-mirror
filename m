From: Johan De Messemaeker <johan.demessemaeker@wgaf.org>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 5 Sep 2007 16:17:01 +0200
Message-ID: <D32A7C27-EAF5-4156-BE0E-99FE3D948AE8@wgaf.org>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org> <20070905074206.GA31750@artemis.corp> <46DE6DBC.30704@midwinter.com> <7vbqchjx9f.fsf@gitster.siamese.dyndns.org> <46a038f90709050227u777ed7b9w23dc3bab13c7b09b@mail.gmail.com> <vpqzm01v4li.fsf@bauges.imag.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Steven Grimm" <koreth@midwinter.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Sep 05 16:18:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISvhZ-00028s-Mu
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 16:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756433AbXIEORt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 10:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756404AbXIEORs
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 10:17:48 -0400
Received: from hoefnix.telenet-ops.be ([195.130.132.54]:59688 "EHLO
	hoefnix.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756363AbXIEORs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 10:17:48 -0400
Received: from adicia.telenet-ops.be (adicia.telenet-ops.be [195.130.132.56])
	by hoefnix.telenet-ops.be (Postfix) with ESMTP id 340859D234
	for <git@vger.kernel.org>; Wed,  5 Sep 2007 16:17:47 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by adicia.telenet-ops.be (Postfix) with SMTP id D0CC123010D;
	Wed,  5 Sep 2007 16:17:03 +0200 (CEST)
Received: from [192.168.0.147] (d5153BCDA.access.telenet.be [81.83.188.218])
	by adicia.telenet-ops.be (Postfix) with ESMTP id F2827230104;
	Wed,  5 Sep 2007 16:16:58 +0200 (CEST)
In-Reply-To: <vpqzm01v4li.fsf@bauges.imag.fr>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57712>


On 05 Sep 2007, at 11:33, Matthieu Moy wrote:
>
> There's indeed a real idea behind that. The issue is that the alias
> shouldn't be just "gc", but "find-all-repositories-and-do-gc-there".
>
> Currently, AFAIK, that can only be done with a (trivial) script
> external to git. I suppose this can easily be added to the core git
> porcelain. Perhaps a "git gc --recursive" would do.
>
> It doesn't solve the problem, but makes it easier to solve it (git gc
> --recursive in cron for example).

I'm a git newb so I can be wrong here but ...

Why --recursive? Why not use the submodule-information ?

Johan
