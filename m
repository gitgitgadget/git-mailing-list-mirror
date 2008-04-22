From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 22 Apr 2008 18:28:37 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804221827330.4460@eeepc-johanness>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>  <7vabjm1a0q.fsf@gitster.siamese.dyndns.org>  <46dff0320804220659j66dea3fehc2a9bdcdc0371025@mail.gmail.com>  <200804221655.11914.Josef.Weidendorfer@gmx.de>
 <46dff0320804221013m2ff0320am31b7f8beb5f26f1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 19:30:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoMIl-0002So-2Y
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 19:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756408AbYDVR2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 13:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756977AbYDVR2M
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 13:28:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:50512 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756734AbYDVR2L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 13:28:11 -0400
Received: (qmail invoked by alias); 22 Apr 2008 17:28:10 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp031) with SMTP; 22 Apr 2008 19:28:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18hUc5kkb0hrYMjuo0MkAnTYgyKIL161NfDb04nP5
	EEUptNQ7k8cx93
X-X-Sender: user@eeepc-johanness
In-Reply-To: <46dff0320804221013m2ff0320am31b7f8beb5f26f1b@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80148>

Hi,

On Wed, 23 Apr 2008, Ping Yin wrote:

> If we go back to a old HEAD or switch to another branch with changed 
> path for a submodule, what should 'git submodule update' do? I think 
> entries in .gitmodules should take precedence.

Literally the most common reason for a _different_ .gitmodules in an older 
revision is that the repository was moved to another machine.

In this case, your suggestion is actively wrong.

Ciao,
Dscho
