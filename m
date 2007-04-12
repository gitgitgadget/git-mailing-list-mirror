From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: rcs import?
Date: Thu, 12 Apr 2007 08:21:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704120812000.4061@woody.linux-foundation.org>
References: <m3r6qpdfhx.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: James Cloos <cloos@jhcloos.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 17:21:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hc17A-0001TG-9R
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 17:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992551AbXDLPVU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 11:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992557AbXDLPVU
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 11:21:20 -0400
Received: from smtp.osdl.org ([65.172.181.24]:46248 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992551AbXDLPVT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 11:21:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3CFLBIs014761
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 12 Apr 2007 08:21:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3CFLAjW002229;
	Thu, 12 Apr 2007 08:21:11 -0700
In-Reply-To: <m3r6qpdfhx.fsf@lugabout.jhcloos.org>
X-Spam-Status: No, hits=-0.457 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44342>



On Thu, 12 Apr 2007, James Cloos wrote:
>
> Has anyone written import support for rcs repos?
> 
> (I've a few config hierarchies using RCS I'd like to convert.)

Just migrate to CVS first, and then use "git cvsimport".

CVS obviously *uses* RCS as the individual file format, so migrating a set 
of RCS files to CVS really is pretty damn trivial. It's basically just 
copying the RCS *,v files over to the appropriate CVSROOT directory 
structure and adding some Entries files. I think CVS even comes with a 
"rcs-to-cvs" conversion script.

Yeah, just checked: google for "rcs-to-cvs.sh"

(I don't know how well it works, but I can't imagine that it won't do a 
good job. CVS really largely is "RCS with some scripts around it")

		Linus
