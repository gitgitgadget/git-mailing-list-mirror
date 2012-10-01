From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: "submodule" mistake and a problem
Date: Mon, 01 Oct 2012 18:40:00 +0200
Message-ID: <5069C760.2020603@web.de>
References: <CAHVO_92=5u-i+-d__5k7Uoq5pF4iACq9GuBSj4U5MepbKV_jdA@mail.gmail.com> <506981C1.3030504@viscovery.net> <CAHVO_93d92Ert35z1popk+X8HAAHX_jwTVdRCjrhNHrhTsvx2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Howard Miller <howardsmiller@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 18:40:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIj2a-0005y3-Oe
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 18:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517Ab2JAQkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 12:40:09 -0400
Received: from mout.web.de ([212.227.17.11]:62450 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752827Ab2JAQkH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 12:40:07 -0400
Received: from [192.168.178.41] ([91.3.164.110]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0MbyJ4-1T2hWO3CsQ-00JgNP; Mon, 01 Oct 2012 18:40:03
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <CAHVO_93d92Ert35z1popk+X8HAAHX_jwTVdRCjrhNHrhTsvx2Q@mail.gmail.com>
X-Provags-ID: V02:K0:robV8RuHl6k1UsDSC74QOKECmsFTaN5XZuev9xUapOm
 JJ0VK/1WvMim7SASNdVUQfXPlS2WopxnLMnPKZVCimw+C0lyCV
 5bwqLmMALLVNwXPl+kznBa0APnkdrpMAv27T5GT4JoXjbe3gki
 4lSAoPCDu4dYSJzgcL3eWb7OL8QM01uAflVq8ccXBG3M7hckbr
 2V2mW8M2bESz3uplJlbxw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206740>

Am 01.10.2012 14:05, schrieb Howard Miller:
>>
>> Perhaps:
>>
>>   git rm -f --cached path/to/subdir   # remove from index, keep files
>>   git add path/to/subdir
>>
>> -- Hannes
> 
> Fantastic.... worked perfectly.  I'll write that down somewhere for
> the next time I do it :)
> 
> Is there a better way of handling sub-modules like that? I've looked
> at git submodules but just got into more of a mess. It would be nice
> to push a project complete with a (git) submodule upstream but it
> seems tricky or impossible.

Git submodules are distinct repositories by design, so you'd have to
create an upstream repository for the submodule too to make that work.
But I have the impression that you want to import another repository
into a directory of your repo, so maybe git subtree is what you want.
