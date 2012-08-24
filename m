From: Jeff King <peff@peff.net>
Subject: Re: Reg:Git-ssh bug
Date: Fri, 24 Aug 2012 05:22:45 -0400
Message-ID: <20120824092244.GA12416@sigill.intra.peff.net>
References: <02C1EA56-2145-4FD5-9FD2-377514C12704@umail.iu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Gokulramkumar Subramaniam <goksubra@umail.iu.edu>
X-From: git-owner@vger.kernel.org Fri Aug 24 11:23:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4q6W-0006t9-CQ
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 11:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755907Ab2HXJWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 05:22:54 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47093 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753119Ab2HXJWx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 05:22:53 -0400
Received: (qmail 30586 invoked by uid 107); 24 Aug 2012 09:23:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 24 Aug 2012 05:23:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Aug 2012 05:22:45 -0400
Content-Disposition: inline
In-Reply-To: <02C1EA56-2145-4FD5-9FD2-377514C12704@umail.iu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204194>

On Thu, Aug 23, 2012 at 06:22:01PM -0400, Gokulramkumar Subramaniam wrote:

> I am new to Git and I am trying to add my machine with Git but it is failing through ssh method.
> 
> Error received:
> 
> $ ssh-add -l
> 2048 5f:6f:39:ed:b0:76:2e:d0:xx:xx:xx:xx:xx:xx:xx:xx id_rsa (RSA)
> 
> Gokul$ ssh -vT git@github.com
> [...]
> debug1: Authentications that can continue: publickey
> debug1: Next authentication method: publickey
> debug1: Offering RSA public key: id_rsa
> debug1: Authentications that can continue: publickey
> debug1: Offering RSA public key: /Users/Gokul/.ssh/id_rsa
> debug1: Authentications that can continue: publickey
> debug1: Trying private key: /Users/Gokul/.ssh/id_dsa
> debug1: No more authentication methods to try.
> Permission denied (publickey).

That means that the server does not like your public key, typically
because it does not match a keypair that has been uploaded. This is a
GitHub issue, not a Git issue.

Double-check that your key is listed at:

  https://github.com/settings/ssh

and add it there if necessary. If it is still not working, then contact
GitHub support (support@github.com).

-Peff
