From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Introduce a filter-path argument to git-daemon, for
 doing custom path transformations
Date: Thu, 12 Mar 2009 17:50:01 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903121748550.6335@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0903121218000.10279@pacific.mpi-cbg.de> <1236872914-43327-1-git-send-email-johan@johansorensen.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-139883056-1236876602=:6335"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Johan_S=F8rensen?= <johan@johansorensen.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 17:59:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lho8A-0002oL-7q
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 17:51:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753575AbZCLQuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 12:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbZCLQuI
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 12:50:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:47083 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751260AbZCLQuH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 12:50:07 -0400
Received: (qmail invoked by alias); 12 Mar 2009 16:50:02 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp068) with SMTP; 12 Mar 2009 17:50:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19FfSkW4QlFtSsSsX2bw8QVtq2ZrscKlHxpqalvYW
	fLutktyVhvvisS
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1236872914-43327-1-git-send-email-johan@johansorensen.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113088>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-139883056-1236876602=:6335
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 12 Mar 2009, Johan Sørensen wrote:

> The parameter for filter-path is an executable that will receive the service
> name, the client hostname and path to the repos the client requests as as
> arguments. It is then the responsibility of the script to return a zero
> terminated string on its stdout with the real path of the target repository.
> 
> Signed-off-by: Johan Sørensen <johan@johansorensen.com>

I see that you addressed some, but not all of my concerns.  Do you think 
that I am wrong?  Then please, by all means, increase my knowledge.

Ciao,
Dscho
--8323329-139883056-1236876602=:6335--
