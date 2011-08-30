From: Raphael Zimmerer <killekulla@rdrz.de>
Subject: Re: [PATCH] stash: Don't paginate by default with list command
Date: Tue, 30 Aug 2011 19:57:48 +0200
Message-ID: <20110830175748.GA19715@rdrz.de>
References: <4e5d1e5c.438d9c87.bm000@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ingo =?iso-8859-1?Q?Br=FCckl?= <ib@wupperonline.de>
X-From: git-owner@vger.kernel.org Tue Aug 30 20:04:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QySfr-0001up-Uw
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 20:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755912Ab1H3SEb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Aug 2011 14:04:31 -0400
Received: from rdrz.de ([217.160.107.209]:51852 "HELO rdrz.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753849Ab1H3SEa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 14:04:30 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Aug 2011 14:04:30 EDT
Received: (qmail 31329 invoked by uid 1009); 30 Aug 2011 17:57:48 -0000
Content-Disposition: inline
In-Reply-To: <4e5d1e5c.438d9c87.bm000@wupperonline.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180428>

On Tue, Aug 30, 2011 at 07:21:18PM +0200, Ingo Br=FCckl wrote:
> The output of "stash list" is such that piping into a pager
> normally isn't necessary but annoying, so disable it by default.

Why is the current behaviour annoying?

Here on my (default) setup the pager automatically exits if the entire
output can be displayed on the screen, as with any other git
command. Is there any chance you have set the LESS environment
variable somewhere? To disable the pager for some commands, cou can
have a look at the *.pager config variables (man git-confg). However,
'pager.stash' is not recognized... The 'alias.*' config variables may
be interesting, too.

Raphael
