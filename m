From: Ralf Ebert <info@ralfebert.de>
Subject: Re: [PATCH] More readable 'Not a git repository' messages
Date: Tue, 10 Aug 2010 01:34:41 +0200
Message-ID: <i3q3ah$upb$1@dough.gmane.org>
References: <i3pdkj$hut$1@dough.gmane.org> <AANLkTinttmKi4+EbE54r-GeRbN3_2wxUHu_qJMn5Nysn@mail.gmail.com> <i3q0d8$m8f$1@dough.gmane.org> <20100809230132.GG4429@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 10 01:35:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oibru-00088W-8s
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 01:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757245Ab0HIXex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 19:34:53 -0400
Received: from lo.gmane.org ([80.91.229.12]:38097 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757140Ab0HIXew (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 19:34:52 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Oibrm-00085Z-RX
	for git@vger.kernel.org; Tue, 10 Aug 2010 01:34:50 +0200
Received: from port-92-198-61-236.static.qsc.de ([92.198.61.236])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 01:34:50 +0200
Received: from info by port-92-198-61-236.static.qsc.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 01:34:50 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: port-92-198-61-236.static.qsc.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.11) Gecko/20100713 Thunderbird/3.0.6
In-Reply-To: <20100809230132.GG4429@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153054>

Hi Jonathan,

> I hope not, since then the returned cwd value would be useless
> for restoring the original cwd later.

yes, right, I misread the code, thanks for taking the time to correct 
me. My C knowledge is dated to say least and being succumbed by all the 
syntax sugar of dynamic languages, I misread
if (chdir("..")) { ... }
as "if changing the directory worked ok" :)

> Shameless plug: you may find the version in commit 98937be (i.e.
> branch jn/maint-setup-fix in pu) more readable. :)

I do, I guess it makes sense to rework the patch on top of that.

What I also wanted to try is make the GIT_DISCOVERY_ACROSS_FILESYSTEM 
warning go away for crypto home volumes, because that's kind of common 
and nobody needs git to discover repositories in this case. Only need to 
come up with an idea how to detect this case.

--
Ralf
