From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: How to find out which gitignore blocks my git-add
Date: Sat, 7 Feb 2009 01:33:43 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngopp7n.his.sitaramc@sitaramc.homelinux.net>
References: <498C0525.5040100@gonsolo.de>
 <20090206193359.GF19494@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 07 02:35:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVc6J-0004I2-8W
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 02:35:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523AbZBGBdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 20:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752376AbZBGBdw
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 20:33:52 -0500
Received: from main.gmane.org ([80.91.229.2]:59627 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752268AbZBGBdv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 20:33:51 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LVc4t-0008HB-Rd
	for git@vger.kernel.org; Sat, 07 Feb 2009 01:33:51 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 01:33:51 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 01:33:51 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108806>

On 2009-02-06, Jeff King <peff@peff.net> wrote:
> On Fri, Feb 06, 2009 at 10:38:45AM +0100, Gonzo wrote:
>> Is there an easy way to find out which line in which gitignore file  
>> blocks this add?
>
> No, I don't think so.
>
>> Would this be a viable addition to "git add -v"?
>
> I think it might be useful to be able to get this information. However,
> rather than coupling it with "git add", it might make more sense to have
> a separate way to query "is this being ignored, and if so, by what
> pattern". Then you could use that tool to generally debug your
> .gitignore patterns.

maybe GIT_TRACE could print that as well, in some way?
