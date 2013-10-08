From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: contrib/credential/netrc/git-credential-netrc: Use of uninitialized value in string
Date: Tue, 08 Oct 2013 10:34:52 -0400
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87vc17x243.fsf@flea.lifelogs.com>
References: <CALWbr2ynAvevTxFd3duAfFzgv0DCGTDxFUaniW-8hM+eoLiOEw@mail.gmail.com>
	<xmqqr4dfhjmg.fsf@gitster.dls.corp.google.com>
	<20130827200550.GA17443@sigill.intra.peff.net>
	<87k3iyhqu5.fsf@lifelogs.com>
	<20130903173543.GC1050@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 08 16:35:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTYNT-0007IF-KV
	for gcvg-git-2@plane.gmane.org; Tue, 08 Oct 2013 16:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754230Ab3JHOfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Oct 2013 10:35:08 -0400
Received: from plane.gmane.org ([80.91.229.3]:48664 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751682Ab3JHOfF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Oct 2013 10:35:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VTYNL-0007De-U8
	for git@vger.kernel.org; Tue, 08 Oct 2013 16:35:03 +0200
Received: from c-98-229-61-72.hsd1.ma.comcast.net ([98.229.61.72])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Oct 2013 16:35:03 +0200
Received: from tzz by c-98-229-61-72.hsd1.ma.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Oct 2013 16:35:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c-98-229-61-72.hsd1.ma.comcast.net
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:JTxBJnUsgycwADpYZqKPsEltZkM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235777>

On Tue, 3 Sep 2013 13:35:44 -0400 Jeff King <peff@peff.net> wrote: 

JK> On Tue, Sep 03, 2013 at 11:23:14AM -0400, Ted Zlatanov wrote:
>> Yes, you're right.  Something like the following (untested) could work
>> and does the wildcards, which I will make into a proper patch and test
>> if it looks OK to you.
...
JK> Yeah, that makes sense to me (and is basically what the credential-cache
JK> and credential-store helpers do internally). Thanks for working on this.

Sorry for the delay, patch posted.

Ted
