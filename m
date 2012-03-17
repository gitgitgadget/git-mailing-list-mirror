From: Eric Hanchrow <eric.hanchrow@gmail.com>
Subject: Re: git push default behaviour?
Date: Sat, 17 Mar 2012 15:49:37 +0000 (UTC)
Message-ID: <loom.20120317T164347-871@post.gmane.org>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com> <87k42vs8pi.fsf@thomas.inf.ethz.ch> <CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com> <1331202483.21444.11.camel@beez.lab.cmartin.tk> <CAFsnPqpnH2CTki8zz6Mpz=qrdxF_aTA92cPrn1L9MQZVMoxdeg@mail.gmail.com> <1331203321.21444.13.camel@beez.lab.cmartin.tk> <4F58C977.8000400@xiplink.com> <vpq62efjeqd.fsf@bauges.imag.fr> <CAHkcotiOGaOdDvibpoiEgys3PnSPfSw0mT3DeEOix+FuboULiA@mail.gmail.com> <vpqfwdjas0m.fsf@bauges.imag.fr> <20120309033826.GA6164@sigill.intra.peff.net> <7vsjhi9wku.fsf@alter.siamese.dyndns.org> <vpqobs65gfc.fsf@bauges.imag.fr> <7vwr6u6qrn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 16:50:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8vtJ-00051k-RI
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 16:50:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756040Ab2CQPtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 11:49:55 -0400
Received: from plane.gmane.org ([80.91.229.3]:34615 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751020Ab2CQPtz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2012 11:49:55 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1S8vt9-0004u3-35
	for git@vger.kernel.org; Sat, 17 Mar 2012 16:49:51 +0100
Received: from q-static-138-125.avvanta.com ([206.124.138.125])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 16:49:51 +0100
Received: from eric.hanchrow by q-static-138-125.avvanta.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 16:49:51 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 206.124.138.125 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_3) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.79 Safari/535.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193333>

In response to
http://git-blame.blogspot.com/2012/03/please-discuss-what-git-push-should-do.html:

I think either 'current' or 'upstream' is a better default than
'matching', since it's less likely to surprise newbies.  However, I
cannot decide which of 'current' or 'upstream' is the best choice.  It
might be worthwhile to have 'git push' warn when someone has
push.default = current or push.default = upstream, AND when @{u} has a
different name than the local branch -- in other words, emit a warning
when 'upstream'' and 'current' refer to different branches.  The
warning itself should be turn-off-able, since it would get pretty old
pretty quickly.
