From: Andreas Ericsson <ae@op5.se>
Subject: Re: In future, to replace autotools by cmake like KDE4 did?
Date: Fri, 07 Dec 2007 13:44:17 +0100
Message-ID: <47594021.40200@op5.se>
References: <998d0e4a0712061810k18e6388jde9d7bc5bd006b57@mail.gmail.com> <m3lk86u2fq.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "J.C. Pizarro" <jcpiza@gmail.com>, gcc@gcc.gnu.org,
	git@vger.kernel.org, David Miller <davem@davemloft.net>,
	Daniel Berlin <dberlin@dberlin.org>,
	Ismail Donmez <ismail@pardus.org.tr>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 13:44:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0cZS-000460-V0
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 13:44:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378AbXLGMoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 07:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752116AbXLGMoZ
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 07:44:25 -0500
Received: from mail.op5.se ([193.201.96.20]:35097 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751817AbXLGMoY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 07:44:24 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 45C991F0809D;
	Fri,  7 Dec 2007 13:44:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B8MhFfFKh4IW; Fri,  7 Dec 2007 13:44:22 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id D0A791F0802A;
	Fri,  7 Dec 2007 13:44:20 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <m3lk86u2fq.fsf@roke.D-201>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67420>

Jakub Narebski wrote:
> 
> Although there was some talk about whether giw should use autotools,
> or perhaps CMake, or handmade ./configure script like MPlayer IIRC,
> instead of its own handmade Makefile...
> 

To tell the truth, I'd be much happier if everything like that got
put in a header file or some such. 95% of what we figure out by looking
at "uname" output can already be learned by looking at the various
pre-defined macros.

Fortunately, there's a project devoted solely to this, so most of
the tedious research need not be done. It can be found at
http://predef.sourceforge.net/

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
