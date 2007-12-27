From: Gerrit Pape <pape@smarden.org>
Subject: Re: [PATCH] git-pull: don't complain about branch merge config if
	only fetching tags
Date: Thu, 27 Dec 2007 09:30:16 +0000
Message-ID: <20071227093016.18337.qmail@e6d9fb481b7087.315fe32.mid.smarden.org>
References: <20071221124400.20725.qmail@db93e79e204cd8.315fe32.mid.smarden.org> <7v8x3oatvi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 27 10:30:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J7p4K-0003be-71
	for gcvg-git-2@gmane.org; Thu, 27 Dec 2007 10:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbXL0JaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2007 04:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbXL0JaA
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Dec 2007 04:30:00 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:49254 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751155AbXL0J37 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2007 04:29:59 -0500
Received: (qmail 18338 invoked by uid 1000); 27 Dec 2007 09:30:16 -0000
Content-Disposition: inline
In-Reply-To: <7v8x3oatvi.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69260>

On Fri, Dec 21, 2007 at 08:35:13AM -0800, Junio C Hamano wrote:
> Gerrit Pape <pape@smarden.org> writes:
> > When running git pull with the -t switch, it properly fetches tags, but
> > complains about missing information on how to merge.  Since there's
> > nothing to merge, make git-pull simply exit after fetching the tags.

> I've seen this patch on this list in the past, but isn't "git
> pull -t" a user-error?

If so, we shouldn't advertise the -t switch in the git-pull(1) manpage.
As it stands, I'd understand 'git pull -t' as 'fetch _all_ tags and
branch heads and merge according to the configuration'.

Regards, Gerrit.
