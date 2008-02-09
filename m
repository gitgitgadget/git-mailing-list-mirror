From: Paul Gardiner <osronline@glidos.net>
Subject: Re: All I wanted was git-fast-export
Date: Sat, 09 Feb 2008 22:44:47 +0000
Message-ID: <47AE2CDF.4090208@glidos.net>
References: <47ADE275.3060109@glidos.net> <alpine.LSU.1.00.0802091803580.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 09 23:45:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNySD-00088U-Da
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 23:45:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754169AbYBIWoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 17:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754224AbYBIWoy
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 17:44:54 -0500
Received: from mk-outboundfilter-1.mail.uk.tiscali.com ([212.74.114.37]:58570
	"EHLO mk-outboundfilter-1.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753695AbYBIWox (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Feb 2008 17:44:53 -0500
X-Trace: 37523260/mk-outboundfilter-1.mail.uk.tiscali.com/PIPEX/$MX-ACCEPTED/pipex-infrastructure/62.241.162.31
X-SBRS: None
X-RemoteIP: 62.241.162.31
X-IP-MAIL-FROM: osronline@glidos.net
X-IP-BHB: Once
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAEK7rUc+8aIf/2dsb2JhbACoBQ
X-IP-Direction: IN
Received: from galaxy.systems.pipex.net ([62.241.162.31])
  by smtp.pipex.tiscali.co.uk with ESMTP; 09 Feb 2008 22:44:50 +0000
Received: from [10.0.0.24] (80-42-19-184.dynamic.dsl.as9105.com [80.42.19.184])
	by galaxy.systems.pipex.net (Postfix) with ESMTP id E88F8E000088
	for <git@vger.kernel.org>; Sat,  9 Feb 2008 22:44:49 +0000 (GMT)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <alpine.LSU.1.00.0802091803580.11591@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73272>

Johannes Schindelin wrote:
> Hi,
> 
> On Sat, 9 Feb 2008, Paul Gardiner wrote:
> 
>> With your kind help, I've been able to convert a cvs repository
>> to git, but the last several years commits start with a line
>> saying "Summary;" :-(  I thought it might not be hard to put
>> a filter between git-fast-export and git-fast-import to sort
>> it out.
> 
> The better tool for this should be filter-branch.

filter-branch does look to be brilliant for this sort of thing,
but I don't think I can use it in my case. The git repository
in question is a mirror of a live cvs repository, which I need
to keep synced up. What I was thinking was to repeatedly do:

   cvs rep  =>  git rep   => tidied git rep


using fromcvs/togit for the first step, and
git-fast-export/git-fast-import for the second. It doesn't
look to be the case that filter-branch can be used with
the source and target repositories being different, and
if I tried having one git repository that I applied
tidying to, then I don't think the syncing process would
work afterwards... or would it? Do you thing that changing
commit messages would mess up subsequent syncing? I
guess I could try it and see.

I think I need git 1.5.4 either way, and I still
haven't found a way to get that installed under SuSE 10.3

P.
