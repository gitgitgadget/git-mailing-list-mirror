From: Olivier Galibert <galibert@pobox.com>
Subject: Re: [PATCH 4/5] Make 'diff_populate_filespec()' use the new 'strbuf_readlink()'
Date: Thu, 18 Dec 2008 18:56:01 +0100
Message-ID: <20081218175601.GC29040@dspnet.fr.eu.org>
References: <alpine.LFD.2.00.0812171034520.14014@localhost.localdomain> <alpine.LFD.2.00.0812171042120.14014@localhost.localdomain> <alpine.LFD.2.00.0812171042500.14014@localhost.localdomain> <alpine.LFD.2.00.0812171043180.14014@localhost.localdomain> <alpine.LFD.2.00.0812171043440.14014@localhost.localdomain> <20081218121118.3635c53c@crow> <alpine.LFD.2.00.0812180851120.14014@localhost.localdomain> <494A8B57.6070106@lsrfire.ath.cx> <alpine.LFD.2.00.0812180945330.14014@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Mark Burton <markb@ordern.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Dec 18 19:04:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDNEC-0005aJ-5h
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 19:04:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbYLRSCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 13:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbYLRSCq
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 13:02:46 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:3075 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751527AbYLRSCp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 13:02:45 -0500
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Dec 2008 13:02:45 EST
Received: by dspnet.fr.eu.org (Postfix, from userid 1007)
	id 05F1DA490F; Thu, 18 Dec 2008 18:56:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0812180945330.14014@localhost.localdomain>
User-Agent: Mutt/1.4.2.3i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103478>

On Thu, Dec 18, 2008 at 09:49:23AM -0800, Linus Torvalds wrote:
> If it's possible to screw the type system up, history shows that
> somebody (usually Windows) will do it.

AFAIK, the Win64 long is 32 bits and size_t/void * is 64 bits.  I'll
leave you to your groaning.

  OG.
