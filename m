From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: "git-pull --no-commit" should imply --no-ff...?
Date: Sun, 22 Jun 2008 16:01:59 +0200
Message-ID: <485E5B57.5000307@s5r6.in-berlin.de>
References: <tkrat.5aa5af8e9968819c@s5r6.in-berlin.de> <20080622133606.GA21828@endor.mknod.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 22 16:03:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAQA3-0006zz-9H
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 16:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447AbYFVOCY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 10:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752367AbYFVOCY
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 10:02:24 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:34281 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447AbYFVOCX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 10:02:23 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from [192.168.0.42] ([83.221.231.7])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id m5ME2E5U008073
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sun, 22 Jun 2008 16:02:19 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.13) Gecko/20080614 SeaMonkey/1.1.9
In-Reply-To: <20080622133606.GA21828@endor.mknod.org>
X-Enigmail-Version: 0.95.6
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85773>

Graham Wilson wrote:
> On Sat, Jun 21, 2008 at 04:08:51PM +0200, Stefan Richter wrote:
>> trying "git pull --no-commit . foo" for the first time, I was confused
>> that --no-commit was a no-op when the pull resulted in a fast-forward.
>> I.e. HEAD advanced the whole chain of commits to foo.  I expected it to
>> apply the diff of HEAD..foo but not commit them.
> 
> --no-commit to me seems to mean don't commit a merge commit. Maybe what
> you want is something like:
> 
>  git-diff HEAD foo | git-apply
> 

Yes, I obviously got the wrong idea about git-pull --no-commit.
git-diff + git-apply indeed accomplishes what I wanted to do.  Thanks,
-- 
Stefan Richter
-=====-==--- -==- =-==-
http://arcgraph.de/sr/
