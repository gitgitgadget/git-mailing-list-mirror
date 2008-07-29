From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: GIT 1.6.0-rc1
Date: Tue, 29 Jul 2008 23:17:45 +0200
Message-ID: <20080729211745.GA3879@blimp.local>
References: <7vy73myim5.fsf@gitster.siamese.dyndns.org> <20080728063838.GB4234@blimp.local> <7vwsj6tsm3.fsf@gitster.siamese.dyndns.org> <20080728213727.GA3721@blimp.local> <7vr69dky93.fsf@gitster.siamese.dyndns.org> <7v4p69jefb.fsf@gitster.siamese.dyndns.org> <7vljzlhyt8.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 23:18:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNwao-0004pX-0T
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 23:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754386AbYG2VRs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 17:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753064AbYG2VRs
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 17:17:48 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:52549 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765AbYG2VRs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 17:17:48 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20pf4C8=
Received: from tigra.home (Fac01.f.strato-dslnet.de [195.4.172.1])
	by post.webmailer.de (fruni mo41) (RZmta 16.47)
	with ESMTP id i02d4bk6TFlnvE ; Tue, 29 Jul 2008 23:17:45 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 5197D277BD;
	Tue, 29 Jul 2008 23:17:45 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 22F5736D18; Tue, 29 Jul 2008 23:17:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vljzlhyt8.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90685>

Junio C Hamano, Tue, Jul 29, 2008 10:36:19 +0200:
> Junio C Hamano <gitster@pobox.com> writes:
> >
> > Ok, I took a deeper look at the codepaths involved.  Although it does work
> > around the issue, I do not think your patch alone is the "correct" one in
> > the longer term.

Thought so. I just didn't know the code around

> > It needs a bit of explanation, and the explanation won't be exactly
> > "plain, small and short", unfortunately.
> 
> Alex, I ran the full test with this, but only on Linux boxes; obviously
> not on any flavor of Windows.  I think it is correct, and the "first line
> of defence" fix is the same as your patch, so I'd assume it would work for
> you as well.  But extra eyeballs are always appreciated.

Well, it works on Cygwin too. And I had my eyeballs on the code
(wondered first if it will cause more fs accesses than before: it
will, in the racy check. Which is correct, AFAICT)
