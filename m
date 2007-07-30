From: David Kastrup <dak@gnu.org>
Subject: Re: "git stash" is not known to git
Date: Mon, 30 Jul 2007 12:52:40 +0200
Message-ID: <86bqdutb7r.fsf@lola.quinscape.zz>
References: <86bqduutz4.fsf@lola.quinscape.zz> <vpqwswi2pkw.fsf@bauges.imag.fr> <863az6uscz.fsf@lola.quinscape.zz> <20070730100609.GB8829@coredump.intra.peff.net> <86lkcytci4.fsf@lola.quinscape.zz> <20070730103720.GA11309@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 12:53:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFSsF-0001EN-Oj
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 12:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757249AbXG3KxM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 06:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbXG3KxL
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 06:53:11 -0400
Received: from main.gmane.org ([80.91.229.2]:50509 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751411AbXG3KxK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 06:53:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IFSrv-0007Sr-VG
	for git@vger.kernel.org; Mon, 30 Jul 2007 12:52:55 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Jul 2007 12:52:55 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Jul 2007 12:52:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:mOtlw4w211BQSufebp1JISUyn2Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54224>

Jeff King <peff@peff.net> writes:

> On Mon, Jul 30, 2007 at 12:24:51PM +0200, David Kastrup wrote:
>
>> On the other hand, I am quite sure that while "git stash" did not
>> work, "git-stash" had no problem.
>
> Right. git-stash is in your PATH, but not in git's exec path (which is
> _not_ the same as PATH).

How does it calculate its exec path?  It would appear that it would
not contain _either_ /usr/local/bin _or_ /opt/git/bin in my
installation if it can't find git-stash (which should be statable in
both places).

Have a command handy for checking the exec path?

Ok, this is pretty much idle speculation until I am back at the system
in question, but I have problems envisioning just what kind of goof
might have happened here.

-- 
David Kastrup
