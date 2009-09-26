From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/2] Make generated MSVC solution file open from
	Windows Explorer
Date: Fri, 25 Sep 2009 17:05:00 -0700
Message-ID: <20090926000500.GE14660@spearce.org>
References: <4ABB84F4.7080403@gmail.com> <20090925220510.GY14660@spearce.org> <bdca99240909251541h2e9932a3r67c1d8604e56a8df@mail.gmail.com> <20090925225940.GB14660@spearce.org> <bdca99240909251658q395a62b6r8d5998382ac3fc7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mstormo@gmail.com
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 26 02:07:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrKp7-0001bz-E8
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 02:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbZIZAE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 20:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752114AbZIZAE5
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 20:04:57 -0400
Received: from george.spearce.org ([209.20.77.23]:46939 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803AbZIZAE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 20:04:57 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id E9F5638151; Sat, 26 Sep 2009 00:05:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <bdca99240909251658q395a62b6r8d5998382ac3fc7b@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129136>

Sebastian Schuberth <sschuberth@gmail.com> wrote:
> On Sat, Sep 26, 2009 at 00:59, Shawn O. Pearce <spearce@spearce.org> wrote:
> > Sebastian Schuberth <sschuberth@gmail.com> wrote:
> >> On Sat, Sep 26, 2009 at 00:05, Shawn O. Pearce <spearce@spearce.org> wrote:
> >> > Something is wrong with both patches; neither applies.
> >>
> >> Hmm, the patches apply fine onto master for me.
> >
> > After going through your client and the GMane email gateway?
> > Or before you pasted it into the message?
> 
> Both. As a test for the first, I've copied & pasted my mail as it
> appears for me in gmane.comp.version-control.git to a new file and
> successfully applied that file via "git apply". I had to do it this
> way, as on Windows I cannot really use "git am" with Thunderbird.

Odd.  If I copy and paste from Thunderbird, its fine.  But if I
save the body out as an attachment from mutt, it fails.

I wonder if it has to do with the From header appearing in the top
of the body; this header has to be escaped with a leading space in
mbox format.  It looks like Thunderbird might be doing some magic to
remove that leading space from the context lines, while mutt isn't.

Next time, don't include the first From line?

-- 
Shawn.
