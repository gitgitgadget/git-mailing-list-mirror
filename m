From: David Kastrup <dak@gnu.org>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 18:05:25 +0200
Message-ID: <86k5fk1ooq.fsf@lola.quinscape.zz>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
	<32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com>
	<alpine.DEB.1.00.0807161902400.8986@racer>
	<32541b130807161135h64024151xc60e23d222a3a508@mail.gmail.com>
	<alpine.LNX.1.00.0807161605550.19665@iabervon.org>
	<861w1sn4id.fsf@lola.quinscape.zz>
	<m3od4wse30.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 18:07:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJW08-0002Yi-M7
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 18:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757287AbYGQQFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 12:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756545AbYGQQFl
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 12:05:41 -0400
Received: from main.gmane.org ([80.91.229.2]:59724 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756241AbYGQQFk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 12:05:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KJVz3-00077v-Nm
	for git@vger.kernel.org; Thu, 17 Jul 2008 16:05:33 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 16:05:33 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 16:05:33 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:li7f8RYdlD0A31vxbfYjM6a3LTk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88870>

Jakub Narebski <jnareb@gmail.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Daniel Barkalow <barkalow@iabervon.org> writes:
>
>> > SVN branches are incredible confusing because they fail to
>> > distinguish the directory structure of the project's source tree
>> > from the arrangement of available latest versions.
>> 
>> That is because there _is_ no difference.  You just store different
>> versions in different places.  What they are named is a convention,
>> nothing more, nothing less.
>
> Branching by copying (!) and tagging by copying (!!!) is abuse
> of the fact that copying in Subversion is cheap.

Uh, no.  A lot of work has been invested into ensuring that copying in
Subversion in cheap _exactly_ because of the design decision to
implement branching and tagging via copying.

It is not an accident that copying is cheap.

> Distinguishing between branch part of directory name by _convention_
> is design mistake; the fact that the tool doesn't help to ensure that
> (a) tags lie on branch (b) tags _doesn't change_ is an example of this
> stupidity.

How much have you worked with Subversion so far?  I am doing quite a bit
of work with it, and the do-everything-via-copying paradigm does not get
in my hair.  It actually means that I have to remember fewer commands.
And it is pretty easy to understand.

>> Really, Subversion is rather simple to understand.  But it is not a
>> DVCS.  Moving a history from one repository to another is not really
>> feasible unless you are doing straight mirroring.
>
> Subversion is simple if you are limited to simple things; but the
> same is true with Git.  I find for example the whole 'properties'
> mechanism and its use seriously not simple.

Granted, particularly concerning the external property. OTOH, it makes
the equivalent of git submodules rather cheap (and I actually still have
no idea how git submodules properly work and what implications they
have).

-- 
David Kastrup
