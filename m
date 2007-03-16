From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] user-manual: ensure generated manual references stylesheet
Date: Fri, 16 Mar 2007 11:36:39 -0400
Message-ID: <20070316153639.GH31722@fieldses.org>
References: <1173045556191-git-send-email-bfields@citi.umich.edu> <11730455574115-git-send-email-bfields@citi.umich.edu> <1173045558959-git-send-email-bfields@citi.umich.edu> <11730455591178-git-send-email-bfields@citi.umich.edu> <loom.20070316T134149-54@post.gmane.org> <20070316142431.GE31722@fieldses.org> <7C0AC446-57CA-480B-A14E-1E861E2FCBA7@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Pluim <rpluim+git@gmail.com>, git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Fri Mar 16 16:36:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSEU1-00042v-Rb
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 16:36:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753544AbXCPPgn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 11:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753547AbXCPPgn
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 11:36:43 -0400
Received: from mail.fieldses.org ([66.93.2.214]:58564 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753544AbXCPPgm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 11:36:42 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HSETv-0006XI-V8; Fri, 16 Mar 2007 11:36:39 -0400
Content-Disposition: inline
In-Reply-To: <7C0AC446-57CA-480B-A14E-1E861E2FCBA7@silverinsanity.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42366>

On Fri, Mar 16, 2007 at 11:01:47AM -0400, Brian Gernhardt wrote:
> I remember running into huge issues with docbook and xmlto under  
> either Fink or MacPorts because it was still looking in /etc/xml/ 
> catalog.  IIRC, the --nonet flag disables network access but not  
> having it does not mean that you will access the network.  What  
> happens is that on machines with the xsl files installed, it will use  
> the local copy either way (via /etc/xml/catalog), but if you don't it  
> will go to the actual URL (which will die with --nonet).

Oh, OK, thanks for pointing that out.  So I agree then that --nonet
doesn't make sense.

> I  personally don't see a reason to use --nonet for everyone.  If a
> particular user doesn't want xsltproc hitting the 'net then they can
> use that option, but there's no reason to break the build for people
> who don't care.  Providing a user-configurable variable to pass
> options to xsltproc is probably a good idea anyway. (XSLTFLAGS,
> maybe?)

Eh, it doesn't sound like there's a real need for it for --nonet.  Is
there some other reason to do that?

--b.
