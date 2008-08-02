From: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
Subject: Re: [PATCH] git-svn.perl: Strip ChangeLog bits.
Date: Sat, 02 Aug 2008 20:17:01 +0200
Organization: lilypond-design.org
Message-ID: <1217701021.8296.35.camel@heerbeest>
References: <1217684549.8296.10.camel@heerbeest>
	 <20080802172742.GT32184@machine.or.cz>
	 <7vfxpnnwt5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 20:18:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPLgL-0007vB-7z
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 20:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756235AbYHBSRH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 14:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755174AbYHBSRH
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 14:17:07 -0400
Received: from edu-smtp-01.edutel.nl ([88.159.1.221]:51080 "EHLO
	edu-smtp-01.edutel.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755369AbYHBSRF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 14:17:05 -0400
Received: from heerbeest (unknown [88.159.206.46])
	by edu-smtp-01.edutel.nl (Postfix) with ESMTP id CC32D67762;
	Sat,  2 Aug 2008 20:17:03 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by heerbeest (Postfix) with ESMTP id F2F4BDC091;
	Sat,  2 Aug 2008 20:17:02 +0200 (CEST)
In-Reply-To: <7vfxpnnwt5.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.23.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91164>

On za, 2008-08-02 at 10:36 -0700, Junio C Hamano wrote:

> >   You forgot to document your option. (And possibly write a testcase.)
> 
> I am not sure if this is generic enough to be in git-svn.perl itself, or
> perhaps there should be a hook make_log_entry() would call in the form of
> some Perl scriptlet given by the user to munge $log_entry{log}, which
> would be very specific to each project.

If you're not sure, please make up your mind.  I agree it's quite a hack
but now it's in the archives for others to find.  Doing this in a single
regexp is a bit tricky and asking a user to write a perl snippet is even
worse, imho.  Especially if would turn out that stripping changelog bits
is the only thing that the hook is getting used for, in the end.  I have
gotten more careful to provide generic solutions to specific problems in
anticipation of possible future desires.

I could imagine that leaving git-svn alone and adding a hook to git-log
would be more useful, though.

Jan.

-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org
