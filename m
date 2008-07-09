From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: git over rsync+ssh
Date: Wed, 9 Jul 2008 20:17:21 +0300
Message-ID: <20080709171721.GA3679@mithlond.arda.local>
References: <g52gbg$si9$1@ger.gmane.org> <32541b130807090902q2cdc9fcbg6f685dcb96407644@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 19:19:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGdJB-0004Bz-Tz
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 19:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbYGIRR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 13:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbYGIRR1
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 13:17:27 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:55207 "EHLO
	jenni1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750792AbYGIRR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 13:17:27 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni1.rokki.sonera.fi (8.5.014)
        id 483E82F101C0E7EF; Wed, 9 Jul 2008 20:17:22 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1KGdI9-0000yU-9K; Wed, 09 Jul 2008 20:17:21 +0300
Content-Disposition: inline
In-Reply-To: <32541b130807090902q2cdc9fcbg6f685dcb96407644@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87895>

Avery Pennarun wrote (2008-07-09 12:02 -0400):

> I don't know if this will help in your case, but if it will be only
> you pushing to this repository, one option is to simply create a bare
> push repository on your local machine, and then manually just
> rsync+ssh it to the remote machine from the command line as
> a so-called "push" operation.

Again, I don't know if this is helpful for Michael, but this "manual"
rsyncing can be done automatically via hooks/post-receive. Just like
Avery said, "git push" to a bare repository in a local machine and this
bare repo has post-receive hook which does "git update-server-info" and
the rsyncing (or "sitecopy --update" or similar).
