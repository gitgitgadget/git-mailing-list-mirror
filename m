From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] Add git-squash tool and tests
Date: Mon, 9 Jun 2008 21:34:55 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806092133260.1783@racer>
References: <484D47C9.9050509@gnu.org> <1213043398-30524-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Paolo Bonzini <bonzini@gnu.org>,
	Junio C Hamano <gitster@pobox.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Mon Jun 09 22:37:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5o73-0008HG-FR
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 22:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbYFIUgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 16:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbYFIUgQ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 16:36:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:55829 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750999AbYFIUgP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 16:36:15 -0400
Received: (qmail invoked by alias); 09 Jun 2008 20:36:13 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp065) with SMTP; 09 Jun 2008 22:36:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+D0A0GAMODoOtPf4aL/u4Kz97Eiz+fm7Vwf2AkeC
	hamK89Wbrc95+9
X-X-Sender: gene099@racer
In-Reply-To: <1213043398-30524-1-git-send-email-s-beyer@gmx.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84421>

Hi,

On Mon, 9 Jun 2008, Stephan Beyer wrote:

> git-squash is a simple command that, given the parent commit of X,
> squashes the commits X..HEAD into one.

Isn't it possible to do this with something like

	$ git reset --hard X^ &&
	  git merge --no-ff --squash HEAD@{1}

?

Ciao,
Dscho
