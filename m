From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: [PATCH 8/8] Docs: config: send-email config options included
Date: Sun, 28 Sep 2008 14:03:59 -0500
Message-ID: <C0DC4F74-6157-44AE-A25A-4C74A415CDDA@mit.edu>
References: <1222564196-84202-1-git-send-email-mfwitten@mit.edu> <1222564196-84202-2-git-send-email-mfwitten@mit.edu> <1222564196-84202-3-git-send-email-mfwitten@mit.edu> <1222564196-84202-4-git-send-email-mfwitten@mit.edu> <1222564196-84202-5-git-send-email-mfwitten@mit.edu> <1222564196-84202-6-git-send-email-mfwitten@mit.edu> <1222564196-84202-7-git-send-email-mfwitten@mit.edu> <1222564196-84202-8-git-send-email-mfwitten@mit.edu> <20080928032407.GC15696@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 28 21:06:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kk1aZ-0005rj-Hh
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 21:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbYI1TEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 15:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752085AbYI1TEc
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 15:04:32 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:37948 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751120AbYI1TEb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Sep 2008 15:04:31 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m8SJ40D9026877;
	Sun, 28 Sep 2008 15:04:01 -0400 (EDT)
Received: from [192.168.0.65] (97-116-104-112.mpls.qwest.net [97.116.104.112])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m8SJ3K6D015113
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 28 Sep 2008 15:04:00 -0400 (EDT)
In-Reply-To: <20080928032407.GC15696@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.929.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96982>


On 27 Sep 2008, at 10:24 PM, Jeff King wrote:

> On Sat, Sep 27, 2008 at 08:09:56PM -0500, Michael Witten wrote:
>
>> I just copied what is in the send-email man text.
>
> NAK, this makes things much worse by creating two places which must be
> updated with any changes. Shouldn't doing it the right way be as  
> simple
> as something like the patch below?

I also think it is stupid, but I didn't quite understand what you
meant before (I must have been skimming).

Also, the surrounding config variable definitions didn't really make
it clear that I could (or should) include a file (I didn't even think
about it, especially given that I didn't understand your original
suggestion).

> Though it looks like imap.* simply says "See git-imap-send(1)" in
> config.txt, which would also be OK by me (and makes sense especially  
> if
> we drop most of the sendemail.* description in favor of just  
> mentioning
> the config option near the matching command-line option).

I agree! I think these separate config variable descriptions are
superfluous and dangerously subject to obsolescence; consider
what config.txt says:

> Note that this list is non-comprehensive and not necessarily complete.
> For command-specific variables, you will find a more detailed  
> description
> in the appropriate manual page. You will find a description of non- 
> core
> porcelain configuration variables in the respective porcelain  
> documentation.

I think config.txt is not the place to put this stuff (though I've only
given it a quick glance), and include:: will just cause us to litter
the place with tool-config.txt include files, which looks yucky and is
subject to neglect.
