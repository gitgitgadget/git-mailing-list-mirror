From: Eli Barzilay <eli@barzilay.org>
Subject: Re: [PATCH] An alias that starts with &quot;!!&quot; runs in the current directory.
Date: Wed, 5 May 2010 16:58:11 -0400
Message-ID: <19425.56291.689142.569365@winooski.ccs.neu.edu>
References: <1273019122.16093.6.camel@ubuntu.ubuntu-domain>
	<20100505005153.GC25390@coredump.intra.peff.net>
	<4BE115EF.8010306@viscovery.net>
	<20100505070131.GA11265@coredump.intra.peff.net>
	<19425.9169.537598.876589@winooski.ccs.neu.edu>
	<7v1vdql4c9.fsf@alter.siamese.dyndns.org>
	<19425.54504.163875.379151@winooski.ccs.neu.edu>
	<loom.20100505T225117-534@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 05 22:58:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9lfx-0003yK-Kf
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 22:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757921Ab0EEU6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 16:58:14 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:40746 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756420Ab0EEU6N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 16:58:13 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1O9lfX-0007mf-Ma; Wed, 05 May 2010 16:58:11 -0400
In-Reply-To: <loom.20100505T225117-534@post.gmane.org>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146418>

On May  5, Jared Hance wrote:
> Eli Barzilay <eli <at> barzilay.org> writes:
> 
> >  			ret = system(alias_string + 1);
> 
> I don't think that this is correct. You already changed alias_string
> to the actual code earlier in the command, so I think that this will
> actually chop off the first letter of the command.

(*sigh*)  That's correct, I fixed this, but improperly remade the
patch.

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
