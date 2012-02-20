From: Jeff King <peff@peff.net>
Subject: Re: git-subtree Ready #2
Date: Mon, 20 Feb 2012 15:53:46 -0500
Message-ID: <20120220205346.GA6335@sigill.intra.peff.net>
References: <877gztmfwy.fsf@smith.obbligato.org>
 <8739acra5j.fsf@smith.obbligato.org>
 <20120215050855.GB29902@sigill.intra.peff.net>
 <87sjicpsr1.fsf@smith.obbligato.org>
 <87ty2ro1zf.fsf@smith.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Mon Feb 20 21:54:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzaF8-00058f-7c
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 21:53:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759Ab2BTUxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 15:53:50 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44168
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753725Ab2BTUxt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 15:53:49 -0500
Received: (qmail 6997 invoked by uid 107); 20 Feb 2012 20:53:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Feb 2012 15:53:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Feb 2012 15:53:46 -0500
Content-Disposition: inline
In-Reply-To: <87ty2ro1zf.fsf@smith.obbligato.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191104>

On Wed, Feb 15, 2012 at 10:07:16PM -0600, David A. Greene wrote:

> I've attached Avery's response below.  The short summary is that he
> thinks maintaining it in the vger git repository is the way to go and
> that he's fine moving patches to/from GitHub as necessary.
>
> [From Avery:]
>> I'm sure the potential benefit of putting git-subtree in the contrib/
>> directory is that we could then use git-subtree to maintain the
>> git-subtree git subtree, which is a fun wordplay, but perhaps
>> ironically, as a single rarely-changing file, git-subtree is probably
>> not the right tool for these purposes :)

I'm not a git-subtree user, nor am I the maintainer who would pull from
you. So I am somewhat on the sidelines of this particular discussion.

Usually we would incubate new and radically different commands in
contrib, and then if they prove to be good, make first-class commands of
them (e.g., git-new-workdir has been in contrib for a while, and as it
has proven itself to many people, there is talk of including it as a
core command).

My impression is that git-subtree has already done this incubation and
proving step in its own repository (but like I said, I do not use it
myself, so that is just going on list hearsay). So it seems like the
logical step would be to graduate into the main git repository.  And I
gather from Avery's response that he agrees.

Of course there's no real reason we can't take it slow by putting it in
contrib, and then graduating from there. It just seems like an
unnecessary and complicated interim step. Either way, I do think it's
worth saving the commit history by doing a real merge.

I dunno. It is really up to Junio, I guess. He usually relies on list
consensus for decisions like this, and there has not been that much
discussion. What do users of git-subtree think, as this would primarily
benefit them? And what do other members of the git@vger community who do
not use git-subtree think of the burden of carrying it as a first-class
command (not so much the burden of adding it, but of maintaining it,
fielding reports when it is broken, etc)?

As a non-user, I am totally fine with it. I think the burden is not that
high, and you have already promised to deal with ongoing maintenance
issues.

-Peff
