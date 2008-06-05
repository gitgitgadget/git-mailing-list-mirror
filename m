From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-fast-export: Add importing and exporting of
 revision marks
Date: Thu, 5 Jun 2008 14:31:18 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806051429300.21190@racer>
References: <1212612947-34720-1-git-send-email-pdebie@ai.rug.nl> <alpine.DEB.1.00.0806050052390.21190@racer> <BEF1F17D-6F0F-4F09-9CC4-B193B8907901@ai.rug.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailinglist <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Thu Jun 05 15:33:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Fb1-0006Eu-Bs
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 15:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754811AbYFENcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 09:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754760AbYFENcl
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 09:32:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:36143 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754673AbYFENck (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 09:32:40 -0400
Received: (qmail invoked by alias); 05 Jun 2008 13:32:38 -0000
Received: from unknown (EHLO racer.local) [128.177.17.254]
  by mail.gmx.net (mp038) with SMTP; 05 Jun 2008 15:32:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+HfKEHze+HTKJ/v2CbsSPBj6LNW/vbO+suk1yTyz
	rDvTprgvzqO+C8
X-X-Sender: gene099@racer
In-Reply-To: <BEF1F17D-6F0F-4F09-9CC4-B193B8907901@ai.rug.nl>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83928>

Hi,

On Thu, 5 Jun 2008, Pieter de Bie wrote:

> On 5 jun 2008, at 02:00, Johannes Schindelin wrote:
> 
> >Is "- (uint32_t *)NULL" needed?
> 
> I changed the uintmax_t to to a uint32_t. If I remove the "- (uint32_t
> *)NULL", it won't return the same marks. The same is done in 
>  get_object_mark().

Ah, I missed that again.  I think I had exactly the same issue (of not 
understanding) with another patch for the same area of the code.

Maybe it would be worth having two functions to describe what is done 
there, for documentation purposes?

> I will send an updated patch.

Thanks,
Dscho
