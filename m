From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Mon, 16 Feb 2009 15:14:21 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngpj0md.e6h.sitaramc@sitaramc.homelinux.net>
References: <20090205204436.GA6072@diku.dk> <op.uo9di902a8ed4e@dellschleppa>
 <2c6b72b30902121424o5d4ac0d7u67a7afb3b861aa19@mail.gmail.com>
 <op.uo9hiqqqa8ed4e@dellschleppa>
 <2c6b72b30902151547q5bf183f2q1e846f261825671c@mail.gmail.com>
 <slrngphgk1.hul.sitaramc@sitaramc.homelinux.net>
 <2c6b72b30902160410g25e80514q318b65ea4614cdc1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 16:16:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ5CU-0000rB-7r
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 16:16:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbZBPPOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 10:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbZBPPOc
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 10:14:32 -0500
Received: from main.gmane.org ([80.91.229.2]:48815 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750763AbZBPPOc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 10:14:32 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LZ5B1-0003dR-Ct
	for git@vger.kernel.org; Mon, 16 Feb 2009 15:14:31 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 15:14:31 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 15:14:31 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110189>

On 2009-02-16, Jonas Fonseca <jonas.fonseca@gmail.com> wrote:
> On Mon, Feb 16, 2009 at 02:33, Sitaram Chamarty <sitaramc@gmail.com> wrote:
>> On 2009-02-15, Jonas Fonseca <jonas.fonseca@gmail.com> wrote:
>>> patchset. One idea I would like to explore is to provide a compressed
>>> version of the main view, where "intermediate" commits are hidden,
>>> this way you could easily get a view of the relationship between
>>> branches.
>>
>> like 'gitk --simplify-by-decoration --all'?
>
> Great, didn't know about this option. If only tig could show the

'git log' acquired it recently, or more precisely git
rev-list did, I think.

> revision graph properly ... ;)

Yes I was going to ask about that, having been confused by
the graph once in a while.  You may want to consider using a
few other characters than the 4 you currently do (if indeed
that is the problem).

I'm interested in this too, and I do sometimes have complex
branch relationships in my work.  I'm no longer much of a C
programmer but I can certainly help test.
