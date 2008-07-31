From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] 64bit issue in test-parse-options.c
Date: Thu, 31 Jul 2008 13:07:08 +0200
Message-ID: <20080731110708.GN32184@machine.or.cz>
References: <20080730141656.41ce02ec@pc09.procura.nl> <20080730123713.GA31392@artemis.madism.org> <20080730144452.797d8686@pc09.procura.nl> <20080730140523.GC31392@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Pierre Habouzit <madcoder@debian.org>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 13:08:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOW0z-0001WR-UO
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 13:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbYGaLHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 07:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751727AbYGaLHM
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 07:07:12 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37688 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751209AbYGaLHL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 07:07:11 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 4AC20393B282; Thu, 31 Jul 2008 13:07:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080730140523.GC31392@artemis.madism.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90925>

On Wed, Jul 30, 2008 at 04:05:23PM +0200, Pierre Habouzit wrote:
> On Wed, Jul 30, 2008 at 12:44:52PM +0000, H.Merijn Brand wrote:
> > On Wed, 30 Jul 2008 14:37:13 +0200, Pierre Habouzit
> > <madcoder@debian.org> wrote:
> > >   long is wrong in the first place, parse-opt only uses ints.
> > 
> > If I change it to int, the date parsing goes bogus.
> 
> That is because OPT_DATE indeed expect a long (why not a time_t I don't
> know btw... but time_t is a long on linux so it doesn't change things a
> lot).

Still, I think converting to time_t for timestamps would be a good
cleanup; I have added it to http://git.or.cz/gitwiki/Janitor.

				Petr "Pasky" Baudis
