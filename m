From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: On Tracking Binary Files
Date: Tue, 14 Apr 2009 18:54:06 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904141853040.10279@pacific.mpi-cbg.de>
References: <7efce40a0904140741w28da9b54ucfe4b54bf48b0844@mail.gmail.com> <7efce40a0904140742i48aad41ds66de5dfe368f3b16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Patrick Berkeley <patrickberkeley@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 18:53:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ltlsb-0005yh-Bk
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 18:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbZDNQvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 12:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757546AbZDNQvW
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 12:51:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:44624 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756677AbZDNQvV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 12:51:21 -0400
Received: (qmail invoked by alias); 14 Apr 2009 16:51:19 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp064) with SMTP; 14 Apr 2009 18:51:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19zGDhw0ltzqKdnsj7p1NxvUUB18pCOqxiMKhSTN4
	4aquUminw7K41C
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7efce40a0904140742i48aad41ds66de5dfe368f3b16@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116546>

Hi,

On Tue, 14 Apr 2009, Patrick Berkeley wrote:

> Does Git track the deltas on binary files?
> 
> Someone in #git mentioned that if the binaries change too much Git no
> longer just stores the changes. If this is the case, what is the
> breaking point where Git goes from storing the deltas to the entire
> new file?

Git does not store the deltas as you think it does.  The deltification of 
the objects is almost independent from the commmit history, i.e. we 
_always_ store snapshots for most practical matters.

Ciao,
Dscho
