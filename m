From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC/PATCH 0/2] submodule: drop the top-level requirement
Date: Sun, 07 Apr 2013 22:15:07 +0200
Message-ID: <5161D3CB.8090101@web.de>
References: <cover.1365364193.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Apr 08 08:45:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5p9-0000sy-0x
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933494Ab3DGUPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 16:15:10 -0400
Received: from mout.web.de ([212.227.17.12]:56367 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933407Ab3DGUPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 16:15:09 -0400
Received: from [192.168.178.41] ([79.193.80.33]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0LZeYO-1UsXeZ34Zw-00lsFg; Sun, 07 Apr 2013 22:15:08
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <cover.1365364193.git.john@keeping.me.uk>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:D9xtPi/l3HYMBBxPEGI+db2mQpwvB8okCJcMyUBfp0h
 +HjfKKXbUvCX1O108AXzDJssZqzhFSSSqDleeJTGFXRFHnov8n
 P6fQwRDMkkKL4E+WvnCWQhAZBufBWbQjiFcKA+t+4HdHBDZt+w
 O5iltQ2Qt3FG7Kq1nfAPYzDbCHotyXsk0r7xsA4Y6g1EA/pWwX
 UyLfh/hHB4cj7D1l/O8+A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220370>

Am 07.04.2013 21:55, schrieb John Keeping:
> With the recent discussion, I wondered how hard it would be to add
> SUBDIRECTORY_OK=Yes to git-submodule.sh and it doesn't seem that bad.
> 
> Note that this series currently lacks both tests and documentation
> updates.  Also I have made no attempt to change the output from any
> commands, so submodule paths are always printed relative to the
> top-level of the repository.
> 
> Consider this series a proof-of-concept, to see whether I'm on
> completely the wrong course.

Cool! Thanks for working on that, I'll take a deeper look in my next
Git timeslot.

> John Keeping (2):
>   rev-parse: add --filename-prefix option
>   submodule: drop the top-level requirement
> 
>  builtin/rev-parse.c | 17 ++++++++++++-----
>  git-submodule.sh    |  7 +++++++
>  2 files changed, 19 insertions(+), 5 deletions(-)
> 
