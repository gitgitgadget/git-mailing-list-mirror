From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] cg-object-id: comment the alternate id shortcut parsing
Date: Wed, 7 Dec 2005 23:19:45 +0100
Message-ID: <20051207221945.GB27619@diku.dk>
References: <20051207213943.GC25890@diku.dk> <20051207220521.GM22159@pasky.or.cz> <20051207221449.GA27619@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 23:21:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ek7dv-0003Fk-WD
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 23:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030403AbVLGWTs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 17:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030402AbVLGWTr
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 17:19:47 -0500
Received: from nhugin.diku.dk ([130.225.96.140]:54216 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1030403AbVLGWTq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Dec 2005 17:19:46 -0500
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 6A84E6DFF00; Wed,  7 Dec 2005 23:18:51 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 310BF6DFEF4; Wed,  7 Dec 2005 23:18:51 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 909A261557; Wed,  7 Dec 2005 23:19:45 +0100 (CET)
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20051207221449.GA27619@diku.dk>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13350>

Jonas Fonseca <fonseca@diku.dk> wrote Wed, Dec 07, 2005:
> Petr Baudis <pasky@suse.cz> wrote Wed, Dec 07, 2005:
> > Dear diary, on Wed, Dec 07, 2005 at 10:39:43PM CET, I got a letter
> > where Jonas Fonseca <fonseca@diku.dk> said that...
> > > -	# Short id's must be lower case and at least 4 digits.
> > > +	# Short id's must be lower case and at least 4 digits. git-rev-parse(1)
> > > +	# allows only down to 5 digits and we want to show the list of matched
> > > +	# ids.
> > 
> > Huh. The code in sha1_name.c speaks differently and it works as well:
> > 
> > 	$ git-rev-parse b1fc
> > 	b1fcca45069d4f6b00a9ac7136be4268d09fd6b9
> 
> I had this one testcase:
> 
	~/src/elinks/0.11 > git-rev-parse --verify e6b6
	error: short SHA1 e6b6 is ambiguous.
	fatal: Needed a single revision
> 	~/src/elinks/0.11 > cg-object-id e6b6
> 	e6b65b543108bfeb95ea24978112b46e34cfde87
> 
> Could it have something to do with the local packing?

-- 
Jonas Fonseca
