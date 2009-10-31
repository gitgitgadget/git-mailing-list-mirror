From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Add '--bisect' revision machinery argument
Date: Sat, 31 Oct 2009 21:58:08 +0100
Message-ID: <200910312158.09049.chriscool@tuxfamily.org>
References: <alpine.LFD.2.01.0910271124110.31845@localhost.localdomain> <7viqdzgls9.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0910281631400.31845@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Oct 31 21:57:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4Kzm-00039B-QL
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 21:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933254AbZJaU4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2009 16:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933252AbZJaU4K
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Oct 2009 16:56:10 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:46260 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933249AbZJaU4F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2009 16:56:05 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id ADCA4818111;
	Sat, 31 Oct 2009 21:56:03 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 64BE38180EE;
	Sat, 31 Oct 2009 21:56:00 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.LFD.2.01.0910281631400.31845@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131857>

On Thursday 29 October 2009, Linus Torvalds wrote:
> On Wed, 28 Oct 2009, Junio C Hamano wrote:
> > This shows a very nice direction to evolve, but your patch as-is breaks
> > "rev-list --bisect", I think.
>
> I think you're right. I tested git rev-parse, and the 'git log'
> machinery, but I didn't think about the fact that we already had a
> meaning
> for '--bisect' in rev-list.
>
> > Also, the helper of "git bisect" can and probably should be taught to
> > just ask this new behaviour from the revision machinery, instead of
> > collecting good and bad refs itself using bisect.c::read_bisect_refs().
>
> Yeah. And git-bisect.sh can be simplified too.

I will have a look at that.

Sorry for not responding earlier but I just came back today from the Linux 
Kongress 2009 in Dresden (http://www.linux-kongress.org/2009/).

Best regards,
Christian.
