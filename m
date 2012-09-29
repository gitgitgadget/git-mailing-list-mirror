From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] submodule: make 'show' an alias for 'summary'
Date: Sat, 29 Sep 2012 16:49:56 +0200
Message-ID: <50670A94.2070504@web.de>
References: <1348926195-4788-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 16:50:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THyMt-0003Mh-S2
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 16:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755359Ab2I2OuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 10:50:00 -0400
Received: from mout.web.de ([212.227.17.12]:62752 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755298Ab2I2OuA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2012 10:50:00 -0400
Received: from [192.168.178.41] ([91.3.175.36]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0M8iH2-1TAIrx0WqK-00Cm3N; Sat, 29 Sep 2012 16:49:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <1348926195-4788-1-git-send-email-artagnon@gmail.com>
X-Provags-ID: V02:K0:B5CR+52q2lEA9mpaSM73WJ2nqVOEwt5YfAsYaGJ5fPP
 WzjX8e69wmVQo+RC1VEJZfuTvmB1LWFl5fI3WtH22fGIDVqjew
 ASQG2Nz6nDdjjphhm1BeFegZI6PWGtkILN8wJjYTBR6QHJE8xl
 6gb07eQ9O7cdvL/oDrDiHZ5AIGiohXSU98SF8Lynh6xfC5CMK+
 zgwJQjwnAgB8Tj5lJKAWg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206651>

Am 29.09.2012 15:43, schrieb Ramkumar Ramachandra:
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Like 'git remote show', 'git stash show'.

I understand the analogy to "git stash show" (as that also displays
a diff similar to what " git submodule summary" does). But "git
remote show" just displays a list of configured remotes, which is
something different. And the other command with a "show" option is
"git notes show", which causes it to display a note. So I think we
are pretty inconsistent here and I see no advantage of adding such
an alias for "git submodule summary". What am I missing?
