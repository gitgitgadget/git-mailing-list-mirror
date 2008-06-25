From: Anton Gladkov <agladkov@parallels.com>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told
	to
Date: Wed, 25 Jun 2008 14:46:06 +0400
Message-ID: <20080625104605.GA10322@atn.sw.ru>
References: <20080624222105.GA24549@dervierte> <1214346098-24584-1-git-send-email-stevenrwalter@gmail.com> <7vwskea2ik.fsf@gitster.siamese.dyndns.org> <48620C1A.6000509@panasas.com> <alpine.DEB.1.00.0806251109380.9925@racer> <1214389498.6634.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Boaz Harrosh <bharrosh@panasas.com>,
	Junio C Hamano <gitster@pobox.com>,
	Steven Walter <stevenrwalter@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"jeske@google.com" <jeske@google.com>
To: Matthias Kestenholz <mk@spinlock.ch>
X-From: git-owner@vger.kernel.org Wed Jun 25 12:47:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBSXO-0003Sj-KG
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 12:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbYFYKqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 06:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753208AbYFYKqq
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 06:46:46 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:36554 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752439AbYFYKqp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 06:46:45 -0400
Received: from localhost.localdomain ([10.30.3.212])
	by relay.sw.ru (8.13.4/8.13.4) with ESMTP id m5PAjrsW003338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 25 Jun 2008 14:45:54 +0400 (MSD)
Received: from atn.sw.ru (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.14.2/8.14.1) with ESMTP id m5PAkE4w010347;
	Wed, 25 Jun 2008 14:46:14 +0400
Received: (from anton@localhost)
	by atn.sw.ru (8.14.2/8.14.2/Submit) id m5PAk6Nk010346;
	Wed, 25 Jun 2008 14:46:06 +0400
X-Authentication-Warning: atn.sw.ru: anton set sender to agladkov@parallels.com using -f
Content-Disposition: inline
In-Reply-To: <1214389498.6634.10.camel@localhost>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86270>

On Wed, Jun 25, 2008 at 02:24:58PM +0400, Matthias Kestenholz wrote:
> On Wed, 2008-06-25 at 11:16 +0100, Johannes Schindelin wrote:
> > Incidentally, a friend just told me that "checkout" is everything but
> > intuitive, and he would have preferred "git branch switch <branch>", but
> > then settled for my proposed "git branch --switch <branch>", which I did
> > not have time to implement yet, unfortunately.
> 
> But why? I don't want to 'branch', I want to 'checkout' another branch,
> which incidentally matches the git command I need to use to achieve
> that.

Because 'checkout' in other SCMs like CVS or SVN means 'get latest data from
repo', i.e. it acts like 'pull' or 'fetch' in git.
And 'branch' means branch manipulation: creating, deleting, switching...

-- 
Best regards,
		Anton
mailto:agladkov@parallels.com
