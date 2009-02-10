From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Spending time in PS1, was Re: [RFC/PATCH] shortstatus v1
Date: Tue, 10 Feb 2009 17:31:14 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngp3ef2.a51.sitaramc@sitaramc.homelinux.net>
References: <1234227067-56666-1-git-send-email-tuncer.ayaz@gmail.com>
 <7vr627qd4p.fsf@gitster.siamese.dyndns.org>
 <slrngp1u4h.i22.sitaramc@sitaramc.homelinux.net>
 <alpine.DEB.1.00.0902101120460.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 18:33:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWwTh-0001Pd-76
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 18:32:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454AbZBJRba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 12:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753436AbZBJRb3
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 12:31:29 -0500
Received: from main.gmane.org ([80.91.229.2]:40998 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752827AbZBJRb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 12:31:29 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LWwSC-0006w0-8O
	for git@vger.kernel.org; Tue, 10 Feb 2009 17:31:24 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 17:31:24 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 17:31:24 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109282>

On 2009-02-10, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 10 Feb 2009, Sitaram Chamarty wrote:
>
>> I wonder if I could ask people opinions on a trick I pulled, which is 
>> basically maintain a state of the value of $SECONDS each time the user 
>> is shown a bash prompt.  If the value is the same as last time (meaning 
>> he hit enter twice in a row very quickly), it runs the extra stuff.
>
> As you know, I am a big fan of consistency.  In this light, I do not like 

Actually no; I haven't been here long enough yet.

> it when I am shown something at times, and at other times not.

However, it seems to me that this discussion is about
reconciling two conflicting needs:

  - some people (not all) want certain info in the prompt
  - but getting that info is expensive so it shouldn't be in
    the prompt *all* the time

Such a conflict might well be served by showing something
sometimes, and at other times not.  A little bit of
DWIMmery, if you will...

In any case, one can always alias something to a single
letter (say "s") if one needs quick but not "in your face"
access to this info, making this whole discussion moot if it
should not be *in* the prompt.
