From: Paul Gardiner <osronline@glidos.net>
Subject: Re: How to find where a branch was taken from.
Date: Sat, 22 Mar 2008 16:54:56 +0000
Message-ID: <47E539E0.3030701@glidos.net>
References: <47E37A63.9070209@glidos.net> <7v4pb0qw28.fsf@gitster.siamese.dyndns.org> <32541b130803211039h1f5b8da5k8fb353d46e57b05e@mail.gmail.com> <47E4F7A0.6060702@glidos.net> <20080322164136.GA7611@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	osronline@glidos.net
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 22 17:55:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd70W-0001tV-QZ
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 17:55:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620AbYCVQzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 12:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbYCVQzD
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 12:55:03 -0400
Received: from mk-outboundfilter-2.mail.uk.tiscali.com ([212.74.114.38]:35095
	"EHLO mk-outboundfilter-2.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751905AbYCVQzB (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Mar 2008 12:55:01 -0400
X-Trace: 37261708/mk-outboundfilter-2.mail.uk.tiscali.com/PIPEX/$ACCEPTED/pipex-customers/81.86.57.226
X-SBRS: None
X-RemoteIP: 81.86.57.226
X-IP-MAIL-FROM: osronline@glidos.net
X-IP-BHB: Once
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AiYBAMPW5EdRVjni/2dsb2JhbAAIqDI
X-IP-Direction: IN
Received: from 81-86-57-226.dsl.pipex.com (HELO [10.0.0.24]) ([81.86.57.226])
  by smtp.pipex.tiscali.co.uk with ESMTP; 22 Mar 2008 16:54:59 +0000
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
In-Reply-To: <20080322164136.GA7611@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77824>

Jeff King wrote:
> On Sat, Mar 22, 2008 at 12:12:16PM +0000, Paul Gardiner wrote:
> 
>> Yes, that's exactly what I need too. I need to produce it
>> programatically. I notice gitk displays, for each commit,
>> the branches that include it. If I knew a command for
>> deriving that, I could iterate through HEAD, HEAD~1, HEAD~2...
>> until I see a remote branch.
> 
> How about:
> 
>   git name-rev --refs='refs/remotes/*' $COMMIT

Wow! That's clever.

Thanks,
	Paul.
