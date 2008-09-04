From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] Teach "log -F --author=<match>" to behave better
Date: Thu, 4 Sep 2008 22:25:29 +0300
Message-ID: <20080904192529.GA3443@mithlond.arda.local>
References: <g9o0ac$qig$1@ger.gmane.org> <7v4p4w75b7.fsf@gitster.siamese.dyndns.org> <7vprnk5n3c.fsf_-_@gitster.siamese.dyndns.org> <20080904133344.GA3197@mithlond.arda.local> <7vk5dr3f4x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 21:32:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbKZ8-0004oO-Sf
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 21:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753823AbYIDTbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 15:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753709AbYIDTbU
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 15:31:20 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:59276 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753665AbYIDTbU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 15:31:20 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi1.inet.fi (8.5.014)
        id 48B55E9A006E8BAF; Thu, 4 Sep 2008 22:25:31 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1KbKSQ-0001pO-0L; Thu, 04 Sep 2008 22:25:30 +0300
Content-Disposition: inline
In-Reply-To: <7vk5dr3f4x.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94952>

Junio C Hamano wrote (2008-09-04 12:06 -0700):

> Teemu Likonen <tlikonen@iki.fi> writes:
> 
> > One of the problems was that with
> >
> >     git log -E --author=pattern
> >
> > the pattern is interpreted as basic regexp but with 
> >
> >     git log --author=pattern -E
> >
> > as extended rexexp.
> 
> I think Jeff fixed that one already on 'maint'.

You think right, it's indeed fixed. Great!
