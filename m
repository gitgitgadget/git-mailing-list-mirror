From: Joseph Wakeling <joseph.wakeling@webdrake.net>
Subject: Re: Newbie experience with push over ssh
Date: Wed, 14 Feb 2007 16:10:45 +0000
Message-ID: <45D33485.5020906@webdrake.net>
References: <vpq64a4bzp1.fsf@olympe.imag.fr> <20070214142731.GA1478@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 14 17:20:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHMrd-0007xh-N5
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 17:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbXBNQUK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 11:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbXBNQUJ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 11:20:09 -0500
Received: from alf.nbi.dk ([130.225.212.55]:4867 "EHLO alf.nbi.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932356AbXBNQUI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 11:20:08 -0500
X-Greylist: delayed 557 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Feb 2007 11:20:08 EST
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by alf.nbi.dk (8.9.3/8.9.3) with ESMTP id RAA31367
	for <git@vger.kernel.org>; Wed, 14 Feb 2007 17:10:45 +0100 (MET)
User-Agent: Thunderbird 1.5.0.9 (X11/20070103)
In-Reply-To: <20070214142731.GA1478@moooo.ath.cx>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39665>

Matthias Lederhofer wrote:
> I don't think there is any way to 'clone to remote'.  You'd have to
> ssh to the other machine and clone from there, or you can just create
> an empty repository on the remote host and push the stuff into it.

I remember coming across the same issue as Matthieu and never got round
to solving it.  In my case the desire is to upload the code onto a
remote machine---in particular a cluster where I run simulations.  I
don't particularly need that remote code to be in a repo or otherwise,
since it's only there to be run, not edited.

As far as I know I have no way of installing git on that machine.
Perhaps I could install it locally but I suspect the sysadmin would not
be supportive.

So, is there a way of using git to upload my code to a machine without a
repo ready-prepared?
