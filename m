From: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
Subject: Re: [ANNOUNCE] TopGit v0.3
Date: Wed, 17 Sep 2008 12:48:40 +0200
Organization: lilypond-design.org
Message-ID: <1221648520.30402.12.camel@heerbeest>
References: <20080909231009.GD10544@machine.or.cz>
	 <1221120192.8962.7.camel@heerbeest> <20080912110017.GW10360@machine.or.cz>
	 <1221222433.29747.8.camel@heerbeest> <20080912131530.GZ10360@machine.or.cz>
	 <20080912181442.GA5407@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Wed Sep 17 12:49:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfubY-0006gm-73
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 12:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416AbYIQKso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 06:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752361AbYIQKso
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 06:48:44 -0400
Received: from edu-smtp-01.edutel.nl ([88.159.1.221]:46172 "EHLO
	edu-smtp-01.edutel.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254AbYIQKsn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 06:48:43 -0400
Received: from heerbeest (unknown [88.159.206.46])
	by edu-smtp-01.edutel.nl (Postfix) with ESMTP id 00D166776B;
	Wed, 17 Sep 2008 12:48:41 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by heerbeest (Postfix) with ESMTP id 7A561DC07B;
	Wed, 17 Sep 2008 12:48:41 +0200 (CEST)
In-Reply-To: <20080912181442.GA5407@lapse.rw.madduck.net>
X-Mailer: Evolution 2.23.91 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96086>

On vr, 2008-09-12 at 19:14 +0100, martin f krafft wrote:

> I've considered this question a lot before and could not come up
> with anything; you cannot undo a merge.

Isn't that overly pessimistic?  Can't we have git create a merge
commit that can be reverted with git revert?

For our ooo-build use case, I'm hoping to use [top]git as "a better 
patch" and hope to have mostly orthogonal topic branches.  With patch,
to "undo a merge" usually means patch -R and remove the patch from
the dependency list.  I can hardly imagine something easily possible
with patch is still impossible with git.

Greetings,
Jan.

-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org
