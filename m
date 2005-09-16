From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Should Cogito scripts be renamed?
Date: Fri, 16 Sep 2005 17:40:23 +0200
Message-ID: <200509161740.23685.Josef.Weidendorfer@gmx.de>
References: <20050915234607.GA10867@pasky.or.cz> <E1EG3ku-0005hU-Eb@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Sep 16 17:47:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGIKs-0005MZ-Qz
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 17:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161093AbVIPPk7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 11:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161162AbVIPPk7
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 11:40:59 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:38576 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1161139AbVIPPk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 11:40:58 -0400
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <E1EG3ku-0005hU-Eb@jdl.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8688>

On Friday 16 September 2005 02:07, jdl@freescale.com wrote:
> So, like, the other day Petr asked:
> >  I'd like to hear the opinion of Cogito users about renaming the Cogito
> > commands accordingly to the GIT big renames. This would be:
> >
> >	cg-pull -> cg-fetch
> >	cg-update -> cg-pull
> ...
> As with git, sooner rather than later, please.

Same option here.
The 4-phased renaming could be shortened by letting cg-pull always ask
the following if eg. .git/no-cg-pull-warning does not exist:

 Warning: cg-pull includes merging after fetch since cogito 0.15
          Use cg-fetch to do the fetching phase only
 [To get rid of this warning, run 'touch .git/no-cg-pull-warning']
 Do you want to continue (y/n) [n] ?

Getting rid of this annoying question should be easy enough everybody,
and via the template-system even for git packers...
Even if disabled, I would still do

 Remember: cg-pull includes merging after fetch since cogito 0.15
           Press Ctrl-C in the next 2 seconds to abort.

Josef
