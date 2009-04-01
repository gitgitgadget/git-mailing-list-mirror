From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: On git 1.6 (novice's opinion)
Date: Wed, 1 Apr 2009 22:37:30 +0200
Message-ID: <20090401203730.GB90837@macbook.lan>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de> <49D339B2.4388.6B1DEF@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de> <49D327C4.7000101@op5.se> <49D35454.12423.D32681@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, Russ Dill <russ.dill@gmail.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Wed Apr 01 22:39:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp7DL-0007bC-Fq
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 22:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763014AbZDAUhh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 16:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760921AbZDAUhg
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 16:37:36 -0400
Received: from darksea.de ([83.133.111.250]:43324 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757188AbZDAUhf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 16:37:35 -0400
Received: (qmail 16864 invoked from network); 1 Apr 2009 22:37:18 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 1 Apr 2009 22:37:18 +0200
Content-Disposition: inline
In-Reply-To: <49D35454.12423.D32681@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115414>

On Wed, Apr 01, 2009 at 11:47:31AM +0200, Ulrich Windl wrote:
> So I really don't see that relying on file dates is much better than
> doing a full rebuild. That's specifically true if you pull a new tree:
> If I understand things right, EVERY file will have a current date, so
> you'll rebuild everything anyway. So you could also have the "real
> file dates" and then do "make clean; make all". I see no benefit from
> either approach.

I am not sure if you understand it right. When switching branches git
will only touch the files that have changed between your old and your
new tree. make will then only build those files that are actually
different between those two trees because they have been given a newer
date than their target files. All other files in your working copy will
not be touched.

cheers Heiko
