From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] cg-object-id: comment the alternate id shortcut parsing
Date: Wed, 7 Dec 2005 23:14:49 +0100
Message-ID: <20051207221449.GA27619@diku.dk>
References: <20051207213943.GC25890@diku.dk> <20051207220521.GM22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 23:15:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ek7ZJ-0001mu-Aq
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 23:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030394AbVLGWOv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 17:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030390AbVLGWOv
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 17:14:51 -0500
Received: from nhugin.diku.dk ([130.225.96.140]:43720 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1030394AbVLGWOu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Dec 2005 17:14:50 -0500
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 5C21C6DFECC; Wed,  7 Dec 2005 23:13:55 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 223126DF89F; Wed,  7 Dec 2005 23:13:55 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 7FF1D61557; Wed,  7 Dec 2005 23:14:49 +0100 (CET)
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20051207220521.GM22159@pasky.or.cz>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13349>

Petr Baudis <pasky@suse.cz> wrote Wed, Dec 07, 2005:
> Dear diary, on Wed, Dec 07, 2005 at 10:39:43PM CET, I got a letter
> where Jonas Fonseca <fonseca@diku.dk> said that...
> > -	# Short id's must be lower case and at least 4 digits.
> > +	# Short id's must be lower case and at least 4 digits. git-rev-parse(1)
> > +	# allows only down to 5 digits and we want to show the list of matched
> > +	# ids.
> 
> Huh. The code in sha1_name.c speaks differently and it works as well:
> 
> 	$ git-rev-parse b1fc
> 	b1fcca45069d4f6b00a9ac7136be4268d09fd6b9

I had this one testcase:

	~/src/elinks/0.11 > cg-object-id --verify e6b6
	cg-object-id: unrecognized option `--verify'
	~/src/elinks/0.11 > cg-object-id e6b6
	e6b65b543108bfeb95ea24978112b46e34cfde87

Could it have something to do with the local packing?

-- 
Jonas Fonseca
