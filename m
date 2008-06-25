From: Ian Hilt <Ian.Hilt@gmx.com>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told
 to
Date: Wed, 25 Jun 2008 09:19:36 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806250907340.5393@sys-0.hiltweb.site>
References: <20080624222105.GA24549@dervierte> <1214346098-24584-1-git-send-email-stevenrwalter@gmail.com> <7vwskea2ik.fsf@gitster.siamese.dyndns.org> <48620C1A.6000509@panasas.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org,
	jeske@google.com
To: Boaz Harrosh <bharrosh@panasas.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 15:21:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBUvX-00044P-D2
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 15:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755411AbYFYNTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 09:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755264AbYFYNTg
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 09:19:36 -0400
Received: from mail.gmx.com ([74.208.5.67]:35999 "HELO mail.gmx.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755331AbYFYNTf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 09:19:35 -0400
Received: (qmail invoked by alias); 25 Jun 2008 13:19:34 -0000
Received: from cpe-75-185-208-72.woh.res.rr.com (EHLO [192.168.1.1]) [75.185.208.72]
  by mail.gmx.com (mp-us001) with SMTP; 25 Jun 2008 09:19:34 -0400
X-Authenticated: #47758715
X-Provags-ID: V01U2FsdGVkX18iDYcQfXsiIezlw7oWrU8GgMlOdGc5FOHLMtwycM
	EC3KCNoOBYHF1L
In-Reply-To: <48620C1A.6000509@panasas.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86276>

On Wed, 25 Jun 2008 at 12:12pm +0300, Boaz Harrosh wrote:

> Junio C Hamano wrote:
> > Learn the lingo, and get over it.
> > 
> 
> I did lern the lingo and got bitten. I wanted to do one thing
> also got the other one.

Something that I think has not been emphasized enough for whatever
reason is how _easy_ it is to test out git commands.  For example, if
you have a really_important_repo that you don't want to screw up, but
you need to do a potentially destructive thing to it, just do,

$ cp -r /path/to/really_important_repo ~/test
$ cd ~/test && git destructive

and you find out whether your mental concept of what "git destructive"
does is correct or not without possibly losing your work.


-- 
Ian Hilt
Ian.Hilt (at) gmx.com
GnuPG key: 0x4AFC1EE3
