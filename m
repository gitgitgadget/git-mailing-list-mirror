From: Anton Gladkov <agladkov@parallels.com>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless
	toldto
Date: Wed, 25 Jun 2008 19:18:35 +0400
Message-ID: <20080625151835.GA14343@atn.sw.ru>
References: <20080624222105.GA24549@dervierte> <1214346098-24584-1-git-send-email-stevenrwalter@gmail.com> <7vwskea2ik.fsf@gitster.siamese.dyndns.org> <48620C1A.6000509@panasas.com> <alpine.DEB.1.00.0806251109380.9925@racer> <1214389498.6634.10.camel@localhost> <20080625104605.GA10322@atn.sw.ru> <63BEA5E623E09F4D92233FB12A9F794302389C2C@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Kestenholz <mk@spinlock.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Boaz Harrosh <bharrosh@panasas.com>,
	Junio C Hamano <gitster@pobox.com>,
	Steven Walter <stevenrwalter@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"jeske@google.com" <jeske@google.com>
To: "Craig L. Ching" <cching@mqsoftware.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 17:19:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBWmM-0006aR-FB
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 17:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462AbYFYPSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 11:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752291AbYFYPSa
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 11:18:30 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:45711 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752113AbYFYPSa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 11:18:30 -0400
Received: from localhost.localdomain ([10.30.3.212])
	by relay.sw.ru (8.13.4/8.13.4) with ESMTP id m5PFINMC018184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 25 Jun 2008 19:18:24 +0400 (MSD)
Received: from atn.sw.ru (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.14.2/8.14.1) with ESMTP id m5PFIgTn014368;
	Wed, 25 Jun 2008 19:18:42 +0400
Received: (from anton@localhost)
	by atn.sw.ru (8.14.2/8.14.2/Submit) id m5PFIZbF014367;
	Wed, 25 Jun 2008 19:18:35 +0400
X-Authentication-Warning: atn.sw.ru: anton set sender to agladkov@parallels.com using -f
Content-Disposition: inline
In-Reply-To: <63BEA5E623E09F4D92233FB12A9F794302389C2C@emailmn.mqsoftware.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86288>

On Wed, Jun 25, 2008 at 06:49:16PM +0400, Craig L. Ching wrote:
> > Because 'checkout' in other SCMs like CVS or SVN means 'get
> > latest data from repo', i.e. it acts like 'pull' or 'fetch' in git.
> > And 'branch' means branch manipulation: creating, deleting,
> > switching...
> >
> Checkout, for me and a lot of people I work with, never meant "get
> latest data from repo", it always meant "get me a workspace".  Anyway,
> just sharing a dissenting opinion, I don't agree that the checkout verb
> is used incorrectly in git.

Craig,
I'm not trying to say that git incorrectly uses 'checkout' word :)

-- 
Best regards,
		Anton
mailto:agladkov@parallels.com
