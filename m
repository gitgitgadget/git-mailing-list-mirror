From: Tait <git.git@t41t.com>
Subject: Re: What's the status of MinGW port.
Date: Mon, 8 Sep 2008 11:18:48 -0700
Message-ID: <20080908181848.GI27478@ece.pdx.edu>
References: <42b562540809072128o62854572y1eb8d2e69e7193f1@mail.gmail.com> <42b562540809072134xed61f0as6f1201a641ec973c@mail.gmail.com> <48C4CF58.4020906@viscovery.net> <20080908110333.GH27478@ece.pdx.edu> <48C50B76.7070506@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 08 20:20:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KclLI-00067j-4m
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 20:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403AbYIHSSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 14:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753454AbYIHSSw
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 14:18:52 -0400
Received: from ehlo.cat.pdx.edu ([131.252.208.106]:51648 "EHLO
	ehlo.cat.pdx.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814AbYIHSSv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 14:18:51 -0400
Received: from nemo.ece.pdx.edu (root@nemo.ece.pdx.edu [131.252.209.162])
	by ehlo.cat.pdx.edu (8.14.2/8.14.2/Debian-2build1) with ESMTP id m88IInSa012853
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 8 Sep 2008 11:18:49 -0700
Received: from nemo.ece.pdx.edu (tait@localhost [127.0.0.1])
	by nemo.ece.pdx.edu (8.13.6/8.13.1) with ESMTP id m88IImRQ015328
	for <git@vger.kernel.org>; Mon, 8 Sep 2008 11:18:49 -0700 (PDT)
Received: (from tait@localhost)
	by nemo.ece.pdx.edu (8.13.6/8.12.6/Submit) id m88IImfo015327
	for git@vger.kernel.org; Mon, 8 Sep 2008 11:18:48 -0700 (PDT)
X-Authentication-Warning: nemo.ece.pdx.edu: tait set sender to git.git@t41t.com using -f
Content-Disposition: inline
In-Reply-To: <48C50B76.7070506@op5.se>
User-Agent: Mutt/1.5.7i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ehlo.cat.pdx.edu [131.252.208.106]); Mon, 08 Sep 2008 11:18:49 -0700 (PDT)
X-Spam-Status: No, score=0.0 required=6.0 tests=none autolearn=failed
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on ehlo.cat.pdx.edu
X-Virus-Scanned: ClamAV 0.92.1/8192/Mon Sep  8 08:51:25 2008 on ehlo.cat.pdx.edu
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95284>

>>>>      Is there any plan to create a native version of GIT on MS Windows?
>>>There are no plans anymore to create such a thing.
>>
>>Out of curiosity, any particular reason why not?
>
> He mentioned it in the very next sentence: It already exists.
>
> I guess this is beyond your attention span...

The personal attack was unnecessary, and no, I'm not inattentive, thank you.

My understanding is that MinGW is a POSIX emulation layer; the underlying
code is still using POSIX functions like fork and exec that aren't native
to Windows. When I said "native" I meant "not POSIX" -- i.e. using the
Windows API directly instead of through some kind of munging layer.

So I'll ask again, is there any particular reason why a _native_ Windows
Git hasn't been attempted (or was abandoned, or whatever)?
