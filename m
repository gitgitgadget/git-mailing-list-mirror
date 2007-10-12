From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH drop] git-config: respect other options after -l, most notably --file
Date: Fri, 12 Oct 2007 11:37:41 +0000
Message-ID: <20071012113741.30469.qmail@a4342ff4e2e64a.315fe32.mid.smarden.org>
References: <20071009125024.1259.qmail@d8e601127fe8d0.315fe32.mid.smarden.org> <20071009224943.GH31659@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Fri Oct 12 13:37:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgIpf-00087V-74
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 13:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753654AbXJLLhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 07:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753671AbXJLLhW
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 07:37:22 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:47805 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753645AbXJLLhV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 07:37:21 -0400
Received: (qmail 30470 invoked by uid 1000); 12 Oct 2007 11:37:41 -0000
Content-Disposition: inline
In-Reply-To: <20071009224943.GH31659@planck.djpig.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60678>

On Wed, Oct 10, 2007 at 12:49:43AM +0200, Frank Lichtenheld wrote:
> On Tue, Oct 09, 2007 at 12:50:24PM +0000, Gerrit Pape wrote:
> > When git-commit is seeing the -l|--list option, it stops reading the
> > following command line options.  So although they should be the same,
> > the following commands act differently:
> > 
> >  git config --file ../repo2/.git/config -l
> >  git config -l --file ../repo2/.git/config
> > 
> > This patch delays the 'list all variables' to after the command line
> > options have been processed.
> 
> Note that I have posted a conflicting patch for the same problem some
> days ago. I think my patch is more consistent with the behaviour for
> other options.

Fair enough.  Regards, Gerrit.
