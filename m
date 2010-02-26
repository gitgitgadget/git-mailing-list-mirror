From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Different Fetch and Push URLs?
Date: Fri, 26 Feb 2010 16:18:56 +0100
Message-ID: <4B87E660.7010401@dbservice.com>
References: <c115fd3c1002260701u11cf506fq747d7217d31eba59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 16:49:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nl2RJ-0007HJ-VM
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 16:49:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965187Ab0BZPtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 10:49:12 -0500
Received: from office.neopsis.com ([78.46.209.98]:44892 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965185Ab0BZPtL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 10:49:11 -0500
X-Greylist: delayed 1810 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Feb 2010 10:49:10 EST
Received: from calvin.caurea.org ([147.88.200.112])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Fri, 26 Feb 2010 16:18:57 +0100
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <c115fd3c1002260701u11cf506fq747d7217d31eba59@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141135>

On 2/26/10 4:01 PM, Tim Visher wrote:
> Hello Everyone,
>
> My work situation leaves me in a situation where I can clone from my
> central repo but I can't push there.  Is it possible and does it make
> any sense to have a single remote with one URL that I pull from and
> another than I push to?  I only ask because I was looking at the
> output of `git remote show` and noticed that there are 2 URLs.  If it
> is possible, how do I do it?  I looked in `.git/config` and there's
> only 1 URL there.
>
> I am aware that I could have 2 remotes and simply consciously remember
> to only push to the one that I have access to.  This is what I usually
> do but the scenario I describe above seems nicer to me.

git config remote.origin.pushurl <your push url>

(see the git-config(1) man page for more details)

tom
