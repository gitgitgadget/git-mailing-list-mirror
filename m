From: Tkil <tkil@scrye.com>
Subject: Re: SHA1 hash safety
Date: Sat, 16 Apr 2005 21:23:37 -0600
Message-ID: <ghdi684sm.fsf@brand.scrye.com>
References: <Pine.LNX.4.62.0504160519330.21837@qynat.qvtvafvgr.pbz>
	<20050416123155.GA19908@elte.hu>
	<Pine.LNX.4.62.0504160542190.21837@qynat.qvtvafvgr.pbz>
	<4261132A.3090907@khandalf.com>
Reply-To: Tkil <tkil@scrye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Lang <david.lang@digitalinsight.com>,
	Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 05:20:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN0KD-0001E5-Jf
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 05:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVDQDXj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 23:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVDQDXj
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 23:23:39 -0400
Received: from scrye.com ([216.17.180.1]:6532 "EHLO mail.scrye.com")
	by vger.kernel.org with ESMTP id S261242AbVDQDXi (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 23:23:38 -0400
Received: by mail.scrye.com (Postfix, from userid 19)
	id A6E3D17D04A; Sat, 16 Apr 2005 21:23:37 -0600 (MDT)
To: omb@bluewin.ch
X-Attribution: Tkil
In-Reply-To: <4261132A.3090907@khandalf.com> (Brian O'Mahoney's message of
 "Sat, 16 Apr 2005 15:29:14 +0200")
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "Brian" == Brian O'Mahoney <omb@khandalf.com> writes:

Brian> (1) I _have_ seen real-life collisions with MD5, in the context
Brian>     of Document management systems containing ~10^6 ms-WORD
Brian>     documents.

Was this whole-document based, or was it blocked or otherwise chunked?

I'm wondering, because (SFAIK) the MS word on-disk format is some
serialized version of one or more containers, possibly nested.  If
you're blocks are sized so that the first block is the same across
multiple files, this could cause collisions -- but they're the good
kind, that allow us to save disk space, so they're not a problem.

Are you saying that, within 1e7 documents, that you found two
documents with the same MD5 hash yet different contents?

That's not an accusation, btw; I'm just trying to get clarity on the
terminology.  I'm fascinated by the idea of using this sort of
content-addressable filesystem, but the chance of any collision at all
wigs me out.  I look at the probabilities, but still.

Thanks,
t.
