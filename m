From: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: Re: What's cooking in git.git (Dec 2009, #02; Sat, 05)
Date: Sun, 6 Dec 2009 17:59:06 +0200 (EET)
Message-ID: <alpine.DEB.2.00.0912061738580.5582@cone.home.martin.st>
References: <7vpr6siki5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, rctay89@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 06 16:59:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHJWS-0004jZ-4w
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 16:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754384AbZLFP7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 10:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754039AbZLFP7W
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 10:59:22 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:57248 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753781AbZLFP7W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 10:59:22 -0500
Received: from [88.193.196.75] (88.193.196.75) by kirsi2.inet.fi (8.5.014)
        id 4B17EFA600233021; Sun, 6 Dec 2009 17:59:19 +0200
X-X-Sender: martin@cone.home.martin.st
In-Reply-To: <7vpr6siki5.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134667>

On Sun, 6 Dec 2009, Junio C Hamano wrote:

> [Cooking]
> 
> * tr/http-updates (2009-12-01) 3 commits
>  - Allow curl to rewind the RPC read buffer
>  - Add an option for using any HTTP authentication scheme, not only basic
>  - http: maintain curl sessions
> 
> There was a discussion on a better structure not to require rewinding in
> the first place?  I didn't follow it closely...

I think the conclusion is: Rewinding support isn't strictly necessary, 
there's a number of mechanisms in both git and curl that should make sure 
that those cases shouldn't surface. A few of them in curl have an 
unfortunate conincidence of bugs up until the latest version, though, 
leaving much fewer mechanisms in place to avoid this.

Since that patch is quite non-intrusive I think it's a good safeguard, 
though. What do you think, Tay, keep it or leave it?

// Martin
