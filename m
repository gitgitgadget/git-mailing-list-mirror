From: Eli Barzilay <eli@barzilay.org>
Subject: Re: Re: git log -M -- filename is not working?
Date: Thu, 13 May 2010 00:39:35 -0400
Message-ID: <19435.33415.163892.762639@winooski.ccs.neu.edu>
References: <20100508044434.GC14998@coredump.intra.peff.net>
	<20100508053025.GG14998@coredump.intra.peff.net>
	<7v39y3c5p1.fsf@alter.siamese.dyndns.org>
	<19429.3589.823244.270582@winooski.ccs.neu.edu>
	<20100512113855.GB23847@coredump.intra.peff.net>
	<19434.39095.448649.313537@winooski.ccs.neu.edu>
	<20100512124948.GA11761@coredump.intra.peff.net>
	<19434.48308.815673.263230@winooski.ccs.neu.edu>
	<AANLkTilje2dBHjd2aykMnAjWdf8k1vayJ_ez4IfMrl7_@mail.gmail.com>
	<20100512164522.GA14710@coredump.intra.peff.net>
	<AANLkTilES9d8rj5Zwfju7t3H7cjM7h9HWL8YprcxPc6t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eugene Sajine <euguess@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 13 06:39:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCQDH-0008HO-1o
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 06:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307Ab0EMEji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 00:39:38 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:55818 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132Ab0EMEji (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 00:39:38 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1OCQCt-0004JE-5e; Thu, 13 May 2010 00:39:35 -0400
In-Reply-To: <AANLkTilES9d8rj5Zwfju7t3H7cjM7h9HWL8YprcxPc6t@mail.gmail.com>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146976>

On May 13, Bo Yang wrote:
> 
> Ah, sorry. I just copy the patch from my putty window, so it convert
> all tabs into spaces...  And the following change this. Also, I have
> run a 'make test', seems there is no problem for it. Happy try it!

There are still a few lines that got wrapped -- after I fixed them I
could apply it, and it looks like it works as (I) expected with and
without `-p'.  (I didn't try to measure the speed though -- it was
perfectly fine for any interactive use that I'd want to use it for.)

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
