From: Jared Hance <jaredhance@gmail.com>
Subject: Re: [PATCH] An alias that starts with &quot;!!&quot; runs in the current directory.
Date: Wed, 5 May 2010 20:52:37 +0000 (UTC)
Message-ID: <loom.20100505T225117-534@post.gmane.org>
References: <1273019122.16093.6.camel@ubuntu.ubuntu-domain> <20100505005153.GC25390@coredump.intra.peff.net> <4BE115EF.8010306@viscovery.net> <20100505070131.GA11265@coredump.intra.peff.net> <19425.9169.537598.876589@winooski.ccs.neu.edu> <7v1vdql4c9.fsf@alter.siamese.dyndns.org> <19425.54504.163875.379151@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 05 22:55:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9lch-0001tx-70
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 22:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756183Ab0EEUzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 16:55:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:37348 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754650Ab0EEUzG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 16:55:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O9lcV-0001oS-Mv
	for git@vger.kernel.org; Wed, 05 May 2010 22:55:04 +0200
Received: from cpe-75-186-11-174.cinci.res.rr.com ([75.186.11.174])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 May 2010 22:55:03 +0200
Received: from jaredhance by cpe-75-186-11-174.cinci.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 May 2010 22:55:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 75.186.11.174 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.3) Gecko/20100423 Ubuntu/10.04 (lucid) Firefox/3.6.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146416>

Eli Barzilay <eli <at> barzilay.org> writes:

>  			ret = system(alias_string + 1);

I don't think that this is correct. You already changed alias_string to the
actual code earlier in the command, so I think that this will actually chop off
the first letter of the command.
