From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Mon, 17 Aug 2009 18:19:54 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908171817570.4991@intel-tinevez-2-302>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com> <200908142223.07994.jnareb@gmail.com> <7veird4yyi.fsf@alter.siamese.dyndns.org> <200908160137.30384.jnareb@gmail.com> <alpine.DEB.1.00.0908161002460.8306@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0908171101090.4991@intel-tinevez-2-302> <7vtz06xxao.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 18:20:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md4wH-0004ps-L0
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 18:20:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756592AbZHQQT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 12:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753104AbZHQQT4
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 12:19:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:40259 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751754AbZHQQTz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 12:19:55 -0400
Received: (qmail invoked by alias); 17 Aug 2009 16:19:55 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp006) with SMTP; 17 Aug 2009 18:19:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+QgmkMRnmQ4lqFPufwfZbc+IlhWi1+kjwYvlbhG7
	KEWY/QzijqySwo
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vtz06xxao.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126216>

Hi,

On Mon, 17 Aug 2009, Junio C Hamano wrote:

> I'd say that assume-unchanged is a promise you make git that you won't 
> change these paths, and in return to the promise git will give you 
> faster response by not running lstat on them.  Having changes in such 
> paths is your problem and you deserve these chanegs to be lost.  At 
> least, that is the interpretation according to the original 
> assume-unchanged semantics.

That's why I did not suggest using assume-unchanged (which the guy did 
previously, and was burnt, deservedly, as you say).

However, my illustration of the scenario was only to one end, namely to 
convince all of you that assume-changed != sparse.

And maybe to the end to explain that sparse checkout could help this guy.

Ciao,
Dscho
