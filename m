From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: CVS import [SOLVED]
Date: Mon, 16 Feb 2009 14:45:09 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902161443230.6289@intel-tinevez-2-302>
References: <19651.77.61.241.211.1234775877.squirrel@hupie.xs4all.nl> <7291.77.61.241.211.1234790434.squirrel@hupie.xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Mon Feb 16 14:47:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ3o8-0007w6-0c
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 14:46:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756865AbZBPNpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 08:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756394AbZBPNpN
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 08:45:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:38903 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756863AbZBPNpL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 08:45:11 -0500
Received: (qmail invoked by alias); 16 Feb 2009 13:45:10 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp071) with SMTP; 16 Feb 2009 14:45:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Byk07fcOBBvYAs5BQ4XBKtKswITA19KC/nhuQKj
	bN7VYSbNYCWnoL
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7291.77.61.241.211.1234790434.squirrel@hupie.xs4all.nl>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110179>

Hi,

On Mon, 16 Feb 2009, Ferry Huberts (Pelagic) wrote:

> I solved it:
> 
> it has to do with the
> core.autocrlf=input
> core.safecrlf=true
> 
> settings I had in my global config.

Thanks!

> Maybe the manual page should warn against having these defined?

Maybe it should be solved differently?  As cvsimport needs to operate with 
autocrlf=false, it seems, it could set that variable when it creates a 
repository, and check the variable otherwise (erroring out if it is set 
inappropriately)?

Ciao,
Dscho
