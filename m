From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] Allow empty commits during rebase -i
Date: Mon, 18 Jan 2010 11:01:50 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001181059510.4985@pacific.mpi-cbg.de>
References: <4B53B561.0@pcharlan.com> <7vljfww686.fsf@alter.siamese.dyndns.org> <4B53C355.1010109@pcharlan.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>
To: Pete Harlan <pgit@pcharlan.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 10:56:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWoLK-00088H-MY
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 10:56:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855Ab0ARJ4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 04:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751841Ab0ARJ4K
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 04:56:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:48365 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751661Ab0ARJ4I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 04:56:08 -0500
Received: (qmail invoked by alias); 18 Jan 2010 09:56:06 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp053) with SMTP; 18 Jan 2010 10:56:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19PQ9IUDeZPR5LBLbCgOLdjYyj1G6/drz7TM1xdtn
	edc73/ClxM35ih
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4B53C355.1010109@pcharlan.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.70999999999999996
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137380>

Hi,

On Sun, 17 Jan 2010, Pete Harlan wrote:

> If the introduction of empty commits that the user has asked for 
> (perhaps inadvertently) is considered too undesirable, then perhaps my 
> fix is too simple.  I'll think about how to do something more 
> sophisticated.

How about something less sophisticated instead?  Namely, check for the 
condition that nothing was changed, and tell the user that the commit 
blablabla seems to introduce changes that are already present in HEAD.  
Maybe even mention that this may be due to the commit being applied 
already and saying that --continue is safe in that case, but please check.

Hmm?

Ciao,
Dscho
