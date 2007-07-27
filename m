From: David Kastrup <dak@gnu.org>
Subject: Re: git-gui problem with version number.
Date: Fri, 27 Jul 2007 07:43:13 +0200
Message-ID: <85odhy5rm6.fsf@lola.goethe.zz>
References: <86odhzpg2l.fsf@lola.quinscape.zz>
	<20070727044634.GG20052@spearce.org> <85y7h25sg6.fsf@lola.goethe.zz>
	<20070727053627.GI20052@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 27 07:43:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEIbp-0005Rv-6e
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 07:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755945AbXG0Fn0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 01:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757235AbXG0Fn0
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 01:43:26 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:46027 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755603AbXG0FnZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jul 2007 01:43:25 -0400
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 3AD7C303838;
	Fri, 27 Jul 2007 07:43:24 +0200 (CEST)
Received: from mail-in-15.arcor-online.net (mail-in-15.arcor-online.net [151.189.21.55])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id 2F46FABAE0;
	Fri, 27 Jul 2007 07:43:24 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-061-025.pools.arcor-ip.net [84.61.61.25])
	by mail-in-15.arcor-online.net (Postfix) with ESMTP id 1462410400C;
	Fri, 27 Jul 2007 07:43:24 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id CDB651C39595; Fri, 27 Jul 2007 07:43:13 +0200 (CEST)
In-Reply-To: <20070727053627.GI20052@spearce.org> (Shawn O. Pearce's message of "Fri\, 27 Jul 2007 01\:36\:27 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53895>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> David Kastrup <dak@gnu.org> wrote:
>> 
>> The one coming with the mentioned version number.  I suspect that
>> this may be a matter of the Perl libraries being used: I experience
>> this on an Ubuntu Dapper, but not on other (newer) systems compiled
>> from the same source.
>
> Ah.  Junio hasn't pulled those version numbering fixes from me yet.
> Because I haven't asked him to pull in a while.  That explains that.
>
> There's no Perl involved in git-gui, except for the Perl in an
> underlying Git command it might invoke.  So perhaps you were talking
> about Tcl above?

Uh, whatever this backtrace was in...  I did not look too closely.

> Anyway, you can setup a build with the most recent 'stable
> development' version of git-gui:
>
>   git checkout -b with-new-gitgui
>   git pull -s subtree git://repo.or.cz/git-gui.git

Ok.  Would the necessity for this depend on the Tcl version?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
