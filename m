From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Tue, 13 Feb 2007 02:06:09 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702130204120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45CFA30C.6030202@verizon.net> <20070212042425.GB18010@thunk.org>
 <Pine.LNX.4.64.0702120839490.8424@woody.linux-foundation.org>
 <7vps8f6l81.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702130020450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfy9b6iyt.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702130046450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45D10D86.3030508@verizon.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Tue Feb 13 02:06:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGm7b-0004xy-Jz
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 02:06:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965449AbXBMBGM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 20:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965448AbXBMBGM
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 20:06:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:41844 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965449AbXBMBGL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 20:06:11 -0500
Received: (qmail invoked by alias); 13 Feb 2007 01:06:10 -0000
X-Provags-ID: V01U2FsdGVkX1/TmiMiSTzT3ogBskG74Qjm4+bHtMiKIkG88ZanZV
	Jh4Q==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45D10D86.3030508@verizon.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39471>

Hi,

On Mon, 12 Feb 2007, Mark Levedahl wrote:

> Perhaps I'm too paranoid, but I've been burnt way too many times by 
> text/binary mode stuff to let this part be trivialized. Maybe it only 
> gets enabled by core.ImReallyParanoid, but I want that option.

Be aware that what you proposed costs many CPU cycles. I am totally 
opposed to enabling that option by default on all platforms. I am okay 
with .gitattributes (but I would call it .gitfiletypes), but I am _not_ 
okay with git being _too much_ fscked up by Windows. Microsoft has done 
enough harm already.

Ciao,
Dscho
