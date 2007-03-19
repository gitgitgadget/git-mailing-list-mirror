From: John Goerzen <jgoerzen@complete.org>
Subject: Rename handling
Date: Mon, 19 Mar 2007 11:10:25 -0500
Message-ID: <slrnevtdfh.v0v.jgoerzen@katherina.lan.complete.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 17:36:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTKpz-0003kH-2E
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 17:35:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbXCSQfO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 12:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030357AbXCSQfN
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 12:35:13 -0400
Received: from main.gmane.org ([80.91.229.2]:52496 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030283AbXCSQfL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 12:35:11 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HTKp4-0006K1-9k
	for git@vger.kernel.org; Mon, 19 Mar 2007 17:35:02 +0100
Received: from 63.245.179.205 ([63.245.179.205])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Mar 2007 17:35:02 +0100
Received: from jgoerzen by 63.245.179.205 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Mar 2007 17:35:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 63.245.179.205
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42639>

Hi,

I've read the FAQ and Linus' philosophy on this topic, and have some
questions still.  I'm considering using Git and its philosophy on
renames is troubling me.

My use for version control presently has most changes being written and
committed by me directly, with occasional patches coming in from random
others.  As such, running something like 'git mv' when a rename occurs
is not a problem.

My main concerns with Git are:

1) git log does not show complete history of files that have been
   renamed or copied.

   If I have foo.txt, and rename it to bar.txt, the liberal use of -M
   can tease out a proper patch from a number of places.  But
   git log bar.txt, with any set of options I can possibly come up with,
   absolutely refuses to show me the history of bar.txt before it was
   renamed to bar.txt.  git log foo.txt also does not show me the old
   history for the file.

2) For me, a rename is a logical change to the source tree that I want
   to be recorded with absolute certainty, not guessed about later.
   Sometimes I may make API changes and it is useful to see how module
   names changed, with complete precision, later.  I do not want to be
   victim to an incorrect guess, which could be possible.

Is there any way to resolve this with Git, or do I basically have to
stick with Mercurial here?

-- John
