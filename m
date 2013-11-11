From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC/PATCH 0/4] Remove deprecated commands
Date: Mon, 11 Nov 2013 21:10:42 +0000
Message-ID: <20131111211042.GR24023@serenity.lan>
References: <cover.1384098226.git.john@keeping.me.uk>
 <xmqq4n7in6c0.fsf@gitster.dls.corp.google.com>
 <20131111183853.GP24023@serenity.lan>
 <20131111191345.GL10302@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 11 22:11:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vfyl7-0000H1-ND
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 22:10:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507Ab3KKVKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 16:10:53 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:43870 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492Ab3KKVKv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 16:10:51 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id DE528CDA60B;
	Mon, 11 Nov 2013 21:10:50 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ehUOlI3f3hv9; Mon, 11 Nov 2013 21:10:49 +0000 (GMT)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 34D7ACDA5FD;
	Mon, 11 Nov 2013 21:10:44 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20131111191345.GL10302@google.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237653>

On Mon, Nov 11, 2013 at 11:13:45AM -0800, Jonathan Nieder wrote:
> John Keeping wrote:
> > On Mon, Nov 11, 2013 at 10:25:51AM -0800, Junio C Hamano wrote:
> >> John Keeping <john@keeping.me.uk> writes:
> 
> >>> "git repo-config", "git tar-tree", "git lost-found" and "git
> >>> peek-remote" have all been deprecated since at least Git 1.5.4.
> [...]
> >> Probably good material to discuss during the next cycle.
> [...]
> > I was assuming these would be queued as a "held until 2.0" branch, but
> 
> Please no. :)  We already have a nice set of features for 2.0 and I
> hope people have as few excuses not to upgrade as possible.  Anything
> that actually needs the same kind of treatment that is introduced now
> should wait for 3.0.
> 
> Removing repo-config, tar-tree, and peek-remote sounds fine to me
> (though I haven't thought much about it either way) and I agree that
> it wouldn't need to wait for an x.0 release.

For "git repo-config", the 1.5.4 release notes say that it will "be
removed in the next feature release".  I'm not sure what a "feature
release" is, but if 1.6.0 wasn't one, then I think 2.0 will be the next
one.

Although, I now see that howto/maintain-git.txt says a feature release
is numbered vX.Y.Z, so perhaps it should have been removed long before
now...
