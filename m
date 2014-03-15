From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Mar 2014, #03; Fri, 14)
Date: Sat, 15 Mar 2014 09:15:11 +0100
Message-ID: <53240C0F.2050204@web.de>
References: <xmqqlhwcfn4a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 15 09:16:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOjlN-0006Ct-Li
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 09:16:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680AbaCOIPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2014 04:15:37 -0400
Received: from mout.web.de ([212.227.15.4]:57564 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751044AbaCOIPf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2014 04:15:35 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LfzxX-1WwkBz2G6N-00parh; Sat, 15 Mar 2014 09:15:16
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <xmqqlhwcfn4a.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:Hb826r09rQL3Q6rhmyHk0hKk2GnwLvx3916pCOashwPH5VoBpR5
 iSQGIlni7zzXwieSLwuV/1Zj8o1gd5tCSgyn7AEbMD1o2cZAhPCkt2KgKU0JwOaz8oDEbeq
 kjL9HvCc3QcH2RzQdauAWt2VL8SPG7PtlhBSTdZTRRM9KP/ywQh1JSEXAa/Q69pawPbcmPY
 2Ww+az8JQg/lll0NxBLwQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244141>

On 2014-03-14 23.09, Junio C Hamano wrote:
> * ap/remote-hg-skip-null-bookmarks (2014-01-02) 1 commit
>  - remote-hg: do not fail on invalid bookmarks
> 
>  Reported to break tests ($gmane/240005)
>  Expecting a reroll.
I wonder what should happen here.
The change breaks all the tests in test-hg-hg-git.sh
(And the breakage may prevent us from detecting other breakages)

The ideal situation would be to have an extra test case for the problem
which we try to fix with this patch.

Antoine, is there any way to make your problem reproducable ?
And based on that, to make a patch which passes all test cases ?
Thanks
/Torsten
