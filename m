From: David Kastrup <dak@gnu.org>
Subject: Re: git-gui problem with version number.
Date: Sun, 29 Jul 2007 11:08:30 +0200
Message-ID: <85ejirziep.fsf@lola.goethe.zz>
References: <86odhzpg2l.fsf@lola.quinscape.zz>
	<20070727044634.GG20052@spearce.org> <85y7h25sg6.fsf@lola.goethe.zz>
	<20070727053627.GI20052@spearce.org> <85odhy5rm6.fsf@lola.goethe.zz>
	<20070727054815.GJ20052@spearce.org> <85ejiu5r9r.fsf@lola.goethe.zz>
	<86k5smnvhw.fsf@lola.quinscape.zz> <86lkd2mcsu.fsf@lola.quinscape.zz>
	<20070729071030.GL20052@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jul 29 11:08:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF4lj-00067T-N4
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 11:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760707AbXG2JIx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 05:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760322AbXG2JIx
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 05:08:53 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:47538 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760308AbXG2JIw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2007 05:08:52 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 04D251F56E6;
	Sun, 29 Jul 2007 11:08:51 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id CB9A612DF03;
	Sun, 29 Jul 2007 11:08:50 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-017-015.pools.arcor-ip.net [84.61.17.15])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id A26A236E869;
	Sun, 29 Jul 2007 11:08:50 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 399F71CFF95E; Sun, 29 Jul 2007 11:08:30 +0200 (CEST)
In-Reply-To: <20070729071030.GL20052@spearce.org> (Shawn O. Pearce's message of "Sun\, 29 Jul 2007 03\:10\:30 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54098>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> David Kastrup <dak@gnu.org> wrote:
>> David Kastrup <dak@gnu.org> writes:
>> 
>> > Now that is funny.  I am pretty sure (or rather _have_ been pretty
>> > sure) that I cloned the respective repositories with the same command.
>> > Yet now both are up-to-date according to git-pull (and have identical
>> > .config contents), and the first compiles version git version
>> > 1.5.3.rc2.41.gb47b1 while the second compiles version
>> > 1.5.3.rc3.7.gd58e-dirty.  Both have been cloned from git.git, the
>> 
>> A combination of rebasing and pushing made the difference go away and
>> made git-gui work again.  Nevertheless, it would be a good idea not to
>> balk at the dirty version strings.
>
> Did you not see me already state in this thread that its already
> been fixed?

I saw you state that the problem was fixed in your local version, but
that this had not been pulled into git.git.  So I was adding a vote to
have this included.

> Latest git-gui already has the problem dealt with, and that latest
> version will be included in git 1.5.3 when it ships.

That is good to hear but it was far from obvious when I wrote the
above mail.

> Nevertheless, thanks for the problem report.

You are welcome.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
