From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [PATCH] git-svn: respect Subversion's [auth] section configuration values
Date: Sun, 7 Oct 2007 14:14:37 +0400
Message-ID: <20071007101437.GB3943@void.codelabs.ru>
References: <20071006185719.GA3943@void.codelabs.ru> <4708355B.4090403@vilain.net> <20071006185719.GA3943@void.codelabs.ru> <20071007032241.GG14972@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>, Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sun Oct 07 12:14:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeT9z-0000ba-1S
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 12:14:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307AbXJGKOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 06:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752283AbXJGKOq
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 06:14:46 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:60364 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259AbXJGKOp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 06:14:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=iPtXMELaJZ0P6xn4Z+U6xepdMXojtnt8FDNI5OESr3Bpd6HDCxDmEkrzXQeCkTrBEFCT8Wrp1+OeSz/1Q/3rKaEmsIhZT4wWJk03iGDiwn6aFgtF6JiK8q5Pby4ADtKPu4/eFLdOo0sasXwRrDySAl29ShU8RFXhcoo5QFpqVI0=;
Received: from void.codelabs.ru (void.codelabs.ru [144.206.177.25])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1IeT9m-000CUK-IH; Sun, 07 Oct 2007 14:14:42 +0400
Content-Disposition: inline
In-Reply-To: <4708355B.4090403@vilain.net> <20071007032241.GG14972@hand.yhbt.net>
X-Spam-Status: No, score=-1.6 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_50
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60174>

Eric, Sam, good day.

Sat, Oct 06, 2007 at 08:22:41PM -0700, Eric Wong wrote:
> Eygene Ryabinkin <rea-git@codelabs.ru> wrote:
> > Parameters 'store-passwords' and 'store-auth-creds' from Subversion's
> > configuration (~/.subversion/config) were not respected.  This was
> > fixed: the default values for these parameters are set to 'yes' to
> > follow Subversion behaviour.
> 
> Thanks.

You're welcome ;))

Sun, Oct 07, 2007 at 02:24:43PM +1300, Sam Vilain wrote:
> Eygene Ryabinkin wrote:
> > Parameters 'store-passwords' and 'store-auth-creds' from Subversion's
> > configuration (~/.subversion/config) were not respected.  This was
> > fixed: the default values for these parameters are set to 'yes' to
> > follow Subversion behaviour.
> >   
> 
> I saw this in the svn api before.  It really is a strange API, requiring
> the user to get things like this right.

Yes, the need to parse the configuration and set some flags is
rather strange.  Looks like nobody cared to stuff the code like
I had added to the configuration file parsing routines.

> You can use no warnings 'once';

Great, thanks for the pointer!  Eric, do you want me to produce
another patch or you'll correct mine?
-- 
Eygene
