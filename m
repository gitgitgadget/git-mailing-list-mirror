From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git locate
Date: Wed, 20 Jan 2010 10:32:10 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001201021060.31129@intel-tinevez-2-302>
References: <43d8ce651001191717l58d10919j691f4e5b056fe9b5@mail.gmail.com> <alpine.DEB.1.00.1001200224270.4985@pacific.mpi-cbg.de> <m3zl49bk0o.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: John Tapsell <johnflux@gmail.com>, Git List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 10:32:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXWvD-0002UQ-Ph
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 10:32:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624Ab0ATJcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 04:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403Ab0ATJcP
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 04:32:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:46395 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751565Ab0ATJcO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 04:32:14 -0500
Received: (qmail invoked by alias); 20 Jan 2010 09:32:12 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp038) with SMTP; 20 Jan 2010 10:32:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+OezsUKxeODxKvX/EtgubdIFKUEHQn7Wf2tH0nt1
	or1n3Vuxx0TFSH
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <m3zl49bk0o.fsf@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68000000000000005
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137527>

Hi,

On Tue, 19 Jan 2010, Jakub Narebski wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Wed, 20 Jan 2010, John Tapsell wrote:
> > 
> > >   Could we add a:  git locate <filename>       or git find <filename>
> > 
> > How about "git ls-files \*<filename>"?
> 
> Or "git ls-files '*filename'...
> 
> ... but how to make an (git) alias for this?

Add something like this to your $HOME/.gitconfig:

[alias]
        locate = !sh -c 'git ls-files "\\*$1"' -

Ciao,
Dscho
