From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: git should not use a default user.email config value
Date: Wed, 14 Aug 2013 09:09:05 +0200
Message-ID: <520B2D11.2080405@alum.mit.edu>
References: <20130809223758.GB7160@sigill.intra.peff.net> <20130809231928.GY14690@google.com> <20130810064717.GB30185@sigill.intra.peff.net> <52060EF9.2040504@alum.mit.edu> <7vvc3d1o01.fsf@alter.siamese.dyndns.org> <CAH5451nHfOaBzFzkrGvw+TyRj==cVpKF_QdXsTxnn5tTr1c0dw@mail.gmail.com> <20130812123921.GA16088@sigill.intra.peff.net> <CAH5451=PK15n4U-3Mb_TLevF3-r+vrpk1PXD15Oo1A2KFc5i_w@mail.gmail.com> <20130812154520.GA18215@sigill.intra.peff.net> <CAH5451=WKXUNzovXquFii=EdkeQXJEQ96_CRRebgQW6ow_19VA@mail.gmail.com> <20130813114635.GA16506@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thorsten Glaser <tg@mirbsd.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 14 09:09:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9VCm-0003ZY-Re
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 09:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754859Ab3HNHJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 03:09:13 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:46306 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752784Ab3HNHJM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Aug 2013 03:09:12 -0400
X-AuditID: 1207440f-b7f786d000001f20-e7-520b2d1791c4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id C6.F1.07968.71D2B025; Wed, 14 Aug 2013 03:09:11 -0400 (EDT)
Received: from [192.168.101.152] (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r7E7971G011119
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 14 Aug 2013 03:09:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <20130813114635.GA16506@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRmVeSWpSXmKPExsUixO6iqCuuyx1kcGSOuEX3mSY2i64r3UwW
	Db1XmC3e3lzCaPF/xwIWix8tPcwWz/p/Mzqwe+ycdZfd49ixVmaPuw2aHs969zB6XLyk7PF5
	k1wAWxS3TVJiSVlwZnqevl0Cd8bBSweYCxYLVfTePsTWwPiNt4uRk0NCwETib+tRNghbTOLC
	vfVANheHkMBlRomVy2ezgySEBK4xSbRs9AOxeQW0Jfa3nGMEsVkEVCX6228wgdhsAroSi3qa
	gWwODlGBMIkrv1UhygUlTs58wgJiiwjISnw/vJERZD6zQDeTROvLTawgCWEBR4nvj2cxQeza
	xCLx5aYmiM0pYC1xuucaG8hMZgF1ifXzhEDCzALyEtvfzmGewCgwC8mKWQhVs5BULWBkXsUo
	l5hTmqubm5iZU5yarFucnJiXl1qka6KXm1mil5pSuokREvr8Oxi71sscYhTgYFTi4bWw4woS
	Yk0sK67MPcQoycGkJMpbo8odJMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEt5EHKMebklhZlVqU
	D5OS5mBREudVX6LuJySQnliSmp2aWpBaBJOV4eBQkuCN0QFqFCxKTU+tSMvMKUFIM3Fwggzn
	khIpTs1LSS1KLC3JiAdFaXwxME5BUjxAe61A2nmLCxJzgaIQracYjTn+rJz7iZHjXdO8T4xC
	LHn5ealS4rxaIKUCIKUZpXlwi2BJ7xWjONDfwrx+IFU8wIQJN+8V0ComoFUO2Vwgq0oSEVJS
	DYwa8vMs9Getf276Oub/uj1XxHYasE40cs/ZwcTwb/fbuHNq57P0pb2b6uarHfkx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232264>

On 08/13/2013 01:46 PM, Jeff King wrote:
> On Tue, Aug 13, 2013 at 09:05:40PM +1000, Andrew Ardill wrote:
> 
>> I applied this on top of latest next (1da3ebde8999d07), and it worked
>> perfectly for my use case.
>>
>> For what it's worth, it also passed the test suite!
>>
>> Would be great to see this, or something on the same theme, get into
>> master. I'd be happy to review patches/write tests/write documentation
>> if needed.
> 
> Like I said, I do not have a particular use for it, but I don't think it
> would hurt anybody who does not use it. If you want to polish it up into
> a real patch with docs and tests, I don't mind.
> 
> The only downside I can think of is that we might want to use the
> subsection in "include.SUBSECTION.*" for some other limiting conditions
> (e.g., "only include this config when running version >= X.Y", or even
> "include only when environment variable FOO is true").
> 
> I guess we could do something like:
> 
>   [include "repo:...your regex here..."]
>     path = .gitconfig-only-for-some-repos
>   [include "env:USE_MY_MAGIC_CONFIG"]
>     path = .gitconfig-only-when-magic-env-set
> 
> Adding the "repo:" prefix for this repo-dir matching is pretty trivial.
> Adding a similar env-matching is only slightly less trivial; but does
> anybody actually want it?

Gaaak!  Let me again plead for supporting a post-clone hook rather than
inventing some crazy config-file syntax that is becoming ever more
complicated.  A post-clone hook would make all of these things that have
been suggested pretty easy, and would also open lots of other
possibilities, all without further changes in git.core, like (I'm just
brainstorming here):

    #! /bin/sh

    remote="$1"

    ln -s $(HOME)/.githooks/* .git/hooks

    case "$(git --version)" in
    *.1.[78].*)
        git config include.path "$(HOME)/.gitinclude
        ;;
    esac

    echo "(cd $(pwd) && git gc)" >>"$(HOME)/cron.weekly/git-gc"

    case "$remote" in
    *.work.com/*)
        git config user.email me@work.com
        ;;
    *.github.com/*)
        git config user.email me@debian.org
        ;;
    *)
        echo '### Remember to set user.email ###'
        ;;
    esac

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
