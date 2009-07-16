From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH 1/2] List send-email config options in config.txt.
Date: Thu, 16 Jul 2009 23:20:44 +0200
Message-ID: <20090716212044.GC5762@nan92-1-81-57-214-146.fbx.proxad.net>
References: <cover.1246834883.git.ydirson@altern.org> <112440b74f47290e55209b23d1bfc66ed2423297.1246834884.git.ydirson@altern.org> <7v3a9ae1s6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 23:20:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRYNZ-0007JY-Sd
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 23:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933387AbZGPVUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 17:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933381AbZGPVUa
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 17:20:30 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:33484 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933374AbZGPVUa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 17:20:30 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id C3156940182;
	Thu, 16 Jul 2009 23:20:22 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g21.free.fr (Postfix) with ESMTP id D9BB5940165;
	Thu, 16 Jul 2009 23:20:19 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id ECA421F162; Thu, 16 Jul 2009 23:20:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v3a9ae1s6.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123425>

On Sun, Jul 05, 2009 at 11:58:01PM -0700, Junio C Hamano wrote:
> > +sendemail.aliasesfile::
> > +	To avoid typing long email addresses, point this to one or more
> > +	email aliases files.  You must also supply 'sendemail.aliasfiletype'.
> > +
> > +sendemail.aliasfiletype::
> > +	Format of the file(s) specified in sendemail.aliasesfile. Must be
> > +	one of 'mutt', 'mailrc', 'pine', 'elm', or 'gnus'.
> > +
> > +sendemail.bcc::
> > +sendemail.cc::
> > +sendemail.cccmd::
> > +sendemail.chainreplyto::
> > +
> 
> At least, we would want to have some description for these.  Something
> along the lines of "Specifies values used for the corresponding command
> line options when they are not given." should suffice.

Sure - that's part of why this series reads WIP :)

I'm also not entirely satisfied with duplicating the existing
descriptions from the send-email manpage, like I have done for those
with a desctiption.  We could just mention all the flags with a "See
linkgit:git-send-email[1] for details.", although it looks a bit
inconsistent with the common usage, before going into a massive
migration of these parameters into config.txt.

Would that be seen as reasonable ?
