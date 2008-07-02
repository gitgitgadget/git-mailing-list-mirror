From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] git-branch -v: show the remote tracking statistics
Date: Wed, 2 Jul 2008 16:44:19 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807021643120.9925@racer>
References: <20080701091347.GA11817@elte.hu> <80iqvq2bw0.fsf@tiny.isode.net> <20080701101414.GG31309@elte.hu> <7vlk0lmn32.fsf@gitster.siamese.dyndns.org> <7vhcb8en92.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ingo Molnar <mingo@elte.hu>,
	Bruce Stephens <bruce.stephens@isode.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 17:47:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE4Y3-0005zr-9O
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 17:47:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054AbYGBPqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 11:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753694AbYGBPqO
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 11:46:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:41840 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753241AbYGBPqO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 11:46:14 -0400
Received: (qmail invoked by alias); 02 Jul 2008 15:46:12 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp020) with SMTP; 02 Jul 2008 17:46:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19azE8QcyxaYN4fmaJAUiuEsyzwGLsNVx92KiYxmE
	Qq3qKhJXfNzNpO
X-X-Sender: gene099@racer
In-Reply-To: <7vhcb8en92.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87153>

Hi,

On Wed, 2 Jul 2008, Junio C Hamano wrote:

> This teaches "git branch -v" to insert the remote tracking statistics in
> the form of [ours/theirs] just before the one-liner commit log message
> for the branch.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   ... which means that you would see something like this.
> 
>   * jc/report-tracking        41666f7 [3/117] git-branch -v: show the remo...

Actually, I would like to have something like

$ git branch --explain-relationship master next

Ciao,
Dscho
