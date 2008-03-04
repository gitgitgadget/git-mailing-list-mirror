From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] remote: fix "update [group...]"
Date: Tue, 4 Mar 2008 02:09:14 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803040208060.22527@racer.site>
References: <alpine.LSU.1.00.0803040029440.22527@racer.site> <7v4pbne013.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 03:10:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWMc6-0000pr-Ms
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 03:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240AbYCDCKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 21:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752271AbYCDCKE
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 21:10:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:44742 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752240AbYCDCKD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 21:10:03 -0500
Received: (qmail invoked by alias); 04 Mar 2008 02:10:00 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp011) with SMTP; 04 Mar 2008 03:10:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18wOdlmt1cwaaRfIHgIB+u+nw6ASvmayqz9kz3XUh
	lI28ratvtzXlQs
X-X-Sender: gene099@racer.site
In-Reply-To: <7v4pbne013.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76012>

Hi,

On Mon, 3 Mar 2008, Junio C Hamano wrote:

> My reading of "sub update_remote {}" seems to indicate there still are
> some differences.

I will take care of your comments tomorrow (i.e. after sleeping), and yes, 
you are correct, I missed the fact that remotes.default has a special 
meaning.

Will fix,
Dscho
