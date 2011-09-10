From: Ted Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v3 0/4] Signed push
Date: Sat, 10 Sep 2011 15:22:25 -0400
Message-ID: <20110910192225.GA5397@thunk.org>
References: <1315512102-19022-1-git-send-email-gitster@pobox.com>
 <1315600904-17032-1-git-send-email-gitster@pobox.com>
 <7vipp1otyp.fsf@alter.siamese.dyndns.org>
 <CAGdFq_hWVPCEeJKKccp4Wc-j+XMSFXqRf6VYd7ngLER8RhODRQ@mail.gmail.com>
 <7vehzopdga.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 11 01:08:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2Weg-0007Y5-AQ
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 01:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934128Ab1IJWzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Sep 2011 18:55:49 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:52629 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934120Ab1IJWzs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Sep 2011 18:55:48 -0400
Received: from root (helo=tytso-glaptop.cam.corp.google.com)
	by test.thunk.org with local-esmtp (Exim 4.69)
	(envelope-from <tytso@thunk.org>)
	id 1R2WSf-0000Wq-JF; Sat, 10 Sep 2011 22:55:45 +0000
Received: from tytso by tytso-glaptop.cam.corp.google.com with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1R2T8D-0002Lg-Ir; Sat, 10 Sep 2011 15:22:25 -0400
Content-Disposition: inline
In-Reply-To: <7vehzopdga.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on test.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181163>

On Sat, Sep 10, 2011 at 09:30:29AM -0700, Junio C Hamano wrote:
> Sverre Rabbelier <srabbelier@gmail.com> writes:
> 
> > I think this is also some further motivation to have a
> 
> Did you miss that I already mentioned that workaround?  It does not _fix_
> the fundamental breakage, which is that you are _forcing_ the sending side
> to keep copies, though.

I guess I'm confused about what the problem is with this?

If I do something like this:

git tag -s -m for_linus-20110910 for_linus-20110910
git push github
git push --tags github

I'm "forcing" the sending side to keep the signed tag, no?  Isn't that
kind of implicit in allowing someone to push to your repo?

     		    	     	     	     	- Ted
