From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC 1/5] GSOC: prepare svndump for branch detection
Date: Mon, 20 Aug 2012 09:45:30 -0700
Message-ID: <20120820164530.GD168@mannheim-rule.local>
References: <1345236010-1648-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <5679616.CtEd2rlvlO@flomedio>
 <7v7gsum4oc.fsf@alter.siamese.dyndns.org>
 <1701463.olu8UUX9CV@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <b@rr-dav.id.au>, git@vger.kernel.org
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 18:45:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3V65-0006C1-N9
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 18:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757387Ab2HTQo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 12:44:56 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62271 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757347Ab2HTQoz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 12:44:55 -0400
Received: by pbbrr13 with SMTP id rr13so7175953pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 09:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=lSIkuIZBosPBk3Uf7Q3wKUM14UPPBPneiwJ/AL5A0Y8=;
        b=oJ8wqpMWI1SuzkUYndQXMkR0+MBAp+VM450simZb3pB/Hg2WACxyrbjDtZj6sqc/Wz
         qpwjV78XiDyJcZulI1n+ddSnN0qk0Vy+VBOj4L5WmAzPCUwrhnuNCX4sUvs4DPvim56K
         6Xn77RsG4MzYnQURvTTgHXpgxo5TWgib2Mf1fmbZXmMRrzUp45+nXIOXXRilpfbez0Uy
         Z09HD3+Z+fMPmJlwTrKb/Wp778wi8jCjajITsFZsMwH8G7qBd+a4GxUctQdugIOXAYiG
         1PGczzmem2VqjCD+Q7cBrhs7zB5SzD9+TFwR524wHDgMfUCuNbMaFD4RjzfY3XbccBHK
         52TA==
Received: by 10.68.216.104 with SMTP id op8mr35863623pbc.65.1345481094646;
        Mon, 20 Aug 2012 09:44:54 -0700 (PDT)
Received: from mannheim-rule.local (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id wd6sm11419652pbc.15.2012.08.20.09.44.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 09:44:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1701463.olu8UUX9CV@flomedio>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203856>

Florian Achleitner wrote:

> Currently, the mark number is equal to the svn revision number the commit
> corresponds to. I didn't want to break that, but not mandatory. We could also
> split the mark namespace by reserving one or more of the most significant bits
> as a type specifier.
> I'll develop a marks-based version ..

Have we already exhausted possibilities that don't involve changing
vcs-svn/ code quite so much?  One possibility mentioned before was to
post-process the stream that svn-fe produces, which seemed appealing
from a debuggability point of view.

Curious,
Jonathan
