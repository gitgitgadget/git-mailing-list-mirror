From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Can I prevent someone clone my git repository?
Date: Thu, 8 Jan 2009 12:27:59 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901081227170.30769@pacific.mpi-cbg.de>
References: <856bfe0e0901072303i4fcd3bf6u99790ab9f4170937@mail.gmail.com> <7vr63e42ke.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Emily Ren <lingyan.ren@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 12:28:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKt4B-0004Oq-NH
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 12:28:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011AbZAHL1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 06:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751968AbZAHL1W
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 06:27:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:46545 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750928AbZAHL1V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 06:27:21 -0500
Received: (qmail invoked by alias); 08 Jan 2009 11:27:19 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 08 Jan 2009 12:27:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18NQc9lIpsNwaqZyiO2GvmuTKEdaQzWhxBDvz2ovJ
	2Ndd/cUuqj8y/n
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vr63e42ke.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104915>

Hi,

On Thu, 8 Jan 2009, Junio C Hamano wrote:

> The git-daemon transport deliberately omits authentication, and you 
> cannot restrict when they come over the git native transport using a URL 
> like git://your-host/repository.git

If the people are on different IPs, a hook can restrict who may clone, 
since commit v1.6.1-rc1~109.

Ciao,
Dscho
