From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Don't use cpio in git-clone when not installed
Date: Wed, 31 Oct 2007 23:55:58 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0710312354180.4362@racer.site>
References: <1193861145-20357-1-git-send-email-mh@glandium.org>
 <7v4pg6hq8u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 00:56:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InNQe-0007ZB-Pf
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 00:56:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110AbXJaX4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 19:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752497AbXJaX4n
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 19:56:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:59140 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752435AbXJaX4m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 19:56:42 -0400
Received: (qmail invoked by alias); 31 Oct 2007 23:56:40 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp001) with SMTP; 01 Nov 2007 00:56:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+5DDoJd/25/BURhACT1NurEGB34nP/YFNSuqSP9L
	lLs+W3rxHM1KFx
X-X-Sender: gene099@racer.site
In-Reply-To: <7v4pg6hq8u.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62897>

Hi,

On Wed, 31 Oct 2007, Junio C Hamano wrote:

> "type"?  That's probably better than using "which", but sounds quite 
> wrong.  Why not add Makefile target that the shell scripts depend on to 
> see if necessary tools are available and let the builder know if they 
> are not?

I thought the accord was that "cpio" is a _runtime_ dependency.  But yes, 
I agree "type" is not necessarily the best choice.  Maybe testing the exit 
code for 127 (not found) is the better choice?

Ciao,
Dscho
