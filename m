From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] Support cvs via git-shell
Date: Wed, 10 Oct 2007 21:10:25 +0200
Message-ID: <20071010191025.GJ31659@planck.djpig.de>
References: <200710051453.47622.wielemak@science.uva.nl> <Pine.LNX.4.64.0710091531360.4174@racer.site> <20071009223538.GG31659@planck.djpig.de> <Pine.LNX.4.64.0710101427160.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, hjemli@gmail.com,
	Jan Wielemaker <wielemak@science.uva.nl>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 10 21:10:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfgxB-0004SE-Qx
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 21:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139AbXJJTKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 15:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752089AbXJJTKg
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 15:10:36 -0400
Received: from planck.djpig.de ([85.10.192.180]:3120 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752031AbXJJTKg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 15:10:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 02A4B88231;
	Wed, 10 Oct 2007 21:10:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5LtCIT-Phsak; Wed, 10 Oct 2007 21:10:25 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id C26A988232; Wed, 10 Oct 2007 21:10:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710101427160.4174@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60528>

On Wed, Oct 10, 2007 at 02:29:00PM +0100, Johannes Schindelin wrote:
> On Wed, 10 Oct 2007, Frank Lichtenheld wrote:
> > On Tue, Oct 09, 2007 at 03:33:25PM +0100, Johannes Schindelin wrote:
> > >  static struct commands {
> > >  	const char *name;
> > >  	int (*exec)(const char *me, char *arg);
> > >  } cmd_list[] = {
> > >  	{ "git-receive-pack", do_generic_cmd },
> > >  	{ "git-upload-pack", do_generic_cmd },
> > > +	{ "cvs", do_cvs_cmd },
> > >  	{ NULL },
> > 
> > Maybe this should also allow git-cvsserver for completeness' sake?
> 
> Umm.  Why?

Symmetry? ;)
The "for completeness' sake" was as good a reason as I could think of.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
