From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git log filtering
Date: Wed, 7 Feb 2007 13:03:05 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702071257490.8424@woody.linux-foundation.org>
References: <68948ca0702070841m76817d9el7ce2ec69835c50e@mail.gmail.com>
 <Pine.LNX.4.64.0702070856190.8424@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702071822430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v64ad7l12.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Don Zickus <dzickus@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 07 22:03:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEtwo-0004Uu-1o
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 22:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422742AbXBGVDO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 16:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422744AbXBGVDO
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 16:03:14 -0500
Received: from smtp.osdl.org ([65.172.181.24]:36732 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422742AbXBGVDN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 16:03:13 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l17L36dD019312
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 7 Feb 2007 13:03:06 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l17L351x027071;
	Wed, 7 Feb 2007 13:03:05 -0800
In-Reply-To: <7v64ad7l12.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.448 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.113__
X-MIMEDefang-Filter: osdl$Revision: 1.175 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38966>



On Wed, 7 Feb 2007, Junio C Hamano wrote:
> 
> This is very tempting but, ... hmmmm...

I would actually prefer to have it be some marker on the expression 
itself.

We already do that '^' handling by hand for "author"/"committer" things. 
We could do other things like that.

Although I guess the downside of not doing standard regexps would be too 
big.

		Linus
