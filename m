From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Composing git repositories
Date: Tue, 02 Apr 2013 21:59:44 +0200
Message-ID: <515B38B0.2040705@web.de>
References: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com> <7vmwtqt8rs.fsf@alter.siamese.dyndns.org> <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com> <7vvc8comj5.fsf@alter.siamese.dyndns.org> <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com> <51537A7B.7050206@web.de> <CALkWK0nfNCu775MBB-Y28=V93RkV24kbTLTDKWO2dZ-0yxX=Sw@mail.gmail.com> <5154AACC.7050006@web.de> <CALkWK0k=g3iFjmpUQA1VkuH2kZsVX1_Hpo=LZ7CuotwHz_1++g@mail.gmail.com> <CABURp0q9mV+-tEtHGpE4mh9cdbhkA8fr4i7XpBtK0fpfSYg-+A@mail.gmail.com> <51597A37.1010301@web.de> <CALkWK0nVax9HtM-M2zo-KH6U2jWznaUH9yBn4y1wqDW8f-mfOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 22:05:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN7SJ-00064E-4I
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 22:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932697Ab3DBUEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 16:04:51 -0400
Received: from mout.web.de ([212.227.15.4]:55548 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932549Ab3DBUEu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 16:04:50 -0400
Received: from [192.168.178.41] ([91.3.136.234]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0LvSQV-1UmrkQ02SJ-00zxPz; Tue, 02 Apr 2013 21:59:45
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <CALkWK0nVax9HtM-M2zo-KH6U2jWznaUH9yBn4y1wqDW8f-mfOg@mail.gmail.com>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:3A+cas5ltQgOOcqI4g+3h/WfjxygvQsyn9BW8ttjvRb
 cHIm5gYCF6KqBPRo84eU0JqcAw2d9FV0/NIESF3ILNNY5iVQfT
 +n64SHVg1AWoqx1VtGcjIgMr/O8x47dYjqpPGCx+PvpuydgYNU
 G0mR6DtbPwq/8qbYJCanhqCqN+oXyCX9us0XE0NVZu3cldu68S
 LDarjKVT6/+A35LpCXMzg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219873>

Am 02.04.2013 20:35, schrieb Ramkumar Ramachandra:
> Jens Lehmann wrote:
>> But I think we recently learned to support that use case with
>> submodules. I think there are two floating models:
>>
>> - Tracked:
>> [...]
>>
>> - Untracked:
>>   Some people just want "the newest" tip of a branch checked out in
>>   the submodule and update that from time to time (I suspect this
>>   is because they are used to SVN externals, which I believe work
>>   that way). You throw away reproducibility, which I think is not
>>   good and not the way I expect Git to work.
>> [...]
> 
> Nope, it has nothing to do with SVN externals; I've never used them.
> And no, all repositories aren't created equal.  I should be able to
> add in magit.git into my dotfiles repository without worrying about
> which commits the other repositories were at a particular commit.  If
> my project depends on the bleeding edge of poppler and girarra, I
> should always be able to tell what commits in each subproject the
> build was passing in.  In other words, I should be able to freely
> mixed floating and fixed submodules.  There's no reason for one to be
> Right, and the other to be a shunned second-class citizen.

But you can currently mix floating and fixed submodules, as each
submodule can be configured differently. Or am I missing something
here?
