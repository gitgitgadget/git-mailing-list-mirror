From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: Re: [PATCH 0/2] user-manual: reorganize the configuration steps
Date: Tue, 13 Oct 2009 22:49:40 -0400
Message-ID: <20091014024940.GB9700@fieldses.org>
References: <1255293786-17293-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 04:51:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxtxx-0001U4-Ue
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 04:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760140AbZJNCt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 22:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759333AbZJNCt2
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 22:49:28 -0400
Received: from fieldses.org ([174.143.236.118]:51494 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754841AbZJNCt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 22:49:28 -0400
Received: from bfields by fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1Mxtvo-0002cx-59; Tue, 13 Oct 2009 22:49:40 -0400
Content-Disposition: inline
In-Reply-To: <1255293786-17293-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130236>

On Sun, Oct 11, 2009 at 11:43:04PM +0300, Felipe Contreras wrote:
> This basically introduces the "getting started" section so users get familiar
> with the configuration from the get-go, and also, most people prefer to teach
> 'git config --global' to setup the user name and email. Here are a few
> examples:

I'm not personally a big fan of starting out with a "how to use
git-config" section, because it's not that difficult or important:
questions we get on this list suggest confusion about a lot of things,
but git configuration is rarely one of them (that I've noticed).

I'd rather just point people to the git-config man page the first time
we mention any git configuration.  (And improve the man page if
necessary to ensure it's up to the job.)

If we have to do this, just keep it short....

--b.

> 
> git tutorial:
> http://www.kernel.org/pub/software/scm/git/docs/gittutorial.html
> 
> GNOME:
> http://live.gnome.org/Git/Developers
> 
> SourceForge:
> http://sourceforge.net/apps/trac/sourceforge/wiki/Git
> 
> github:
> http://help.github.com/git-email-settings/
> 
> Felipe Contreras (2):
>   user-manual: add global config section
>   user-manual: simplify the user configuration
> 
>  Documentation/user-manual.txt |   35 ++++++++++++++++++++++++++++++-----
>  1 files changed, 30 insertions(+), 5 deletions(-)
> 
