From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Submodule commits not show by git log
Date: Fri, 24 Feb 2012 21:45:48 +0100
Message-ID: <4F47F6FC.6010602@web.de>
References: <CAMJPRQz09EwnRcMssQDRb4Pj_HZmfuxrJC0Bw6Ka4sA5gfYkWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Wilfred Hughes <wilfred@potatolondon.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 21:46:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S121b-0007gn-Nb
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 21:45:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756983Ab2BXUpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 15:45:51 -0500
Received: from fmmailgate06.web.de ([217.72.192.247]:54616 "EHLO
	fmmailgate06.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755468Ab2BXUpu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 15:45:50 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate06.web.de (Postfix) with ESMTP id D7209CD0871
	for <git@vger.kernel.org>; Fri, 24 Feb 2012 21:45:48 +0100 (CET)
Received: from [192.168.178.48] ([91.3.180.241]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MZleQ-1RjuqI28kQ-00LFRD; Fri, 24 Feb 2012 21:45:48
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <CAMJPRQz09EwnRcMssQDRb4Pj_HZmfuxrJC0Bw6Ka4sA5gfYkWw@mail.gmail.com>
X-Provags-ID: V02:K0:EcoGHsjKhgXti3AuTaK+iSYbIhqkc/DyM/O6UONwqlI
 gaILukMKnfdrBAzC3X80Td/kogt3qic365pqdaS0PjsR1+3GuZ
 4FNhE/QL4HFDTVXvpDBA1KeggPgNU1pqnyyaSNfLfuMq8ni9tT
 FheLEkOKxMS7KIh/DAW9tz816GjDkGgk13PWc2ew51Mo4zTR4e
 ry6djgktRB0aguZs+uhIQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191471>

Am 23.02.2012 17:49, schrieb Wilfred Hughes:
> Hi all,
> 
> I'm trying to track changes on a git submodule. `$ git log
> path/to/submodule` is not showing any commits that changed the
> submodule commit.
> 
> For example, in my repo I have a submodule at the path
> ./memcache_utils that has had the commit referenced changed several
> times. It's definitely a submodule:
> 
> $ git submodule
> 
> 13eb087304b995705693d6f0927dec2d88dfadaf datastore_utils
> (heads/master-2-g13eb087)
>  7f5d6710b767a27f14e3e7bc009f026b3e5f0e74 memcache_utils (heads/master)
>  5877e2c2d82645fa44f121884291ee48cf24584d potatobase (5877e2c)
> 
> Yet the only commit shown is when there were files at that path:
> 
> $ git log memcache_utils
> commit 2cbe65bf31901873b01331e95fec72724e7458eb
> Author: [...]
> Date:   Thu Jan 26 20:44:07 2012 +0000
> 
>     Experimenting with Paul G's port of cache-machine. It should
> really be a git submodule but just want to see how it works so have
> taken a copy from [...]
> $
> 
> Have I missed something? I've tried and failed to create a minimal
> test case that demonstrates this behaviour. I can't see anything in
> the man pages to suggest that I'm using git log incorrectly, and
> Googling doesn't help.
> 
> Is this user error, a known bug, or a new one?

That is strange, I can't reproduce your problem here. It would be
great if you could give me access to your repo (you can also mail
me privately if you don't want to disclose the repo to the public).
And what version of git are you using?
