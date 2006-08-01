From: Olivier Galibert <galibert@pobox.com>
Subject: Re: path-restricted gitk with tags showing up?
Date: Tue, 1 Aug 2006 21:33:37 +0200
Message-ID: <20060801193337.GA93307@dspnet.fr.eu.org>
References: <20060801174210.GA81699@dspnet.fr.eu.org> <20060801231329.82d934a2.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 01 21:34:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7zzq-0006o6-J4
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 21:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWHATdj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 15:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751846AbWHATdj
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 15:33:39 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:46596 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751027AbWHATdi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Aug 2006 15:33:38 -0400
Received: by dspnet.fr.eu.org (Postfix, from userid 1007)
	id AC9C6A48D6; Tue,  1 Aug 2006 21:33:37 +0200 (CEST)
To: Sergey Vlasov <vsu@altlinux.ru>
Content-Disposition: inline
In-Reply-To: <20060801231329.82d934a2.vsu@altlinux.ru>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24609>

On Tue, Aug 01, 2006 at 11:13:29PM +0400, Sergey Vlasov wrote:
> On Tue, 1 Aug 2006 19:42:10 +0200 Olivier Galibert wrote:
> 
> > I'd like to do a (f.i) gitk include/sound/asound.h but still see the
> > commits which are in the DAG delimited by the alsa commits and have
> > tags attached.  The aim is to know what changes where in what released
> > kernel version.  Is there a way to do that?
> 
> Since git-1.4.0 gitk shows this information in the "Follows:" and
> "Precedes:" lines for each commit (you need to enable "Display nearby
> tags" in preferences).  In your case, the "Precedes" line will show the
> first kernel version which included the change.
> 
> Note that loading this information takes some time; gitk tries to load
> it in background, so you may see empty "Follows" and "Precedes" lines
> for some time.

Works rather well, thanks.

  OG.
