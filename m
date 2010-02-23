From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Explicitly adding ignored files in subdirectories not working
Date: Tue, 23 Feb 2010 22:50:48 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002232248000.3980@intel-tinevez-2-302>
References: <fabb9a1e1002231307o2c3499e6k3f1026f71a544b16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 22:51:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk2eh-0006Bm-O5
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 22:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929Ab0BWVuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 16:50:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:39566 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753345Ab0BWVuy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 16:50:54 -0500
Received: (qmail invoked by alias); 23 Feb 2010 21:50:50 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp008) with SMTP; 23 Feb 2010 22:50:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX191VP5tYbR1KDXMxsP46RFdcj9B0lKiCqRfg5u43f
	OyqOjyOuPCkWJF
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <fabb9a1e1002231307o2c3499e6k3f1026f71a544b16@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67000000000000004
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140847>

Hi,

On Tue, 23 Feb 2010, Sverre Rabbelier wrote:

> I've been bitten by this before, is this behavior intentional? We
> don't even warn that the user's action was ignored; at the very least
> we should do that. The current behavior is just frustrating.

I get something like this:

-- snip --
$ cd Documentation
$ touch doc.dep
$ git add doc.dep
The following paths are ignored by one of your .gitignore files:
Documentation/doc.dep
Use -f if you really want to add them.
fatal: no files added
-- snap --

Ciao,
Dscho
