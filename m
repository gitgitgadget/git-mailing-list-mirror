From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] Make boundary characters for --color-words configurable
Date: Fri, 2 May 2008 17:36:50 +0300
Message-ID: <20080502143650.GB3079@mithlond.arda.local>
References: <46dff0320805012128l6cb15e1ekd40f84a9eac724d1@mail.gmail.com> <1209736766-8029-1-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 16:38:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrwOX-0005iG-Fo
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 16:37:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761374AbYEBOhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 10:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759707AbYEBOhF
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 10:37:05 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:46156 "EHLO
	kirsi2.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753543AbYEBOhE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 10:37:04 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi2.rokki.sonera.fi (8.0.013.9)
        id 481B0A2500012E89; Fri, 2 May 2008 17:37:02 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JrwNW-0001eN-Vt; Fri, 02 May 2008 17:36:51 +0300
Content-Disposition: inline
In-Reply-To: <1209736766-8029-1-git-send-email-pkufranky@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81005>

Ping Yin wrote (2008-05-02 21:59 +0800):

> Previously --color-words only allow spaces as boundary characters.
> However, just space is not enough. For example, when i rename
> a function from foo to bar, following example doesn't show as expected
> when using --color-words.

> Two changes:
> 
> * Rename diff.wordsboundary to diff.nonwordchars
> * Add documentation

I think config variables should be in alphabetical order in config.txt.
Hence your diff.nonwordchars is not in the right place. Other than that
this patch seems to work and is really useful to me. Thanks.
