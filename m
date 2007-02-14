From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: Newbie experience with push over ssh
Date: Wed, 14 Feb 2007 18:52:19 +0100
Message-ID: <20070214175219.GA7082@moooo.ath.cx>
References: <vpq64a4bzp1.fsf@olympe.imag.fr> <20070214142731.GA1478@moooo.ath.cx> <45D33485.5020906@webdrake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joseph Wakeling <joseph.wakeling@webdrake.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 18:52:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHOJ1-0005kh-E6
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 18:52:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbXBNRw2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 12:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbXBNRw2
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 12:52:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:51851 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932289AbXBNRw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 12:52:27 -0500
Received: (qmail invoked by alias); 14 Feb 2007 17:52:26 -0000
X-Provags-ID: V01U2FsdGVkX19toXE9gTttebV3w0avHDUGgKeZTFj3slW7r7XGRP
	hGnA==
Mail-Followup-To: Joseph Wakeling <joseph.wakeling@webdrake.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <45D33485.5020906@webdrake.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39705>

Joseph Wakeling <joseph.wakeling@webdrake.net> wrote:
> I remember coming across the same issue as Matthieu and never got round
> to solving it.  In my case the desire is to upload the code onto a
> remote machine---in particular a cluster where I run simulations.  I
> don't particularly need that remote code to be in a repo or otherwise,
> since it's only there to be run, not edited.

git archive --format=tar HEAD | ssh remote 'cd /some/where;tar xvf -'

You could put this in a shell script which takes the remote hostname,
path and optionally the revision to send..
