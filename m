From: Daniel Barkalow <barkalow@iabervon.org>
Subject: git clone -l
Date: Tue, 4 Mar 2008 19:03:38 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803041900080.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 05 01:04:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWh7S-0000Aj-TD
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 01:04:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933081AbYCEADl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 19:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932571AbYCEADk
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 19:03:40 -0500
Received: from iabervon.org ([66.92.72.58]:41884 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765036AbYCEADj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 19:03:39 -0500
Received: (qmail 24847 invoked by uid 1000); 5 Mar 2008 00:03:38 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Mar 2008 00:03:38 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76157>

What, exactly, is -l supposed to do for clone? As far as I can tell, we 
automatically do the local magic if we can. Would it be okay to make 
"local" default to "if possible", have "-l" mean error if not possible, 
and have "--no-local" able to avoid using local magic even if we could use 
it?

	-Daniel
*This .sig left intentionally blank*
