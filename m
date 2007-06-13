From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: That improved git-gui blame viewer..
Date: Thu, 14 Jun 2007 01:20:56 +0200
Organization: At home
Message-ID: <f4ptq3$71v$1@sea.gmane.org>
References: <alpine.LFD.0.98.0706091117510.20321@woody.linux-foundation.org> <20070611064203.GG6073@spearce.org> <alpine.LFD.0.98.0706110826590.14121@woody.linux-foundation.org> <7vveduqxxr.fsf@assigned-by-dhcp.pobox.com> <e5bfff550706112316j42c7c8e8uf8383de990ca9707@mail.gmail.com> <7vbqflll55.fsf@assigned-by-dhcp.pobox.com> <e5bfff550706120427g7ad9d38bpc34d9ea284ace693@mail.gmail.com> <20070612135303.GT6073@spearce.org> <7v645thto7.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 14 01:20:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hyc8O-0006HI-Vv
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 01:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756295AbXFMXUO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 19:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756310AbXFMXUN
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 19:20:13 -0400
Received: from main.gmane.org ([80.91.229.2]:46097 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756290AbXFMXUM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 19:20:12 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hyc7C-0004ev-UM
	for git@vger.kernel.org; Thu, 14 Jun 2007 01:19:02 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Jun 2007 01:19:02 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Jun 2007 01:19:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50146>

Junio C Hamano wrote:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
>> Marco Costalba <mcostalba@gmail.com> wrote:
>>> On 6/12/07, Junio C Hamano <gitster@pobox.com> wrote:
>>> >
>>> > (1) Are you emulating CVS-like "a file has an identity, and we
>>> >     follow its changes" model?  How does it handle file split,
>>> >     merge, and code movement in general?
>>> >
>>> 
>>> It uses 'git rev-list HEAD -- <path>' to get the list of revisions
>>> that modified a path,
>>
>> So apparently yes, qgit is emulating CVS.  And yet much better things
>> exist (git-blame).
> 
> I would not use the word "better", as it depends on what you are
> looking for.
[...]
> The way Marco describes is a perfectly valid way to satisfy
> expectations of people migrating from CVS.  It's more faithful
> reproduction of CVS annotate behaviour.  In a sense, git-blame
> does too much, but that is exactly why these "accurate and
> interesting" behaviours are optional.

Perhaps the qgit annotating would find it's way in core git as git-annotate
(which currently is alias to git-blame + some compatibility options), or
as an option (--bottom-up) to git-blame?

On the other hand side, blaming multiple files in parallel has sense I think
only for graphical viewer, not for command line command.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
