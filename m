From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: Proposed git mv behavioral change
Date: Thu, 18 Oct 2007 22:29:28 -0400
Message-ID: <A2491F60-A00E-412A-8389-1C9EB5EDFCEF@mit.edu>
References: <c594999b2337.2337c594999b@nyroc.rr.com> <D2EAAC6D-567D-454A-AECA-C90FA2C369AE@mit.edu> <20071019015715.GW14735@spearce.org> <7F18F52A-3D57-4510-B71B-69D43480126E@MIT.EDU> <20071019021618.GE3290@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 04:29:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IihcV-0001G5-N3
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 04:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761378AbXJSC3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 22:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760888AbXJSC3k
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 22:29:40 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:61050 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760763AbXJSC3j (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Oct 2007 22:29:39 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id l9J2TUjI004693;
	Thu, 18 Oct 2007 22:29:30 -0400 (EDT)
Received: from [18.239.2.43] (WITTEN.MIT.EDU [18.239.2.43])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id l9J2TTK6026549
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 18 Oct 2007 22:29:30 -0400 (EDT)
In-Reply-To: <20071019021618.GE3290@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61609>


On 18 Oct 2007, at 10:15:29 PM, Shawn O. Pearce wrote:
> git-add amounts to either inserting a new path->stat/sha1 entry
> in the index, or updating an existing entry with new stat/sha1
> information.
>
> git-rm amounts to removing a path->stat/sha1 entry from the index.
> It's just gone once the git-rm is completed.  As if it was never
> there to begin with.
>
> A git-commit (really git-write-tree but same difference to the
> end-user) stores whatever is in the index as the gospel truth for
> how that commit's files should appear.

Ah. Basically my 'pseudo-code' is correct, but redundant.


On 18 Oct 2007, at 10:16:18 PM, Jeff King wrote:
> Eh? The changes will make it into history when you commit. Or  
> perhaps I
> don't understand your question. Can you rephrase it?

I misunderstood the (lack) of details.

On 18 Oct 2007, at 10:15:29 PM, Shawn O. Pearce wrote:
> But its all really as simple as it seems.

It's about time I read more thoroughly through the manual!

Thanks.
