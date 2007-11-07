From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git rebase --skip
Date: Wed, 7 Nov 2007 22:48:39 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711072244180.4362@racer.site>
References: <20071107222105.GA31666@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Nov 07 23:49:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipthi-0005AV-My
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 23:48:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbXKGWso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 17:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752663AbXKGWso
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 17:48:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:34685 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751023AbXKGWsn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 17:48:43 -0500
Received: (qmail invoked by alias); 07 Nov 2007 22:48:41 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp040) with SMTP; 07 Nov 2007 23:48:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Ej55J/JFEB9cJuOF4WXVthdCduVryLX+/+ZmDRE
	UtjSXK5mol/ZGs
X-X-Sender: gene099@racer.site
In-Reply-To: <20071107222105.GA31666@glandium.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63883>

Hi,

On Wed, 7 Nov 2007, Mike Hommey wrote:

> I use git-rebase quite regularly, and I haven't used git-rebase --skip 
> after a failed merge without first resetting the working tree. I was 
> wondering if it wouldn't make sense to automatically do the reset when 
> running git-rebase --skip.

Makes sense to me.  The user is already required to pass "--skip" to say 
"scrap this patch".

FWIW --interactive already has this behaviour since it was added to 
"official" git.

Ciao,
Dscho
