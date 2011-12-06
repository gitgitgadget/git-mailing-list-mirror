From: Jeff King <peff@peff.net>
Subject: Re: Query on git commit amend
Date: Tue, 6 Dec 2011 14:11:24 -0500
Message-ID: <20111206191124.GE9492@sigill.intra.peff.net>
References: <4EDDD0E4.6040003@st.com>
 <87fwgxwvn9.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Viresh Kumar <viresh.kumar@st.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>
To: Vijay Lakshminarayanan <laksvij@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 20:11:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY0QO-0004h7-7x
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 20:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806Ab1LFTL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 14:11:27 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41463
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752289Ab1LFTL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 14:11:26 -0500
Received: (qmail 7265 invoked by uid 107); 6 Dec 2011 19:18:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 Dec 2011 14:18:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2011 14:11:24 -0500
Content-Disposition: inline
In-Reply-To: <87fwgxwvn9.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186372>

On Tue, Dec 06, 2011 at 09:16:18PM +0530, Vijay Lakshminarayanan wrote:

> I've found 
> 
> $ GIT_EDITOR=cat git commit --amend
> 
> useful.
> 
> The benefit of this technique is that it even works for git-rebase -i.

I sometimes do a similar thing, but I don't use "cat". That will dump
all of the log message (including the generated template) to stdout
(i.e., the terminal), which is quite noisy. Instead, I use:

  GIT_EDITOR=true git commit --amend

which silently leaves the file untouched.

-Peff
