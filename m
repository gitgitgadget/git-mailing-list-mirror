From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Support tags in uncommit - use git_id instead of
	rev_parse
Date: Tue, 02 Oct 2007 18:03:11 -0400
Message-ID: <1191362591.26879.3.camel@dv>
References: <20070930172647.18972.49369.stgit@tt.roinet.com>
	 <b0943d9e0710011500o1bd621a4q10dfe0468c8795e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 00:03:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icpq3-0002qv-Iy
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 00:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612AbXJBWD1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 18:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753498AbXJBWD1
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 18:03:27 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:60945 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbXJBWD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 18:03:26 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1Icpp5-0008Vu-6p
	for git@vger.kernel.org; Tue, 02 Oct 2007 18:02:35 -0400
Received: from proski by gnu.org with local (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1Icppg-0007OF-5i; Tue, 02 Oct 2007 18:03:12 -0400
In-Reply-To: <b0943d9e0710011500o1bd621a4q10dfe0468c8795e2@mail.gmail.com>
X-Mailer: Evolution 2.10.3 (2.10.3-4.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59746>

On Mon, 2007-10-01 at 23:00 +0100, Catalin Marinas wrote:
> On 30/09/2007, Pavel Roskin <proski@gnu.org> wrote:
> > Signed-off-by: Pavel Roskin <proski@gnu.org>
> 
> With this patch, uncommit can take patch names (with modifiers) as the
> --to argument. When would this be needed?

Probably never.

> To allow tags, maybe just pass something like
> "git.rev_parse(options.to + '^{commit}')" or just modify git.rev_parse
> to do it (and git_id to avoid it).

I prefer to work with software that understands what I mean and tells me
that I cannot do it.  It makes it easier to understand what is possible
and how the command is working.

Recognizing patch names in some commands but not others would be
annoying and inconsistent.  Dumbing downs interactive software on
purpose is probably not worth the trouble.

-- 
Regards,
Pavel Roskin
