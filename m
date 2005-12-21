From: Pavel Roskin <proski@gnu.org>
Subject: Re: Random notes about qgit
Date: Wed, 21 Dec 2005 11:22:36 -0500
Message-ID: <1135182156.5602.15.camel@dv>
References: <1135133300.3202.6.camel@dv>
	 <e5bfff550512210417p1d363017p9d08e3c55fc841d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 21 17:25:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ep6kA-0005TE-Dp
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 17:23:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbVLUQW5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 11:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbVLUQW5
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 11:22:57 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:8580 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932455AbVLUQW4
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 11:22:56 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Ep6hq-0001Pc-3h
	for git@vger.kernel.org; Wed, 21 Dec 2005 11:20:46 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1Ep6jc-0000A4-67; Wed, 21 Dec 2005 11:22:36 -0500
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550512210417p1d363017p9d08e3c55fc841d5@mail.gmail.com>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13877>

On Wed, 2005-12-21 at 13:17 +0100, Marco Costalba wrote:
> On 12/21/05, Pavel Roskin <proski@gnu.org> wrote:
> 
> > Thanks for making the range dialog optional, but now I don't see any way
> > to see the local changes unless I re-enable the dialog.  I think it
> > should be an action activated from the menu - "diff local files to this
> > revision".  Or maybe the "local" radio button in the diff pane.
> >
> 
> Actually you could re-enable working dir diffs from
> menu->edit->settings->'git index'

Indeed.  Thank you!

> Do you think is too hidden?

It shouldn't be an option.  It should be an action, available on demand,
regardless of options.  In the majority of cases, only diff to the head
revision is needed, but some users may want to see diff against other
revisions, e.g. when verifying manual merge.

Maybe there should be an option to check the local diff on startup and
indicate it somehow (not necessarily in the revision list) if it's not
empty.

But I'm not a GUI expert and I don't know how to make it easy to
discover without being constantly in the way.

> > Current qgit seems to have another crash, also annotation related.  Run
> > qgit on its own repository.  Select "Add range select dialog options",
> > then double click on src/commitimpl.cpp in the file list.  Sometimes it
> > works, sometimes it crashes like this:
> >
> > ASSERT getFileAnnotation: no revision
> > 9771bea705024b3d0a59e1b9144adf5d77ca82d1
> 
> I cannot reproduce the bug but please Pavel, add qDebug() lines
> in git.cpp as following:

OK, this will be a in separate thread.

> > "View->Revision Diff" and "View->Archive Tree" work differently.  The
> > former doesn't allow to turn the pane off.  I'd like it to work like
> > "View->Archive Tree".  Neither can "Revision Diff" be closed from the
> > popup menu.
> >
> 
> Yes, "View->Revision Diff" should be a toggle action.  ;-)

OK

-- 
Regards,
Pavel Roskin
