From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/2] Make generated MSVC solution file open from
	Windows Explorer
Date: Sat, 26 Sep 2009 13:05:29 -0700
Message-ID: <20090926200529.GJ14660@spearce.org>
References: <4ABB84F4.7080403@gmail.com> <20090925220510.GY14660@spearce.org> <bdca99240909251541h2e9932a3r67c1d8604e56a8df@mail.gmail.com> <20090925225940.GB14660@spearce.org> <bdca99240909251658q395a62b6r8d5998382ac3fc7b@mail.gmail.com> <20090926000500.GE14660@spearce.org> <bdca99240909260245i6ba10dd4j1b2ee9e74ea5282d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mstormo@gmail.com
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 26 22:06:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrdWS-0000bv-HU
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 22:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578AbZIZUF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 16:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752519AbZIZUF0
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 16:05:26 -0400
Received: from george.spearce.org ([209.20.77.23]:45297 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511AbZIZUF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 16:05:26 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 05395381FF; Sat, 26 Sep 2009 20:05:30 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <bdca99240909260245i6ba10dd4j1b2ee9e74ea5282d@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129174>

Sebastian Schuberth <sschuberth@gmail.com> wrote:
> On Sat, Sep 26, 2009 at 02:05, Shawn O. Pearce <spearce@spearce.org> wrote:
> > Odd. ??If I copy and paste from Thunderbird, its fine. ??But if I
> > save the body out as an attachment from mutt, it fails.
> >
> > I wonder if it has to do with the From header appearing in the top
> > of the body; this header has to be escaped with a leading space in
> > mbox format. ??It looks like Thunderbird might be doing some magic to
> > remove that leading space from the context lines, while mutt isn't.
> >
> > Next time, don't include the first From line?
> 
> Will try. So what about these two patches? Should I re-send them with
> the first "From" stripped?

Might be worth trying.  I honestly don't know why they were munged
before.
 
> Or will *.patch files that are attached to emails, instead of sending
> the patch inline, be accepted?

We really don't like them, because you can't comment on them inline
easily.  Sometimes they are acceptable for translation files when
the character encoding otherwise gets really broken.

-- 
Shawn.
