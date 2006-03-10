From: Jonas Fonseca <fonseca@diku.dk>
Subject: Cogito: Cleanup documentation building and add quick reference
Date: Fri, 10 Mar 2006 15:41:06 +0100
Message-ID: <20060310144106.GA7920@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 10 15:41:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHinv-0007V2-Eu
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 15:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWCJOlQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 09:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWCJOlQ
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 09:41:16 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:46304 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1751363AbWCJOlQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Mar 2006 09:41:16 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 1987B52D62B;
	Fri, 10 Mar 2006 15:41:14 +0100 (CET)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 01501-20; Fri, 10 Mar 2006 15:41:06 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 556BF52D533;
	Fri, 10 Mar 2006 15:41:06 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 18F856DF835; Fri, 10 Mar 2006 15:39:42 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 3C5E561DC1; Fri, 10 Mar 2006 15:41:06 +0100 (CET)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17474>

Hi,

Here are a few patches that makes it possible to build documentation as
PDF using docbook2pdf (chosen because xmlto doesn't seem to be able to
generate PDFs).

All the patches leads up to adding a quick reference with often used
Cogito commands and associated option. It is inspired by svn-ref and the
goal is to have the PDF version under two pages long. The grouping of
commands could need some more comments.

The quick reference can be translated into HTML, PDF and cg-ref(7)
manpage. The last one is achieved by stripping much of the markup from
the 'default' version since manpages cannot have table layout. Note the
HTML and PDF versions are generated as quick-reference.{html,pdf}. We
might want to generate cg-ref.{html,pdf} instead.

-- 
Jonas Fonseca
