From: Eli Barzilay <eli@barzilay.org>
Subject: Re: Re: git log -M -- filename is not working?
Date: Fri, 14 May 2010 01:05:10 -0400
Message-ID: <19436.55814.552536.42519@winooski.ccs.neu.edu>
References: <19428.24021.324557.517627@winooski.ccs.neu.edu>
	<20100508044434.GC14998@coredump.intra.peff.net>
	<19428.62170.654092.308682@winooski.ccs.neu.edu>
	<20100508053025.GG14998@coredump.intra.peff.net>
	<7v39y3c5p1.fsf@alter.siamese.dyndns.org>
	<19429.3589.823244.270582@winooski.ccs.neu.edu>
	<20100512113855.GB23847@coredump.intra.peff.net>
	<19434.39095.448649.313537@winooski.ccs.neu.edu>
	<20100512124948.GA11761@coredump.intra.peff.net>
	<19434.48308.815673.263230@winooski.ccs.neu.edu>
	<20100514045522.GE6075@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eugene Sajine <euguess@gmail.com>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 14 07:05:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCn5T-00031I-BA
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 07:05:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854Ab0ENFFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 01:05:16 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:48835 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752332Ab0ENFFP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 01:05:15 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1OCn5C-0005I9-IA; Fri, 14 May 2010 01:05:10 -0400
In-Reply-To: <20100514045522.GE6075@coredump.intra.peff.net>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147049>

On May 14, Jeff King wrote:
> [...]

(I didn't get most of that...)

> The only "downside" is that it means --follow actually impacts the diff
> generation by implying --find-copies-harder. And I put downside in
> quotes because it is probably not a big deal. We have already spent the
> CPU time to find the answer, so it is silly not to show it. I can't
> imagine why somebody would want --follow, but would _not_ want rename
> detection in the resulting diff.

...but this seems very reasonable.  (In fact, if --follow implies
finding copies and renames, and if it's doing that for diff too, then
it's exactly what I originally wanted.)


> Bo's version of the patch does that optimization. When I clean up the
> patch (probably sometime next week), I'll take those changes.

Thanks!

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
