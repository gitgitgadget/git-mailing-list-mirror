From: Gerrit Pape <pape@smarden.org>
Subject: Re: git branch --track and remote branches with / in the name
Date: Tue, 5 Jun 2007 11:35:57 +0000
Message-ID: <20070605113557.5803.qmail@81f254b7954e14.315fe32.mid.smarden.org>
References: <20070605090404.24707.qmail@b58755fd627261.315fe32.mid.smarden.org> <7v4plmd7kg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 13:36:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvXKa-000382-U0
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 13:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbXFELfi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 07:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754300AbXFELfi
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 07:35:38 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:49915 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754234AbXFELfi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 07:35:38 -0400
Received: (qmail 5804 invoked by uid 1000); 5 Jun 2007 11:35:57 -0000
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v4plmd7kg.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49194>

On Tue, Jun 05, 2007 at 03:22:39AM -0700, Junio C Hamano wrote:
> Gerrit Pape <pape@smarden.org> writes:
> > Hi, the --track option to git branch or git checkout doesn't work for
> > remote branches that contain a slash in the name:

> Indeed the "find matching remote tracking branch" code was
> somewhat sloppy and needlessly complex/clever.
> 
> How about this patch?

Works fine for me, including the selftest.  Thanks, Gerrit.
