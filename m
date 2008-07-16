From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH,RFC] Implement 'git rm --if-missing'
Date: Wed, 16 Jul 2008 20:58:11 +0200
Message-ID: <20080716185811.GA3517@xp.machine.xx>
References: <1216231250-21141-1-git-send-email-ciaran.mccreesh@googlemail.com> <7vtzepr7g5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ciaran McCreesh <ciaran.mccreesh@googlemail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 20:59:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJCDa-0002EM-Uq
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 20:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758798AbYGPS6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 14:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758784AbYGPS6R
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 14:58:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:40355 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758744AbYGPS6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 14:58:16 -0400
Received: (qmail invoked by alias); 16 Jul 2008 18:58:12 -0000
Received: from g228028215.adsl.alicedsl.de (EHLO localhost) [92.228.28.215]
  by mail.gmx.net (mp014) with SMTP; 16 Jul 2008 20:58:12 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX19+MvQkc7Z+NkIhVgsYIPr03XFu1x+6YzwOJ2H4QH
	dkACzSXjRblqk6
Content-Disposition: inline
In-Reply-To: <7vtzepr7g5.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88717>

On Wed, Jul 16, 2008 at 11:48:42AM -0700, Junio C Hamano wrote:
> Ciaran McCreesh <ciaran.mccreesh@googlemail.com> writes:
> 
> > git rm --if-missing will only remove files if they've already been removed from
> > disk.
> 
> This probably is a borderline with feaping creaturism.  What's the use of
> it in a real workflow that you need this for?
> 
> "git add -u" may be too broad in that it also adds anything modified, but
> so is --if-missing too broad in that it removes anything removed, and if
> you are going to limit by giving pathspecs _anyway_, then...
> 
> Old timers might just do:
> 
> 	git diff --name-only --diff-filter=D |
>         git update-index --remove --stdin
> 
> ;-)
> 

Ah. This comes in handy. I already searched for a command to delete all
missing files. After reading through the fine manual of 'git rm', I went
to git update-index but didn't come up with a solution to my problem.

But I have to say, an argument to 'git rm' would be preferable than the
above plumping.

-Peter
