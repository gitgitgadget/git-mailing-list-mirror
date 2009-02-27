From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-1.6.2-rc2 problems on t4034-diff-words.sh
Date: Fri, 27 Feb 2009 19:38:48 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902271936090.6600@intel-tinevez-2-302>
References: <alpine.LNX.2.00.0902271103450.19082@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 19:40:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld7dK-0004Hp-1i
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 19:40:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755021AbZB0Six (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 13:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754888AbZB0Six
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 13:38:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:37601 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754375AbZB0Siw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 13:38:52 -0500
Received: (qmail invoked by alias); 27 Feb 2009 18:38:49 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp001) with SMTP; 27 Feb 2009 19:38:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19j7/I0LDtjw5ZcO4eftnXitICkU14cHdPnxaoxXg
	fX8LJbo/seKNRa
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.LNX.2.00.0902271103450.19082@suse104.zenez.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111692>

Hi,

On Fri, 27 Feb 2009, Boyd Lynn Gerber wrote:

> I just download and started to test this on SCO OpenServer 6.0.mp4

Oh wow.  SCO...

But as I did not forget your kind words, I'll try to help.

> * FAIL 6: use regex supplied by driver
> 
> 
>                 word_diff --color-words

It might be a regex related issue.  Could you

- run the test with -i -v (and if that does not help, "sh -x t...")?

- try with "make COMPAT_FLAGS=-Icompat/regex COMPAT_OBJS=compat/regex/regex.o"?

Thanks,
Dscho
