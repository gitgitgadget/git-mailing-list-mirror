From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: rebase [-i --exec | -ix] <CMD>...
Date: Thu, 07 Jun 2012 19:57:10 +0200
Message-ID: <4FD0EB76.90501@web.de>
References: <4FD0D375.9060902@web.de> <1339087582-10040-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: tboegi@web.de, git@vger.kernel.org
To: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 07 19:57:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScgxT-0006ji-L5
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 19:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633Ab2FGR5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 13:57:14 -0400
Received: from mout.web.de ([212.227.17.12]:55699 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932414Ab2FGR5O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 13:57:14 -0400
Received: from birne.lan ([194.22.188.61]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0Lk8gg-1S661t19EA-00cE0l; Thu, 07 Jun 2012 19:57:11 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:13.0) Gecko/20120601 Thunderbird/13.0
In-Reply-To: <1339087582-10040-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
X-Provags-ID: V02:K0:uJ/QF9vvh6lT0UAkbwldh2tfA1x6ViZf5jMQtlVEXdj
 q7QezwBffqY1CuGykIh49B9P8DMZViRJtuwmo7jgq6g9w4SnbY
 L/6o9lG6a44lsIzLMlCVdYQF6qGgzjkyEN+v9YJeAFxrGZnW0O
 Cb+k+e6zzNvEIIp58OFn4R0Homhduw98kHOOsDFy72Ct3r//nP
 dBcMiLE7dLsG2DPffhwqA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199429>

Still no success :-(
Please see below:



git checkout a63d7ed3017e312ddc752ac89a7d292
tb@birne:~/projects/git/git.git> git am --abort ; git am < 1339089425.H311811P3927.appes.lan\:2\,S

Applying: rebase [-i --exec | -ix] <CMD>...
error: patch failed: Documentation/git-rebase.txt:8
error: Documentation/git-rebase.txt: patch does not apply
error: patch failed: git-rebase--interactive.sh:684
error: git-rebase--interactive.sh: patch does not apply
error: patch failed: git-rebase.sh:3
error: git-rebase.sh: patch does not apply
error: patch failed: t/t3404-rebase-interactive.sh:755
error: t/t3404-rebase-interactive.sh: patch does not apply
Patch failed at 0001 rebase [-i --exec | -ix] <CMD>...
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".
