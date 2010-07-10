From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: Cutting history
Date: Fri, 09 Jul 2010 22:08:46 -0600
Message-ID: <4C37F24E.30407@workspacewhiz.com>
References: <20100710032553.GB554@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: weigelt@metux.de
X-From: git-owner@vger.kernel.org Sat Jul 10 06:08:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXRN2-00057w-U6
	for gcvg-git-2@lo.gmane.org; Sat, 10 Jul 2010 06:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746Ab0GJEIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jul 2010 00:08:48 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:57322 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705Ab0GJEIr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jul 2010 00:08:47 -0400
Received: (qmail 18310 invoked by uid 399); 9 Jul 2010 22:08:46 -0600
Received: from unknown (HELO ?192.168.1.100?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 9 Jul 2010 22:08:46 -0600
X-Originating-IP: 76.27.116.215
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.4) Gecko/20100608 Lightning/1.0b2 Thunderbird/3.1
In-Reply-To: <20100710032553.GB554@nibiru.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150709>

  ----- Original Message -----
From: Enrico Weigelt
Date: 7/9/2010 9:25 PM
> I'm using git for automatic backups (eg. database dumps). This
> works quite well, but as time goes, the history (and so the repo)
> gets larger and larger. It would be really nice to allow cutting
> off old stuff (eg. after N commits in the past).
>
> Maybe that could be done by introducing "stopper" tags: commits
> that have an stopper-tag may have missing parents, and git-gc
> can be told to ignore those parents and throw away everything
> behind the stopper (if not referenced otherwise).
>
> A probably cleaner, but more invasive way could be making refs
> to vectors, which may contain stop points (multiple ones in case
> of merges) additionally to the start point. Remote transmits only
> contain the commits within this range, and GC also just scans
> the range (instead of following all parents).
Your post reminded me of this: http://progit.org/2010/03/17/replace.html

Josh
