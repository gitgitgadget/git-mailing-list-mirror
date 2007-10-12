From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Fixing path quoting issues
Date: Fri, 12 Oct 2007 15:14:53 +0200
Message-ID: <86bqb4qxte.fsf@lola.quinscape.zz>
References: <11920508172434-git-send-email-jon.delStrother@bestbefore.tv> <470DC05A.8020209@viscovery.net> <854pgytafi.fsf@lola.goethe.zz> <470DCC76.7070809@viscovery.net> <81156EED-7AC0-4C8B-98B1-8338262459A6@bestbefore.tv> <470DD3B8.1080809@viscovery.net> <85k5pts796.fsf@lola.goethe.zz> <E43846E3-4F42-4B3A-BA5F-1A21FE70C3FB@wincent.com> <Pine.LNX.4.64.0710121235230.25221@racer.site> <A7970E82-92E0-4267-AF79-D4ABDB21F0D0@wincent.com> <Pine.LNX.4.64.0710121351200.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 12 15:21:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgKNQ-0000cB-0Z
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 15:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753672AbXJLNQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 09:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752507AbXJLNQR
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 09:16:17 -0400
Received: from main.gmane.org ([80.91.229.2]:47293 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753263AbXJLNQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 09:16:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IgKMX-00026P-JU
	for git@vger.kernel.org; Fri, 12 Oct 2007 13:15:33 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Oct 2007 13:15:33 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Oct 2007 13:15:33 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:Muh8lKlZzO9Cl6yNl0ZSvhobSlM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60688>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 12 Oct 2007, Wincent Colaiuta wrote:
>
>> El 12/10/2007, a las 13:37, Johannes Schindelin escribi?:
>> 
>> > On Fri, 12 Oct 2007, Wincent Colaiuta wrote:
>> > 
>> > > El 11/10/2007, a las 22:53, David Kastrup escribi?:
>> > > 
>> > > > Johannes Sixt <j.sixt@viscovery.net> writes:
>> > > > 
>> > > > > Jonathan del Strother schrieb:
>> > > > > > How are you going to test that git works on paths with spaces if
>> > > > > > the
>> > > > > > test suite doesn't run there?
>> > > > > 
>> > > > > By writing a specific test?
>> > > > 
>> > > > This is going to be much less thorough.  And it does no harm if the
>> > > > test scripts demonstrate defensive programming.
>> > > 
>> > > +1: especially in this case, where it really is "defensive" and not
>> > > "paranoiac".
>> > 
>> > I am all for it, _iff_ the guilty parties (and by that, I mean _you_) do
>> > it and keep maintaining it.  See?  Discussion closed already.
>> 
>> How am *I* the guilty party? I'm merely endorsing David's comment that a 
>> modicum of defensive programming isn't a bad thing; an eminently 
>> reasonable position which is somewhat difficult to argue against.
>
> All I'm saying: let patches speak.  Talk is cheap.

The patches spoke.  That is what the [PATCH] in the subject line was about.

-- 
David Kastrup
