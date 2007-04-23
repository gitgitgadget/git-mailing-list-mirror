From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: adding file by absolute name -- problem
Date: Mon, 23 Apr 2007 12:16:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704231215370.8822@racer.site>
References: <f36b08ee0704230239i4892983q4feb4a1872a320ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Yakov Lerner <iler.ml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 12:17:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfvbT-0001VJ-7u
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 12:17:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965706AbXDWKRA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 06:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965712AbXDWKRA
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 06:17:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:53614 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965706AbXDWKRA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 06:17:00 -0400
Received: (qmail invoked by alias); 23 Apr 2007 10:16:58 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp041) with SMTP; 23 Apr 2007 12:16:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19HmiRWwR9HLnr7qZsgtmtRCXvU7Ri5HCj6JcNhpG
	w8E86Z/XI7INWi
X-X-Sender: gene099@racer.site
In-Reply-To: <f36b08ee0704230239i4892983q4feb4a1872a320ea@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45311>

Hi,

On Mon, 23 Apr 2007, Yakov Lerner wrote:

> When I give absolute pathname /a/b/repo/d to git add, it
> mostly does not work. I get errors from git-add. Is it by design ?

AFAICT it is by design. I fail to see why absolute paths should be 
supported, too. You are supposed to be _in_ the working directory when 
adding files...

Ciao,
Dscho
