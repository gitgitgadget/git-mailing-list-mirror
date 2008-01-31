From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] git-filter-branch.sh: don't use --default when
 calling rev-list
Date: Thu, 31 Jan 2008 11:07:06 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801311106300.23907@racer.site>
References: <47A109A7.1070502@nrlssc.navy.mil> <1201738186-28132-1-git-send-email-casey@nrlssc.navy.mil> <47A11317.2010409@nrlssc.navy.mil> <alpine.LSU.1.00.0801310048350.23907@racer.site> <47A125D9.2070105@nrlssc.navy.mil> <47A19211.5090409@op5.se>
 <7vwspqcple.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 12:08:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKXH9-0008Js-AS
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 12:08:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929AbYAaLHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 06:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762067AbYAaLHi
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 06:07:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:36575 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752222AbYAaLHi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 06:07:38 -0500
Received: (qmail invoked by alias); 31 Jan 2008 11:07:35 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp022) with SMTP; 31 Jan 2008 12:07:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX183slskgiE3frcmCDhk7AgFI4qazzTARM7lCucjxp
	FTkziw7L3CafZI
X-X-Sender: gene099@racer.site
In-Reply-To: <7vwspqcple.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72126>

Hi,

On Thu, 31 Jan 2008, Junio C Hamano wrote:

> Andreas Ericsson <ae@op5.se> writes:
> 
> > Well, if there's no filter specified it has nothing to do, so erroring 
> > out in the no-arguments-at-all case would be sensible.
> 
> Actually, not erroring out but just returning doing nothing (if there 
> truly isn't anything to do -- iow, the filtering operation turns out to 
> be identity function) would be more sensible.
> 
> No filter does not necessarily mean identity, by the way.  Think 
> "grafts" ;-).

Yeah.  Having slept over it, I agree that there is a sensible default 
action, and only one.

Ciao,
Dscho
