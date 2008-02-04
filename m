From: Paul Gardiner <osronline@glidos.net>
Subject: Re: New to git: sorry for obvious question.
Date: Mon, 04 Feb 2008 12:04:59 +0000
Message-ID: <47A6FF6B.1000103@glidos.net>
References: <47A6E130.7090909@glidos.net> <20080204105006.GA15855@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 04 13:05:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM04z-0001A6-FY
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 13:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbYBDMFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 07:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751817AbYBDMFJ
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 07:05:09 -0500
Received: from mk-outboundfilter-2.mail.uk.tiscali.com ([212.74.114.38]:55174
	"EHLO mk-outboundfilter-2.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751593AbYBDMFI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Feb 2008 07:05:08 -0500
X-Trace: 128902/mk-outboundfilter-2.mail.uk.tiscali.com/PIPEX/$MX-ACCEPTED/pipex-infrastructure/62.241.163.6
X-SBRS: None
X-RemoteIP: 62.241.163.6
X-IP-MAIL-FROM: osronline@glidos.net
X-IP-BHB: Once
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CALOOpkc+8aMG/2dsb2JhbACqZg
X-IP-Direction: IN
Received: from astro.systems.pipex.net ([62.241.163.6])
  by smtp.pipex.tiscali.co.uk with ESMTP; 04 Feb 2008 12:05:04 +0000
Received: from [10.0.0.24] (80-42-19-184.dynamic.dsl.as9105.com [80.42.19.184])
	by astro.systems.pipex.net (Postfix) with ESMTP id 612D8E000099
	for <git@vger.kernel.org>; Mon,  4 Feb 2008 12:05:01 +0000 (GMT)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <20080204105006.GA15855@bit.office.eurotux.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72494>

Luciano Rocha wrote:
> On Mon, Feb 04, 2008 at 09:56:00AM +0000, Paul Gardiner wrote:
>>  Hi,
>>
>>  I've moved a project from CVS on sourceforge to git on repo.or.cz.  I
>>  want a local mirror on my own home server, so that it appears amongst
>>  the projects shown by my own gitweb set up, and so it gets caught by
>>  my backup system.  I've created the mirror with
>>
>>    git clone --bare <remote-url> <local-dir>
>>
>>  and that seems fine.  But how do I now keep it up to date.  I was
>>  guessing a cron job doing some sort of git pull, but pull doesn't
>>  look to work on --bare proj.git type repositories.
> 
> You want git fetch. Git pull also updates the working copy, which you
> don't have.
> 
> Also, git clone --bare doesn't set up the origin configuration, and I
> have to do it by hand:
>   git config remote.origin.url "$url"
>   git config remote.origin.fetch "+refs/heads/*:refs/heads/*"

Brilliant!! That works.

So why wouldn't git-fetch work when, instead of setting up the origin
config, I put the url and refspec on the commandline? - not that it
matters, just interested.

Cheers,
	Paul.
