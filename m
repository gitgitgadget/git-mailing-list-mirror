From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git diff across submodules
Date: Tue, 18 Sep 2012 21:02:19 +0200
Message-ID: <5058C53B.5040401@web.de>
References: <1347937959.96154.YahooMailClassic@web39403.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kenny Simpson <theonetruekenny@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 21:02:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE348-00064t-75
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 21:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683Ab2IRTC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 15:02:28 -0400
Received: from mout.web.de ([212.227.17.12]:59386 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752166Ab2IRTC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 15:02:27 -0400
Received: from [192.168.178.41] ([91.3.171.24]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0MPowc-1TADZV3XF4-005FuB; Tue, 18 Sep 2012 21:02:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <1347937959.96154.YahooMailClassic@web39403.mail.mud.yahoo.com>
X-Provags-ID: V02:K0:fmRxRHn2ny0GbpeqS4M7CSvzs5cLnImusrlm0ZeWZXN
 7oekGvuDxKvp88D7Rb1duVOYHR0p4qx3Jn29clcr7GqH1D33hk
 80aYeRuc2YSeQ38aS9XWlyBZlIeFGumNPehXVY73SSehW89tCx
 3efqEnA3PRE2If7nNF982UWmhryzLLVBdjHM+wCW2mSILWSfH9
 /cJOVsmACwa448IG5mLWg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205849>

Am 18.09.2012 05:12, schrieb Kenny Simpson:
>   Is there any nice way to get a diff and/or diffstat of both a project and its submodules between two revisions of the main project?
> 
> Something like 'git diff --stat tag_a tag_b' but also including the diffstat on the submodule from the revision tied to in tag_a to the revision tied to tag_b.  A few shell backflips will do it, but this seems like I'm missing something.

Unfortunately that isn't possible yet, "git diff" still has to learn the
--recurse-submodules option. And as far as I know, nobody is currently
working on that.
