From: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
Subject: Re: [PATCH] git-svn.perl: Strip ChangeLog bits.
Date: Mon, 04 Aug 2008 09:49:49 +0200
Organization: lilypond-design.org
Message-ID: <1217836189.7649.7.camel@heerbeest>
References: <1217684549.8296.10.camel@heerbeest>
	 <20080802172742.GT32184@machine.or.cz>
	 <7vfxpnnwt5.fsf@gitster.siamese.dyndns.org>
	 <1217701021.8296.35.camel@heerbeest>  <20080804020931.GA4109@untitled>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Aug 04 09:51:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPuqL-0001MV-W2
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 09:51:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbYHDHty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 03:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbYHDHty
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 03:49:54 -0400
Received: from edu-smtp-02.edutel.nl ([88.159.1.222]:53319 "EHLO
	edu-smtp-02.edutel.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbYHDHtx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 03:49:53 -0400
Received: from heerbeest (unknown [88.159.206.46])
	by edu-smtp-02.edutel.nl (Postfix) with ESMTP id 13F0311E5CD;
	Mon,  4 Aug 2008 09:49:51 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by heerbeest (Postfix) with ESMTP id 5780FDC168;
	Mon,  4 Aug 2008 09:49:51 +0200 (CEST)
In-Reply-To: <20080804020931.GA4109@untitled>
X-Mailer: Evolution 2.23.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91320>

On zo, 2008-08-03 at 19:09 -0700, Eric Wong wrote:

> Jan Nieuwenhuizen <janneke-list@xs4all.nl> wrote:
> > I could imagine that leaving git-svn alone and adding a hook to git-log
> > would be more useful, though.
> 
> NACK on modifying git-svn to support more changelog formats.
> 
> A better idea would be to write a generic script that takes "git log",
> "git svn log" or even plain "svn log" output and filters it
> independently.

> This filter should be reusable for both plain svn and git-svn:

>     The possibilities are endless :)

Yes, but we'll most probably drop SVN rsn, possibly after a short period
of supporting both; and not stripping the cruft in the conversion means
we carry this with us until eternity.  Besides, who is going to
distribute the script, inform users about its availability?

What we have now suffices for our ooo-build conversion.  If you do not
find it useful, more power/less code to you.  Let others search the
archives and/or patch git-svn themselves, if indeed there are any.

Jan.

-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org
