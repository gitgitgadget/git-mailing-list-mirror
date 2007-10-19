From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: Proposed git mv behavioral change
Date: Thu, 18 Oct 2007 23:26:32 -0400
Message-ID: <7E3647F4-E61C-4FBE-9AA7-81CDBE324308@MIT.EDU>
References: <c594999b2337.2337c594999b@nyroc.rr.com> <20071019015419.GV14735@spearce.org> <A2C1BF08-4CC8-4F98-9CA8-B81B2FBFE9E4@mit.edu> <20071019031959.GE14735@spearce.org> <20071019032407.GA10622@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 05:26:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiiVg-00005a-4a
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 05:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934445AbXJSD0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 23:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758673AbXJSD0l
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 23:26:41 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:38139 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754569AbXJSD0k (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Oct 2007 23:26:40 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id l9J3QYEF003047;
	Thu, 18 Oct 2007 23:26:34 -0400 (EDT)
Received: from [18.239.2.43] (WITTEN.MIT.EDU [18.239.2.43])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id l9J3QXpw005364
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 18 Oct 2007 23:26:34 -0400 (EDT)
In-Reply-To: <20071019032407.GA10622@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61630>


On 18 Oct 2007, at 11:24:07 PM, Jeff King wrote:

> On Thu, Oct 18, 2007 at 11:19:59PM -0400, Shawn O. Pearce wrote:
>
>> touch the working tree".  Here we want to touch the working tree
>> in the sense of moving the file.  So --cached is not the correct
>> option name.
>
> Doesn't "mv" do that?

We only want to move it, not also add its dirty contents.
