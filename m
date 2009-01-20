From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] interpret_nth_last_branch(): plug small memleak
Date: Tue, 20 Jan 2009 11:15:30 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901201115160.3586@pacific.mpi-cbg.de>
References: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org> <1232163011-20088-1-git-send-email-trast@student.ethz.ch> <alpine.DEB.1.00.0901170646560.3586@pacific.mpi-cbg.de> <200901171438.22504.trast@student.ethz.ch> <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de>
 <7vljt97nld.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901172028470.3586@pacific.mpi-cbg.de> <7vmydp5tqj.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901180201070.3586@pacific.mpi-cbg.de> <7vprilyt1w.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901182152010.3586@pacific.mpi-cbg.de> <7vprijra52.fsf@gitster.siamese.dyndns.org> <7vljt7r9mq.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901191331590.3586@pacific.mpi-cbg.de> <7vvdsamrai.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 11:17:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPDfL-0005Gj-8G
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 11:17:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760236AbZATKPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 05:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760115AbZATKP3
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 05:15:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:39386 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759866AbZATKP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 05:15:27 -0500
Received: (qmail invoked by alias); 20 Jan 2009 10:15:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp014) with SMTP; 20 Jan 2009 11:15:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+XDfo0ABOXrWj/eyUz9SI+jm3RurF73TDhuI45Mj
	DENSVHcdugVhZK
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vvdsamrai.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106465>

Hi,

On Mon, 19 Jan 2009, Junio C Hamano wrote:

> The error return path leaked both cb.buf[] strbuf array itself, and the 
> strings contained in its elements.

Oops.  Thanks,
Dscho
