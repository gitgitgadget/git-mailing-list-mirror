From: Petr Baudis <pasky@suse.cz>
Subject: Re: Considering teaching plumbing to users harmful
Date: Wed, 16 Jul 2008 20:59:30 +0200
Message-ID: <20080716185930.GP32184@machine.or.cz>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com> <7v7iblsnfh.fsf@gitster.siamese.dyndns.org> <32541b130807161151x19c20f9t91b7fb9b8c7b8c7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 21:00:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJCEr-0002mA-8d
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 21:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754724AbYGPS7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 14:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754705AbYGPS7c
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 14:59:32 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37561 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754531AbYGPS7c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 14:59:32 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 4F8AB393B300; Wed, 16 Jul 2008 20:59:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <32541b130807161151x19c20f9t91b7fb9b8c7b8c7b@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88718>

On Wed, Jul 16, 2008 at 02:51:30PM -0400, Avery Pennarun wrote:
> On 7/16/08, Junio C Hamano <gitster@pobox.com> wrote:
> >  You can skip merges with "git log --no-merges", just in case you didn't
> >  know.
> 
> Perhaps this is mostly a user education or documentation issue.  I
> know about --no-merges, but it's unclear that this is really a safe
> thing to use, particularly if some of your merges have conflicts.
> Leaving them out leaves out an important part of history.  Do you use
> this option yourself?

Whereas if you rebase, not only you don't show the conflicts resolution,
you didn't even _store_ it in the first place. That isn't much of an
improvement. :-) (This is the main reason why I prefer to avoid rebase
unless absolutely necessary for the workflow.)

				Petr "Pasky" Baudis
