From: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
Subject: Re: [ANNOUNCE] TopGit v0.3
Date: Fri, 12 Sep 2008 14:27:13 +0200
Organization: lilypond-design.org
Message-ID: <1221222433.29747.8.camel@heerbeest>
References: <20080909231009.GD10544@machine.or.cz>
	 <1221120192.8962.7.camel@heerbeest>  <20080912110017.GW10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Sep 12 14:28:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke7lC-0001lP-TJ
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 14:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449AbYILM1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 08:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753203AbYILM1S
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 08:27:18 -0400
Received: from edu-smtp-02.edutel.nl ([88.159.1.222]:49895 "EHLO
	edu-smtp-02.edutel.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728AbYILM1R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 08:27:17 -0400
Received: from heerbeest (unknown [88.159.206.46])
	by edu-smtp-02.edutel.nl (Postfix) with ESMTP id D23CC11E7EF;
	Fri, 12 Sep 2008 14:27:15 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by heerbeest (Postfix) with ESMTP id EBCC8DC171;
	Fri, 12 Sep 2008 14:27:14 +0200 (CEST)
In-Reply-To: <20080912110017.GW10360@machine.or.cz>
X-Mailer: Evolution 2.23.91 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95715>

On vr, 2008-09-12 at 13:00 +0200, Petr Baudis wrote:

> But this is rewriting history, isn't it?

No (that would be useless), see 

    http://kerneltrap.org/mailarchive/git/2008/8/13/2925144 #first tg redepend idea

I've just implemented the second idea

    http://kerneltrap.org/mailarchive/git/2008/8/15/2954214

but haven't got any time to test it yet.  Then there's also 

    http://kerneltrap.org/mailarchive/git/2008/8/15/2952004

to consider.

> Currently, I'm thinking that something like .topundeps (or !-prefixing
> dependencies in .topdeps) is the only way to implement this...

Yeah, i've been thinking that too.  It would be nice if we could
hack around that.  It seems that the two redepend ideas get around
it at the expense of creating the whole list of dependencies,
which is much too expensive for my taste.

Greetings,
Jan.

-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org
