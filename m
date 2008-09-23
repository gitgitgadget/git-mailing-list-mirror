From: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
Subject: Re: [ANNOUNCE] TopGit v0.3
Date: Tue, 23 Sep 2008 15:13:10 +0200
Organization: lilypond-design.org
Message-ID: <1222175590.10363.14.camel@heerbeest>
References: <20080909231009.GD10544@machine.or.cz>
	 <1221120192.8962.7.camel@heerbeest> <20080912110017.GW10360@machine.or.cz>
	 <1221222433.29747.8.camel@heerbeest> <20080912131530.GZ10360@machine.or.cz>
	 <20080912181442.GA5407@lapse.rw.madduck.net>
	 <1221648520.30402.12.camel@heerbeest>
	 <20080921142445.GJ10360@machine.or.cz> <1222074825.6698.13.camel@heerbeest>
	 <20080922152712.GN10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	Jan Holesovsky <kendy@suse.cz>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Sep 23 15:14:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki7ig-0000nZ-UN
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 15:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbYIWNNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 09:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbYIWNNO
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 09:13:14 -0400
Received: from edu-smtp-02.edutel.nl ([88.159.1.222]:35778 "EHLO
	edu-smtp-02.edutel.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbYIWNNN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 09:13:13 -0400
Received: from heerbeest (unknown [88.159.206.46])
	by edu-smtp-02.edutel.nl (Postfix) with ESMTP id 38D3C11E69E;
	Tue, 23 Sep 2008 15:13:12 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by heerbeest (Postfix) with ESMTP id AC74FDC086;
	Tue, 23 Sep 2008 15:13:11 +0200 (CEST)
In-Reply-To: <20080922152712.GN10360@machine.or.cz>
X-Mailer: Evolution 2.24.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96558>

On ma, 2008-09-22 at 17:27 +0200, Petr Baudis wrote:

Hi,

[about adding and removing topic branch dependencies]

> Do you really expect you will need this kind of functionality often,
> though?

Yes.  This is what people are used to and do now with our patches based
system.  We cannot take away such basic functionality.  Also, currently
it is very easy to do, however, it is quite error prone.  That's also 
why using [top]git would be so great.

There are ~300 topic branches.  Usually, a combination of most of these
is used as the master branch.  There are a number of scenarios where
you would want to add/remove some of these topic branches from master.

The most pressing case for this is for packagers making a release.
Unless we also make their life easier, we can forget about moving to 
[top]git.

Greetings,
Jan.

-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org
