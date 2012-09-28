From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: git gui does not open bare repositories
Date: Fri, 28 Sep 2012 10:44:56 +0200
Message-ID: <50656388.3050400@atlas-elektronik.com>
References: <CAB9Jk9CA+e8xR9sz7cW+5+990FmTeYN3pjxs4ZKFpkzb6OL35Q@mail.gmail.com> <CAH6sp9N1cFH7orPNmfbhgHq6oUNtQNe=-5f5jkYNXzr+6Xp_pQ@mail.gmail.com> <CAB9Jk9BivVrH7daMR=u5Y6Ut=pZGRBcgKNZ_afZ53XFxhFBnZw@mail.gmail.com> <CAH6sp9ME0og0E-=oW6MBFMBv8hD0y8PpmdpyaV4qqr7Mb7c5VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>,
	git <git@vger.kernel.org>
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 10:53:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THWJx-0007jc-N3
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 10:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755401Ab2I1IxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 04:53:07 -0400
Received: from mail96.atlas.de ([194.156.172.86]:18862 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751345Ab2I1IxD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 04:53:03 -0400
X-Greylist: delayed 483 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Sep 2012 04:53:03 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 57668100F0;
	Fri, 28 Sep 2012 10:44:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id 3xpqRmfBCnHl; Fri, 28 Sep 2012 10:44:57 +0200 (CEST)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Fri, 28 Sep 2012 10:44:57 +0200 (CEST)
Received: from [141.200.59.243] (pcndmc01.atlas.de [141.200.59.243])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 459922716A;
	Fri, 28 Sep 2012 10:44:57 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <CAH6sp9ME0og0E-=oW6MBFMBv8hD0y8PpmdpyaV4qqr7Mb7c5VA@mail.gmail.com>
X-Enigmail-Version: 1.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206546>

Am 28.09.2012 10:35, schrieb Frans Klaver:
> Hi,
> 
> Please remember to reply to all when discussing things on the git mailing list.
> 
> On Fri, Sep 28, 2012 at 10:29 AM, Angelo Borsotti
> <angelo.borsotti@gmail.com> wrote:
>> Hello
>>
>> I apologise for having used the wrong script to reproduce the error.
>> This is  the right one:
>>
>> angelo@ANGELO-PC /d/gtest (master)
>> $ mkdir remote.git
>>
>> angelo@ANGELO-PC /d/gtest (master)
>> $ cd remote.git
>>
>> angelo@ANGELO-PC /d/gtest/remote.git (master)
>> $ git init --bare
>> Initialized empty Git repository in d:/gtest/remote.git/
>>
>> Now with the git gui I try to open the d:/gtest/remote.git/ and
>> receive the message
>> that it is not a git repository.
>>
>> I understand that the gui is mostly aimed to non-bare repositories,
>> but in such a case
>> it would be better it could give me a message like, e.g. "could not
>> open a bare repository"
>> instead of telling me that it is not a git repository (I thought my
>> bare repository was
>> corrupt, and tried to figure out what was wrong with it).
> 
> 
> Actually git-gui 0.16.0 is telling me that it cannot use bare
> repositories, much in the vein of what I wrote earlier. Don't know if
> it matters that I'm on Linux though.

I get "Not a Git repository: remote.git" as well, when I run
git gui "somewhere" (i.e. not in "remote.git") and the select 
"Open Existing Repository".

I get "Cannot use bare repository: .../remote.git" when I run git gui
from inside the "remote.git" directory.

Both on WinXP with msysGit.

Stefan
-- 
----------------------------------------------------------------
/dev/random says: Unless you're the lead dog, the view never changes.
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6e696b2e636f6d'.decode('hex')"
