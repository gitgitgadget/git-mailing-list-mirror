From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] checkpatch: Add test for commit id formatting style in
 commit log
Date: Sun, 10 Aug 2014 14:35:00 -0700
Message-ID: <20140810143500.2d556ae9.akpm@linux-foundation.org>
References: <20140702130210.fd40d67f0819cfb5f3e9e5ca@linux-foundation.org>
	<1404331746.14624.95.camel@joe-AO725>
	<20140702131534.c613f55f79519b3862f79e40@linux-foundation.org>
	<1404338448.14741.8.camel@joe-AO725>
	<CAMuHMdV1TXLmuAofwrUuT-KKUfkEYdXsM34VRrfhB6FxXfdeeg@mail.gmail.com>
	<1407706081.4082.21.camel@joe-AO725>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
To: Joe Perches <joe@perches.com>
X-From: linux-kernel-owner@vger.kernel.org Sun Aug 10 23:33:33 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1XGak8-0002jO-Rw
	for glk-linux-kernel-3@plane.gmane.org; Sun, 10 Aug 2014 23:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbaHJVdW (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 10 Aug 2014 17:33:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45188 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbaHJVdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2014 17:33:20 -0400
Received: from localhost (c-67-161-9-76.hsd1.ca.comcast.net [67.161.9.76])
	by mail.linuxfoundation.org (Postfix) with ESMTPSA id 04EED523;
	Sun, 10 Aug 2014 21:33:19 +0000 (UTC)
In-Reply-To: <1407706081.4082.21.camel@joe-AO725>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.18.9; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255107>

On Sun, 10 Aug 2014 14:28:01 -0700 Joe Perches <joe@perches.com> wrote:

> > On Thu, Jul 3, 2014 at 12:00 AM, Joe Perches <joe@perches.com> wrote:
> > > Commit logs have various forms of commit id references.
> > >
> > > Try to standardize on a 12 character long lower case
> > > commit id along with a description of parentheses and
> > > the quoted subject line
> > >
> > > ie: commit 0123456789ab ("commit description")
> > 
> > Now this is in mainline, checkpatch starts complaining about my "too long"
> > (40 chars) commit IDs in commit messages :-(
> > 
> > 40 chars may be too long (but it's quick to copy-and-paste, as "git show"
> > shows that by default), but 12 sounds a bit short, as that's only 48 bits.
> 
> Right now, this test allows 12 to 16 byte length commit ids
> without emitting a warning.
> 
> Andrew wanted this test, I don't care how long the commit id
> is in the commit log.

Well, I mainly wanted to stop having to add "commit description" when
people forget it.  The length check was perhaps a bit anal.  How about
we make it "12 or more"?
