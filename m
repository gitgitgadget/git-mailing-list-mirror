From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] contrib/difftool: add support for Kompare
Date: Sat, 31 Jan 2009 11:41:23 +0100
Message-ID: <200901311141.23986.markus.heidelberg@web.de>
References: <200901310019.30117.markus.heidelberg@web.de> <20090131063714.GA29621@gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 31 11:42:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTDJO-0001wm-1o
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 11:42:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbZAaKl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 05:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbZAaKl2
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 05:41:28 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:51201 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbZAaKl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 05:41:27 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 19E37FC882C0;
	Sat, 31 Jan 2009 11:41:25 +0100 (CET)
Received: from [89.59.86.74] (helo=pluto)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LTDHw-0001i4-00; Sat, 31 Jan 2009 11:41:24 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <20090131063714.GA29621@gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+R9ZnL234aNmnocC92pdztR0zOY8RxfqZV2VPo
	yYDAfG8ZuzupO86+6Jn3vYFIsaKnApauyX7yOfiJKj7Jx9cUGj
	piWIWifYdL/oJLrYQ1ng==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107916>

David Aguilar, 31.01.2009:
> On  0, Markus Heidelberg <markus.heidelberg@web.de> wrote:
> > 
> > Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
> > ---
> >  contrib/difftool/git-difftool-helper |   16 ++++++++++------
> >  contrib/difftool/git-difftool.txt    |    3 ++-
> >  2 files changed, 12 insertions(+), 7 deletions(-)
> 
> 
> Good stuff =)
> Should we patch mergetool with the same change?
> Kompare's pretty popular in KDE land.

But Kompare cannot merge. It is kind of a diff/patch frontend, it takes
only one or two files (or directories) as arguments.

> BTW git.git's next branch has:
> 
> commit fb700cb0679e22900f0d1435641e6cf7c652968b
> Author: Johannes Gilger <heipei@hackvalue.de>
> Date:   Sat Jan 24 00:12:45 2009 +0100
> 
>     mergetool: Don't repeat merge tool candidates
>     
>     git mergetool listed some candidates for mergetools twice, depending on
>     the environment.
>     
>     This slightly changes the behavior when both KDE_FULL_SESSION and
>     GNOME_DESKTOP_SESSION_ID are set at the same time; in such a case
>     meld is used in favor of kdiff3 (the old code favored kdiff3 in such a
>     case), but it should not matter in practice.
>     
>     Signed-off-by: Johannes Gilger <heipei@hackvalue.de>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> 
> difftool probably needs a similar patch.
> I'll see if I can get to that this weekend if no one beats
> me to it.

Yes, the change would make sense here, too.

Markus
