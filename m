From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH v2 12/16] Smart fetch and push over HTTP: server
	side
Date: Tue, 13 Oct 2009 11:24:27 -0700
Message-ID: <20091013182427.GA9261@spearce.org>
References: <1255400715-10508-1-git-send-email-spearce@spearce.org> <1255400715-10508-13-git-send-email-spearce@spearce.org> <4AD42C87.6000205@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 13 20:42:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxmJs-0007GK-AZ
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 20:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760913AbZJMSZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 14:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760908AbZJMSZE
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 14:25:04 -0400
Received: from george.spearce.org ([209.20.77.23]:50312 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760154AbZJMSZD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 14:25:03 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 77CC9381FE; Tue, 13 Oct 2009 18:24:27 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4AD42C87.6000205@viscovery.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130180>

Johannes Sixt <j.sixt@viscovery.net> wrote:
> Shawn O. Pearce schrieb:
> > diff --git a/http-backend.c b/http-backend.c
> 
> #include "run-command.h" is missing here because you added it already in
> patch 10/16 unnecessarily.
> 
> > +	if (start_command(&cld))
> > +		die_errno("Cannot start %s", argv[0]);
> > ...
> > +	if (finish_command(&cld))
> > +		die("%s terminated with error", argv[0]);
> 
> start_command and finish_command already write an error message for you
> that includes argv[0] and errno. You can just exit(1) here.

Whoops on both; thanks for the catch.

-- 
Shawn.
