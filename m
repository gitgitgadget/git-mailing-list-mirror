From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: native (cyrillic) filenames in git-diff and git-log (qgit and
	gitk)
Date: Sat, 24 May 2008 18:37:28 +0300
Message-ID: <20080524153728.GA2997@mithlond.arda.local>
References: <48382A11.2060308@ngs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilya Silvestrov <modjo@ngs.ru>
X-From: git-owner@vger.kernel.org Sat May 24 17:38:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzvpE-0006Y0-98
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 17:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553AbYEXPhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 11:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751968AbYEXPhg
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 11:37:36 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:36870 "EHLO
	jenni2.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751196AbYEXPhg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 11:37:36 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni2.rokki.sonera.fi (8.5.014)
        id 482C7F34006D889A; Sat, 24 May 2008 18:37:29 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JzvoG-0002nG-Sj; Sat, 24 May 2008 18:37:28 +0300
Content-Disposition: inline
In-Reply-To: <48382A11.2060308@ngs.ru>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82818>

Ilya Silvestrov wrote (2008-05-24 21:45 +0700):

> I'am looking for possibility to work with native (cyrillic) filenames
> in  git. The problem I struggle with is that I'm unable to view
> filenames in  readable form in git-log and git-diff. They are in
> escaped form, like this:
> diff --git "a/\321\200\321\203\321\201\321\201\320\272\320\270\320\271"  
> "b/\321\200\321\203\321\201\321\201\320\272\320\270\320\271"

Yes, extremely ugly. I believe setting core.quotepath to false will
help:

  $ git config --global core.quotepath false

I wonder why is this not the default?
