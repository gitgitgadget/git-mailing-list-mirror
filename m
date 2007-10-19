From: David Kastrup <dak@gnu.org>
Subject: Re: git stash apply usability issues
Date: Fri, 19 Oct 2007 15:57:23 +0200
Message-ID: <86y7dz9ph8.fsf@lola.quinscape.zz>
References: <47171A21.9030003@viscovery.net> <20071019013156.GU14735@spearce.org> <20071019132753.GA23765@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 19 15:58:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IisMW-0006Dl-D2
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 15:58:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001AbXJSN5x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Oct 2007 09:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753960AbXJSN5x
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 09:57:53 -0400
Received: from main.gmane.org ([80.91.229.2]:58103 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753930AbXJSN5w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 09:57:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IisLy-0002lx-Fw
	for git@vger.kernel.org; Fri, 19 Oct 2007 13:57:30 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Oct 2007 13:57:30 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Oct 2007 13:57:30 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:OSo1AOtc60TTdZbmGnxslq8p3P8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61711>

Karl Hasselstr=F6m <kha@treskal.com> writes:

> On 2007-10-18 21:31:56 -0400, Shawn O. Pearce wrote:
>
>> Johannes Sixt <j.sixt@viscovery.net> wrote:
>
>> > (2) when 'git stash apply' runs merge-recursive, it treats the
>> > current state as 'ours' and the stash as 'theirs'. IMHO it should
>> > be the other way round: I have stashed away changes to a binary
>> > file. Then committed a different modification to it, and now want
>> > to apply the stash. This results in a conflict that leaves the
>> > current state in the working tree, but I had preferred that the
>> > stashed binary file were in the working tree now.
>> >
>> > What do other git-stash users think about changing the order?
>>
>> The current order is the same order that git-rebase uses. I'm not
>> saying its correct, just that its the same as rebase.
>
> FWIW, StGit push works the same way. The idea being that the current
> HEAD is our current state ("ours"), and the patch we're pushing is
> some change we want to apply ("theirs"). I always felt that this was =
a
> very natural order of things. But I guess the philosophy in the
> "stash" case is subtly different, so maybe the change is warranted
> there.

Well, maybe one should then just name this "current" and "separate"
instead of "ours" and "theirs".

--=20
David Kastrup
