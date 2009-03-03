From: Jeff King <peff@peff.net>
Subject: Re: move files between disparate repos and maintain version history
Date: Tue, 3 Mar 2009 12:18:35 -0500
Message-ID: <20090303171835.GB454@coredump.intra.peff.net>
References: <0d8965bb-e2ed-4f49-b323-c110f605ae2c@33g2000yqm.googlegroups.com> <20090303041300.GA18136@coredump.intra.peff.net> <f95d47890903030858xb398b5fy1aeabb19166e6077@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Copeland <davetron5000@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 18:20:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeYHo-0002K8-9X
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 18:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739AbZCCRSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 12:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752995AbZCCRSk
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 12:18:40 -0500
Received: from peff.net ([208.65.91.99]:57109 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752796AbZCCRSj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 12:18:39 -0500
Received: (qmail 18283 invoked by uid 107); 3 Mar 2009 17:18:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 03 Mar 2009 12:18:38 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Mar 2009 12:18:35 -0500
Content-Disposition: inline
In-Reply-To: <f95d47890903030858xb398b5fy1aeabb19166e6077@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112126>

On Tue, Mar 03, 2009 at 11:58:42AM -0500, David Copeland wrote:

> The first option worked, insomuch the history of diffs is preserved,
> but the dates are all today.

That's odd. It works fine here. Can you confirm that the correct dates
in the "patches" file (i.e., the output of format-patch)? What are you
using to look at the patches? Note that gitk will show you both the
"committer" and the "author" fields. The "author" field should have the
original author and time of the patch, but the "committer" will be you,
today.

> The second option was a little over my head; is the idea there that
> you are setting up a branch that has ONLY the files I care about (with
> all their history), and then I pull from the other repo as if they are
> related?  That seems like it might preserve the dates...

Yes, that is exactly what is happening in the second example.

-Peff
