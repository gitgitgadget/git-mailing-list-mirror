From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH] Add script for importing bits-and-pieces to Git.
Date: Mon, 24 Aug 2009 19:10:16 +0200 (CEST)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0908241909420.16576@perkele.intern.softwolves.pp.se>
References: <20090823201624.206F52FC20@perkele>
 <18071eea0908231328r58b0e22ap20e664d2904420a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Thomas Adam <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 19:10:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mfd3q-00029Z-NL
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 19:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752878AbZHXRKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 13:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752843AbZHXRKR
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 13:10:17 -0400
Received: from smtp.getmail.no ([84.208.15.66]:56497 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752840AbZHXRKQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Aug 2009 13:10:16 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOW00KIK5162J10@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 24 Aug 2009 19:10:18 +0200 (MEST)
Received: from perkele ([84.215.142.63]) by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOW00GER515NVC0@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 24 Aug 2009 19:10:18 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.24.165417
Received: by perkele (Postfix, from userid 501)	id 786092FC20; Mon,
 24 Aug 2009 19:10:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id 755B22FBF0; Mon, 24 Aug 2009 19:10:16 +0200 (CEST)
In-reply-to: <18071eea0908231328r58b0e22ap20e664d2904420a0@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126945>

Thomas Adam:

> Minor nit.  Better written as:
> my ($size, $mtime) = (stat(FILE))[7,9];

Ah. Another obscure Perl syntax to consider :-) I'll send an updated patch. 
Thanks.

-- 
\\// Peter - http://www.softwolves.pp.se/
