From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: problem with git-cvsserver
Date: Wed, 30 Aug 2006 19:07:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608301904360.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <44F5B2A7.8070501@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 30 19:08:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GITXO-0006Er-To
	for gcvg-git@gmane.org; Wed, 30 Aug 2006 19:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWH3RHf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Aug 2006 13:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWH3RHf
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Aug 2006 13:07:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:11919 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751150AbWH3RHe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Aug 2006 13:07:34 -0400
Received: (qmail invoked by alias); 30 Aug 2006 17:07:32 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp014) with SMTP; 30 Aug 2006 19:07:32 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: aonghus <thecolourblue@gmail.com>
In-Reply-To: <44F5B2A7.8070501@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26228>

Hi,

On Wed, 30 Aug 2006, aonghus wrote:

>    install_driver(SQLite) failed: Can't locate DBD/SQLite.pm in @INC (@INC
> contains: /etc/perl /usr/local/lib/perl/5.8.8 /usr/local/share/perl/5.8.8
> /usr/lib/perl5 /usr/share/perl5 /usr/lib/perl/5.8 /usr/share/perl/5.8
> /usr/local/lib/site_perl /usr/local/lib/perl/5.8.7 /usr/local/share/perl/5.8.7
> .) at (eval 7) line 3, <STDIN> line 14.
>
> [...]
> 
>    libdbd-sqlite3-perl: /usr/share/perl5/DBD/SQLite.pm

Have you checked that /usr/share/perl5/DBD/SQLite.pm is actually there? 
Because your perl does not think so.

OTOH it could be that it only works when SQLite.pm is in 
/usr/lib/perl5/DBD/ (note the "lib" instead of "share"), because in my 
(working) setup, both the .pm and the .so are under /usr/lib/perl5/...

Hth,
Dscho
