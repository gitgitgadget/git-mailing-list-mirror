From: Paul Gardiner <osronline@glidos.net>
Subject: Re: How to find where a branch was taken from.
Date: Sat, 22 Mar 2008 12:12:16 +0000
Message-ID: <47E4F7A0.6060702@glidos.net>
References: <47E37A63.9070209@glidos.net>	 <7v4pb0qw28.fsf@gitster.siamese.dyndns.org> <32541b130803211039h1f5b8da5k8fb353d46e57b05e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	osronline@glidos.net
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 22 13:13:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd2au-0006bw-2x
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 13:13:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755188AbYCVMMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 08:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755032AbYCVMMV
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 08:12:21 -0400
Received: from mk-outboundfilter-2.mail.uk.tiscali.com ([212.74.114.38]:40652
	"EHLO mk-outboundfilter-2.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754784AbYCVMMV (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Mar 2008 08:12:21 -0400
X-Trace: 37014738/mk-outboundfilter-2.mail.uk.tiscali.com/PIPEX/$ACCEPTED/pipex-customers/81.86.57.226
X-SBRS: None
X-RemoteIP: 81.86.57.226
X-IP-MAIL-FROM: osronline@glidos.net
X-IP-BHB: Once
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AiYBAPaT5EdRVjni/2dsb2JhbAAIqEc
X-IP-Direction: IN
Received: from 81-86-57-226.dsl.pipex.com (HELO [10.0.0.24]) ([81.86.57.226])
  by smtp.pipex.tiscali.co.uk with ESMTP; 22 Mar 2008 12:12:18 +0000
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
In-Reply-To: <32541b130803211039h1f5b8da5k8fb353d46e57b05e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77799>

Avery Pennarun wrote:
> Alternatively, we could avoid tracking anything extra at all.  If git
> could suggest a branch or tag that mine is "currently closest to",
> ie., the one that has as many of the commits from my branch as
> possible (even if it has additional commits that I don't have), then
> that might be the branch I'm interested in.

Yes, that's exactly what I need too. I need to produce it
programatically. I notice gitk displays, for each commit,
the branches that include it. If I knew a command for
deriving that, I could iterate through HEAD, HEAD~1, HEAD~2...
until I see a remote branch.

P.
