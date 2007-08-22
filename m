From: David Kastrup <dak@gnu.org>
Subject: Re: a475e8095aeb898c1ca60673b82df97d2300cc95 broken for docs
Date: Wed, 22 Aug 2007 09:24:15 +0200
Message-ID: <86veb8dobk.fsf@lola.quinscape.zz>
References: <86odh0ojx4.fsf@blue.stonehenge.com> <7vsl6coahd.fsf@gitster.siamese.dyndns.org> <86hcmso9ga.fsf@blue.stonehenge.com> <7v7inoo38o.fsf@gitster.siamese.dyndns.org> <20070822014140.GK27913@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 09:24:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INkZt-0006m3-CF
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 09:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755207AbXHVHY3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 03:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755182AbXHVHY3
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 03:24:29 -0400
Received: from main.gmane.org ([80.91.229.2]:41780 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752141AbXHVHY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 03:24:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1INkZj-0002e1-5w
	for git@vger.kernel.org; Wed, 22 Aug 2007 09:24:23 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 09:24:23 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 09:24:23 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:7yId82jgjwDUOzvkarUoijTFcw4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56354>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> merlyn@stonehenge.com (Randal L. Schwartz) writes:
>> 
>> >>>>>> "Junio" == Junio C Hamano <gitster@pobox.com> writes:
>> >
>> > Junio> I think we've seen it reported that docbook-xsl 1.72 and/or 1.73
>> > Junio> are broken.  Is your debug log from either of these versions?
>> >
>> > 1.71
>> 
>> Interesting.  I use 1.71 here too but it does not break.
>> 
>> I wonder what the differences are between our environments
>> (don't answer that you use OSX and I use Debian and FC -- that
>> much I already know).
>
> It broke at day-job on Cygwin today.  I don't know what version
> of docbook-xsl I'm using there.  But its fine on my OSX system.
> I had planned on debugging it at home tonight, but I can't reproduce
> it here.  Cute.  I will look at it again tomorrow and see if I can
> debug the issue.
>
> I'm pretty sure it was my recent edit to git-rev-list.txt; its
> one of the only commits that has impacted that manual page since
> the last time I had built that manual on Cygwin.  And no, nothing
> else (e.g. docbook, asciidoc, xmlto) has changed since the last
> successful build.

Line ending problem?

[P.S.: due to a stuck mail server at home, some message similar to
this one will appear in the evening]

-- 
David Kastrup
