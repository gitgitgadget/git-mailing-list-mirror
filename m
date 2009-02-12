From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: showing SHA1 of parent commit in tig [was Re: [ANNOUNCE] tig-0.14
Date: Thu, 12 Feb 2009 03:28:40 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngp75r8.q57.sitaramc@sitaramc.homelinux.net>
References: <20090205204436.GA6072@diku.dk> <20090206104946.GE7259@b2j>
 <2c6b72b30902060629i2539ddds48ab858e83d4bb4@mail.gmail.com>
 <slrngooljv.urh.sitaramc@sitaramc.homelinux.net>
 <2c6b72b30902080207m4a1e14b7j4862f9a8b7ca32a9@mail.gmail.com>
 <slrngp5tqk.u46.sitaramc@sitaramc.homelinux.net>
 <2c6b72b30902111719r6fd25dc7uc22b471f7904bedc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 04:30:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXSHX-0005aa-6V
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 04:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756696AbZBLD3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 22:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756703AbZBLD27
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 22:28:59 -0500
Received: from main.gmane.org ([80.91.229.2]:57144 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755515AbZBLD26 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 22:28:58 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LXSFx-0005Tl-9M
	for git@vger.kernel.org; Thu, 12 Feb 2009 03:28:53 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 03:28:53 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 03:28:53 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109569>

On 2009-02-12, Jonas Fonseca <jonas.fonseca@gmail.com> wrote:
> On Wed, Feb 11, 2009 at 17:05, Sitaram Chamarty <sitaramc@gmail.com> wrote:
>> Is there any way to see the sha1 of the parent commit in any
>> of the displays, like gitk does?
>>
>> I know you're only parsing the 4 or 5 basic git commands,
>> and none of those do, so I guess I know the answer :-( but
>> it doesn't hurt to ask.
>
> It is sort of possible by setting the TIG_DIFF_CMD environment
> variable to something appropriate, for example using (and I don't know
> if this will be formatted correctly):
>
> export TIG_DIFF_CMD='git show -p --stat -C -M
> --pretty=format:commit%x20%H%d%nAuthor:%x20%an%x20<%ae>%x20%ai%nParent:%x20%P%nSubject:%x20%s%n%n%b
> %(commit)'
>
> You need to avoid using space except for where it really separates
> arguments, which is why the obscure %x20 is used. ;)
>
> Another solution would be to create a script, which just expects the
> commit SHA1 as its first argument and then do the formatting there and
> then use:
>
> export TIG_DIFF_CMD="/my/script %(commit)"

OK thanks -- I'll give that a shot when I get a chance.

Regards,

Sitaram
