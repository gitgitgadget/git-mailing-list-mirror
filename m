From: "Matthias Andree" <matthias.andree@uni-paderborn.de>
Subject: Re: git-svn intermittent issues with absent_file
Date: Fri, 28 Aug 2009 10:14:42 +0200
Organization: =?iso-8859-15?Q?Universit=E4t_Paderborn=3B_EIM-I?=
Message-ID: <op.uzc46sm43myrm3@balu.cs.uni-paderborn.de>
References: <op.uzbs4bsq3myrm3@balu.cs.uni-paderborn.de>
 <20090827191902.GA3185@dcvr.yhbt.net> <op.uzc1njug3myrm3@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Aug 28 10:15:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgwc8-0000qx-A3
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 10:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbZH1IOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 04:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752322AbZH1IOr
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 04:14:47 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:50540 "EHLO
	mail.uni-paderborn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312AbZH1IOo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 04:14:44 -0400
Received: from balu.cs.uni-paderborn.de ([131.234.21.37])
	by mail.uni-paderborn.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63 spheron)
	id 1Mgwbc-00036t-GT; Fri, 28 Aug 2009 10:14:45 +0200
Received: from localhost ([127.0.0.1] helo=balu.cs.uni-paderborn.de)
	by balu.cs.uni-paderborn.de with esmtp (Exim 4.69)
	(envelope-from <matthias.andree@uni-paderborn.de>)
	id KP2UWJ-0001Z8-64; Fri, 28 Aug 2009 10:14:43 +0200
In-Reply-To: <op.uzc1njug3myrm3@merlin.emma.line.org>
User-Agent: Opera Mail/9.64 (Win32)
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 5.5.7.378829, Antispam-Engine: 2.7.2.376379, Antispam-Data: 2009.8.28.80328
X-IMT-Authenticated-Sender: uid=mandree,ou=People,o=upb,c=de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127276>

Am 28.08.2009, 08:58 Uhr, schrieb Matthias Andree  
<matthias.andree@uni-paderborn.de>:

> The other question is how many arcane APR or Subversion binding issues we
> hit here. Subversion 1.6 + bindings surely is rather picky on Cygwin 1.5,
> as discussed earlier on this list.

As an update, Git-SVN 1.6.4.0 and 1.6.4.1 haven't seen such problems last  
night when run on Ubuntu Linux.

So, the common idea set is apparently down to (a) intermittent server  
issues (I've asked for the relevant log excerpts) and (b) Cygwin issues,  
and we should keep in mind (c) git-svn, or svn bindings/libraries, losing  
the causes error conditions from (a) or (b) and git-svn just reporting  
later symptoms (absent files). More on the other experiments once I get  
around to them.

Thanks
Matthias
