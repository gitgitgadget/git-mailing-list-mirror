From: Jeff King <peff@peff.net>
Subject: Re: cannot find hash in the log output
Date: Fri, 3 Dec 2010 12:52:13 -0500
Message-ID: <20101203175212.GA8267@sigill.intra.peff.net>
References: <AANLkTi=5b26aPLm_Byqg=c9=sPpg5jEPDDpf1J9WgOdY@mail.gmail.com>
 <7v8w07rje3.fsf@alter.siamese.dyndns.org>
 <AANLkTimExbMn4-E-zuAGmi+p1wNAHoetpeyr2SK6vGxk@mail.gmail.com>
 <AANLkTinAUfFge-AcfQevG2_9Gi3oOPy+-SrEZrfp4byn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 18:52:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POZny-0003aX-8w
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 18:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753508Ab0LCRwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 12:52:15 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:53582 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751550Ab0LCRwO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 12:52:14 -0500
Received: (qmail 23929 invoked by uid 111); 3 Dec 2010 17:52:13 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 03 Dec 2010 17:52:13 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Dec 2010 12:52:13 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTinAUfFge-AcfQevG2_9Gi3oOPy+-SrEZrfp4byn@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162819>

On Fri, Dec 03, 2010 at 12:41:52PM -0500, Eugene Sajine wrote:

> > yes. I do see it with your command.
> >
> > git ls-tree -r HEAD | grep <resulting SHA1 from git hash-object>
> >
> > Thanks,
> > Eugene
> >
> 
> While I'm able to see that object using the command Junio has provided
> the question remains the same:
> How could the file get into the state where its hash (git has-object
> file-name) cannot be found in any commit (git log --raw --no-abbrev |
> grep SHA1), if there was no local changes made to the file???

If the blob was created as the resolution of a merge conflict, I don't
think that will appear in the output of "git log --raw".

-Peff
