From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Command-line interface thoughts
Date: Thu, 09 Jun 2011 21:17:15 +0200
Message-ID: <4DF11C3B.4000804@alum.mit.edu>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com> <m339jps1wt.fsf@localhost.localdomain> <BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com> <201106051311.00951.jnareb@gmail.com> <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com> <7vwrgza3i2.fsf@alter.siamese.dyndns.org> <4DF08D30.7070603@alum.mit.edu> <20110609161832.GB25885@sigill.intra.peff.net> <4DF10ADA.5070206@alum.mit.edu> <7v8vtayhnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 21:17:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUkjX-0002gU-P7
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 21:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754388Ab1FITRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 15:17:30 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:59540 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943Ab1FITR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 15:17:29 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p59JHFRx010044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 9 Jun 2011 21:17:15 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <7v8vtayhnm.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175567>

On 06/09/2011 08:38 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> Wouldn't the four trees described above contain information equivalent
>> to the contents of the index?
> 
> In the same sense that you can re-create the state in the index by running
> the merge again between HEAD and MERGE_HEAD, yes, they probably do, but is
> that a useful question to ask?

The questions is obviously not useful if the only answer is the one that
you give.

But it seems to me that the four pseudo-trees NEXT, OURS, THEIRS, and
BASE are a complete and self-consistent alternative representation of
the information contained in the index.  If this is true, then I claim
that this representation would be much easier to understand and remember
than the index stages (with its highly mnemonic names 0, 1, 2, and 3!)
and the irregular myriad of commands and options currently needed to
access it.

> I think this mega-thread served its purpose. It started to explore "will
> it make it easier to understand and explain if we use these tokens to name
> trees that do not exist in reality?" which is a worthy thing to do.  The
> conclusion appears to be "well we do not even know what exactly these
> tokens mean in certain situations."

Why do you reach that conclusion?  Are you claiming that the proposed
definitions of the four pseudo-trees upthread are incorrect or
insufficiently defined?

We are about to introduce git at my company, and this is one of the
points that makes me cringe when I think of explaining it to developers
(let alone non-developers).  Even here on the git mailing list, where
most people are numbed to the git UI, there has been a lot of confusion
about how to get needed information from the index.  And I truly believe
that the commands currently needed to access the information in the
index are so nonuniform that half of the participants in this discussion
will have to look them up *again* the next time they need them.

Please throw us struggling users a bone :-)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
