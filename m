From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 8/6] Teach directory traversal about subprojects
Date: Wed, 11 Apr 2007 18:53:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704111853050.4061@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704111439210.6730@woody.linux-foundation.org>
 <7vfy76mn4d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 12 03:53:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HboVE-0002Gt-Dw
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 03:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161459AbXDLBxd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 21:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161461AbXDLBxd
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 21:53:33 -0400
Received: from smtp.osdl.org ([65.172.181.24]:41668 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161459AbXDLBxd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 21:53:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3C1rTVZ030215
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 11 Apr 2007 18:53:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3C1rSmY020230;
	Wed, 11 Apr 2007 18:53:28 -0700
In-Reply-To: <7vfy76mn4d.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.957 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44305>



On Wed, 11 Apr 2007, Junio C Hamano wrote:
> > diff --git a/dir.h b/dir.h
> > index 33c31f2..1931609 100644
> > --- a/dir.h
> > +++ b/dir.h
> > @@ -33,7 +33,8 @@ struct dir_struct {
> >  	int nr, alloc;
> >  	unsigned int show_ignored:1,
> >  		     show_other_directories:1,
> > -		     hide_empty_directories:1;
> > +		     hide_empty_directories:1,
> > +		     no_dirlinks;
> >  	struct dir_entry **entries;
> >  
> >  	/* Exclude info */
> 
> Did you mean a bitfield here?

I did indeed. Please fix.

		Linus
