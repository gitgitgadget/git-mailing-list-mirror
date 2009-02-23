From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add bare repository indicator for __git_ps1
Date: Mon, 23 Feb 2009 07:42:37 -0800
Message-ID: <20090223154237.GH22848@spearce.org>
References: <1235227723-11471-1-git-send-email-git@storm-olsen.com> <7v8wnzr3k9.fsf@gitster.siamese.dyndns.org> <49A05958.7050703@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <git@storm-olsen.com>, git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 16:44:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbcyp-0001ew-I5
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 16:44:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755402AbZBWPml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 10:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755456AbZBWPmk
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 10:42:40 -0500
Received: from george.spearce.org ([209.20.77.23]:39396 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755056AbZBWPmj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 10:42:39 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 730AE38210; Mon, 23 Feb 2009 15:42:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <49A05958.7050703@trolltech.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111141>

Marius Storm-Olsen <marius@trolltech.com> wrote:
> Junio C Hamano said the following on 21.02.2009 20:29:
>> Marius Storm-Olsen <git@storm-olsen.com> writes:
>>> Prefixes the branch name with "BARE:" if you're in a bare
>>> repository.
>
>> There may be a different workflow where you would stay in a bare  
>> repository for an extended period of time and you would benefit
>> from such a reminder like this patch adds, but I do not think of
>> one.
>
> Right, I have quite a few repos on my machine which are just bare, as I 
> use them gather branches and push out again.  
> (http://repo.or.cz/w/git/platforms.git is one of them) However, it's  
> probably just me, since I could just as easily put them in a proper  
> directory structure to indicate their bareness.
>
> Anyways, I just thought it would fairly "low cost" to add, and nice to  
> have.

Its not that low of a cost, its an extra fork+exec per prompt when in
a .git/ or a bare repository.  Neither is very common when compared
to a workdir, Junio's right about that.  But its YAFE.  ;)

> Consider it, as Linus coined the term, a throw-away patch. I can easily 
> put it in my .bashrc instead. :)

Like Junio, I'm not very compelled to include this patch.  I just
don't see enough to make including it worthwhile.

-- 
Shawn.
