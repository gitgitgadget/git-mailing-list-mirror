From: Arafangion <thestar@fussycoder.id.au>
Subject: Re: inted problems when upgrading to 1.6.0.4
Date: Tue, 25 Nov 2008 21:20:20 +1100
Message-ID: <1227608420.3222.2.camel@therock.nsw.bigpond.net.au>
References: <492BC56A.6040506@xmos.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Luis Gutierrez <luis.gutierrez@xmos.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 11:11:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4usl-0000XP-7i
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 11:10:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbYKYKJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 05:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752265AbYKYKJp
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 05:09:45 -0500
Received: from nschwmtas05p.mx.bigpond.com ([61.9.189.149]:23276 "EHLO
	nschwmtas05p.mx.bigpond.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752251AbYKYKJo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Nov 2008 05:09:44 -0500
Received: from nschwotgx03p.mx.bigpond.com ([58.173.132.215])
          by nschwmtas05p.mx.bigpond.com with ESMTP
          id <20081125100942.UTTV1796.nschwmtas05p.mx.bigpond.com@nschwotgx03p.mx.bigpond.com>;
          Tue, 25 Nov 2008 10:09:42 +0000
Received: from therock.local ([58.173.132.215])
          by nschwotgx03p.mx.bigpond.com with ESMTP
          id <20081125100937.ZXJN7031.nschwotgx03p.mx.bigpond.com@therock.local>;
          Tue, 25 Nov 2008 10:09:37 +0000
In-Reply-To: <492BC56A.6040506@xmos.com>
X-Mailer: Evolution 2.6.3 
X-RPD-ScanID: Class unknown; VirusThreatLevel unknown, RefID str=0001.0A150205.492BCEE1.00C6,ss=1,fgs=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101654>

On Tue, 2008-11-25 at 09:29 +0000, Luis Gutierrez wrote:
<snip>
> All push/pull/clone operations were failing with the dreaded 'fatal: The 
> remote end hung up unexpectedly'. After a few tests, this is what I found:
> 
> - I can clone/pull/push if I do it through ssh (ie, git clone 
> ssh://server/project)
> - I can clone/pull/push if I start git daemon on the command line through
> git daemon --syslog --verbose --export-all 
> --base-path=/vol0/git/projects --verbose --reuseaddr
> 
> But the way I had setup git, through xinetd is broken.

I'm just guessing, as I'm too new to the git world to respond with more
expertise, but I will suggest that perhaps your problem is that your
$PATH is different with the xinitd configuration as contrasted with your
ssh configuration, as the locations of the git binaries could be
different.
