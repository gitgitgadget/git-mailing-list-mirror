From: Gerrit Pape <pape@smarden.org>
Subject: Re: git-commit: if run with <file> arguments, include files removed through git rm
Date: Wed, 5 Sep 2007 10:20:34 +0000
Message-ID: <20070905102034.1838.qmail@ffbf01be8bc5db.315fe32.mid.smarden.org>
References: <20070904144304.5920.qmail@42e302a26078dc.315fe32.mid.smarden.org> <7vabs2pgj6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 05 12:34:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISsDA-0005Ln-7E
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 12:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756064AbXIEKeJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 06:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755893AbXIEKeI
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 06:34:08 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:51255 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755702AbXIEKeH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 06:34:07 -0400
Received: (qmail 1839 invoked by uid 1000); 5 Sep 2007 10:20:34 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vabs2pgj6.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57709>

On Tue, Sep 04, 2007 at 09:00:13AM -0700, Junio C Hamano wrote:
> Gerrit Pape <pape@smarden.org> writes:
> > This patch lets it additionally use git ls-tree to look for the files in
> > the HEAD tree, but I guess there's a smarter way to fix this.
> 
> You raised a good issue, but this also needs other parts of the

Thanks for your detailed explanations.

Sebastian Harl actually noticed this unexpected behavior, and reported
through
 http://bugs.debian.org/437817

Regards, Gerrit.
