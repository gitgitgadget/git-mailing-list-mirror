From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Why are submodules not automatically handled by default or at
 least configurable to do so?
Date: Mon, 26 Oct 2015 17:56:33 +0100
Message-ID: <562E5B41.9090801@web.de>
References: <D4E5E890658.000004DCjohsmi9933@inbox.com>
 <CAEY4ZpPduXXqgW3rWn9rzkpHrTvY8QfPX=YcBZ_DpyVwnsZ6jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Nazri Ramliy <ayiehere@gmail.com>,
	John Smith <johsmi9933@inbox.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 17:56:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zql4h-0003QQ-Mn
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 17:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853AbbJZQ4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 12:56:42 -0400
Received: from mout.web.de ([212.227.15.3]:61152 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751533AbbJZQ4k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 12:56:40 -0400
Received: from [192.168.178.41] ([79.211.105.62]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0M3k9J-1ahtit29yb-00rE0R; Mon, 26 Oct 2015 17:56:34
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CAEY4ZpPduXXqgW3rWn9rzkpHrTvY8QfPX=YcBZ_DpyVwnsZ6jw@mail.gmail.com>
X-Provags-ID: V03:K0:IFCUCld/t8LF5M25/xq18lfiNQQWkGPZGGeOmwvF79wvS7Q8Ct6
 WVYM78hPtvqsFzmV97ltKlRxBFJ6I1mFWLrgpw9SODWpnm9j141xXM7abi8oGhfxd/lsnCO
 +zTbW/7edbRLVTP9zWf2QDuwbDK+FwUtfdckRcK2Wy7wPFQmIfoxcxsGGF1JRHY1E5fcvsp
 Qejd0mK2Ao2XiakpuQC2w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gMDAxk3pVHg=:klzcue5gnZtGdY07+Jkcfx
 ZSgN7pDdkVg+CXpiawNafcmGxFSgTvGc1YHCFDxOOXPMflcF8RX2sYysEXqI5HeQdnoavtpQX
 mMPbu2J1G5HKqsqGDOcoYT4q00f4WQnyR1BKZ62NBArIPP8Zr7sRHW9ogiZfw2yUQfDfRnSo0
 KW0cFCk5fQYJ8xr6j51vNpB+1DX5aoa0KljIewY5066kxuw70OjaB9nMSwc5lBjzD9DqXAl6B
 tdfRvBUY4ZmhFqSTTMhltr7PlvmlIqhqN7Qwhg/c/zzx5ude/7AN8YgcioNGg2kSfNvgcorYq
 cBfjW86PaOx8X1GsBJppPLmO+lhhJoDY7cl46RUb+1SKkYzv+DK4TlMx5FbRBaAL8M+U0cdIy
 TAYUqdSkDZ9//TW8l5ileD4fiSSRIikwsdj2/ThUnEVSEXbuquSK23Pwamow8D1AREHKdt1MM
 qvRnlejjBiHTqhmu02M68ceAz0yqPdXBvgFp5/EIruftbfsHNFUO6pudjn297+N45omOoGkvN
 ja8mRonXuijFaChbXLuI0uQLYLptb3i+A/PlBoSN3VYOFqsjB8NUv6OiTJDhf0d0lG8n2SQCZ
 h5LmouXrGdGTr4MJVfrFQGAdSWvqP/JWVvFbjOumMm/ou0tXucTnfv8qE/fgGrUQ2/BjPpkZ9
 PfnqqYb8PwyAwmTNoZDK86pXDCZwg4hWllGG8O6pQLztxajk8E1KoTqPUYCpYhaW8OdQ+JsuB
 nVJnx4frgTRODS7xFDft5enysrSwAcpfJUrDz4siB1bmq04U91AxEyyT/A6164m9t7Flw1u+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280201>

Am 26.10.2015 um 05:48 schrieb Nazri Ramliy:
> On Mon, Oct 26, 2015 at 7:10 AM, John Smith <johsmi9933@inbox.com> wrote:
>> When would people routinely check out a branch and want to stay with the submodules as
>> the have been checked out for the old branch?
>
> I do this a lot. At my $dayjob we have a super project with bunch of
> sub projects.
> Each subproject has its corresponding rpm spec file in the
> superproject - it's quite
> often that I work on a "git-merge-base--octopus" branch that updates only the
> spec files and nothing else - so when changing between branches I
> don't care what
> states the submodules are in. When the fixes to the spec files are ready I just
> checkout to the respective branches and merge in the changes - I don't actively
> do "git submodule update" when switching to different branches.

Which seems a bit error prone as you could forget to update the submodules
and build incorrect rpms from them, or am I missing something?

I understand why you don't need to update the submodules every time, but
would it hurt your workflow if they did (but don't get me wrong, that will
always be configurable).
