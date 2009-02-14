From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCHv2] git submodule split
Date: Sat, 14 Feb 2009 12:46:09 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902141245080.10279@pacific.mpi-cbg.de>
References: <431341160902121350x45076c8cj26afab0b7a51cac5@mail.gmail.com> <1234578258-48870-1-git-send-email-git@randomhacks.net> <7v3aeh3a84.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eric Kidd <git@randomhacks.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 12:46:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYIyt-0002tw-AC
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 12:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbZBNLpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 06:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbZBNLpS
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 06:45:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:34055 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751227AbZBNLpR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 06:45:17 -0500
Received: (qmail invoked by alias); 14 Feb 2009 11:45:15 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp021) with SMTP; 14 Feb 2009 12:45:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18JFMkmZtEJME+geAxvlWWFppOWjnSGw4xyUEPWP0
	iNEUfVwv8qyoSf
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v3aeh3a84.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109862>

Hi,

On Fri, 13 Feb 2009, Junio C Hamano wrote:

> Eric Kidd <git@randomhacks.net> writes:
> 
> >   1) Right now, this command is actually git-submodule-split.sh.  
> >      Should I include this code directly into git-submodule.sh, or 
> >      move it to git-submodule--split.sh and hook it into 
> >      git-submodule.sh?
> 
> How about in contrib/ somewhere?

As I said to Eric already, I would like this to be part of git-submodule 
proper, as I expect a lot of people needing it.

Ciao,
Dscho
