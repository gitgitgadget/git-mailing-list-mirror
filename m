From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-cget: prints elements of C code in the git
 repository
Date: Tue, 24 Mar 2009 14:52:10 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903241449200.7493@intel-tinevez-2-302>
References: <49C8B159.2040600@gmail.com> <alpine.DEB.1.00.0903241257430.7493@intel-tinevez-2-302> <49C8E074.4030808@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Roel Kluin <roel.kluin@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 14:54:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm75B-0002Ts-TR
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 14:54:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314AbZCXNwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 09:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751929AbZCXNwO
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 09:52:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:58235 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752599AbZCXNwO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 09:52:14 -0400
Received: (qmail invoked by alias); 24 Mar 2009 13:52:10 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp008) with SMTP; 24 Mar 2009 14:52:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Br1ozccoBb26cBgRCztPJYtHU6jm8HZbTRcA1TB
	1JQw8W2wmTiBQj
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <49C8E074.4030808@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114459>

Hi,

On Tue, 24 Mar 2009, Roel Kluin wrote:

> > - the name is not expressive enough,
> 
> How about get-def? If it's too long it will become tiresome to type.

IMHO "git grep-c" would be more to the point...

> > - the commit message is severely lacking (I had to apply it and run it 
> >   to find out what problem it tries to solve),
> 
> This is probably better:
> [...]

Yes, I like it!

> > - maybe it would be nicer to integrate this into git grep itself?  
> >   Maybe by allowing multi-line matches and default patterns, or 
> >   pattern templates?
> 
> I did attempt to program it in C, but I am more comfortable with bash.

Did I misunderstand your code?  I thought all it does is provide a way to 
match multiline patterns... but then, I could not do more than just 
quickly glance over the code.

> Also, what would be more appropriate for this purpose, I think, is a git 
> sed.

Just as it happens, this is a toy I am working on and off these days... 
strbuf_regsub() is already done, and half the needed code is in my version 
git grep.

Ciao,
Dscho
