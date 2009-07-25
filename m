From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git fast-export: add --no-data option
Date: Sat, 25 Jul 2009 16:28:48 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907251628220.8306@pacific.mpi-cbg.de>
References: <7f9d599f0907250645s6e6f9b81w3cf20f07eff088eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Sat Jul 25 16:28:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUiF4-0005eK-SU
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 16:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbZGYO2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 10:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbZGYO2q
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 10:28:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:57105 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751579AbZGYO2q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 10:28:46 -0400
Received: (qmail invoked by alias); 25 Jul 2009 14:28:44 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp058) with SMTP; 25 Jul 2009 16:28:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Ba0ASK7SB88cC1dUyboB/B+gh5GQ1BLD4EUAvh9
	8Xpp4uVymLVUtH
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7f9d599f0907250645s6e6f9b81w3cf20f07eff088eb@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124009>

Hi,

On Sat, 25 Jul 2009, Geoffrey Irving wrote:

> When using git fast-export and git fast-import to rewrite the history
> of a repository with large binary files, almost all of the time is
> spent dealing with blobs.  This is extremely inefficient if all we want
> to do is rewrite the commits and tree structure.  --no-data skips the
> output of blobs and writes SHA-1s instead of marks, which provides a
> massive speedup.

ACK.  I was looking for such an option recently, and was disappointed that 
it was not there yet.

Ciao,
Dscho
