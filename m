From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2012, #10; Wed, 28)
Date: Fri, 30 Mar 2012 12:13:00 +0100
Message-ID: <201203301313.01432.jnareb@gmail.com>
References: <7vsjgss6ua.fsf@alter.siamese.dyndns.org> <m3fwcrarwo.fsf@localhost.localdomain> <7vobreq2zp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 13:13:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDZlZ-0003pD-Fy
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 13:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933667Ab2C3LNI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Mar 2012 07:13:08 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:37684 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759426Ab2C3LNG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 07:13:06 -0400
Received: by wejx9 with SMTP id x9so291239wej.19
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 04:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=c4ecR7sdGW+lppRtMftpMQis0TBckxycKiY4WB3TV3w=;
        b=CzjH1GLmA8gjTntOMrX0g0Cv5RzKuPUQLA9HcRJ+9RfJI1MhIFbxWi6YFp9smIiUMf
         ClXKSe27senak8ksgsMbMpfU3pRM+r1F6qYS8WzzoWArWE6W66eGOnSdg1mbYDihDxIQ
         qfzkjg4StDJu8bT32DRNmX5tlRwmfmJzo7OmXPMeWvNmH2hl9m2huTnypUeAQ1pGzqSZ
         Kg8tHQw0ILTxpfbIR2/xnYh5zebkgLF8bzbnM034yO7X+65h6FQc5Xx4+CsDWZE3oNTW
         rI3cu3mc8LATJGn05X4AA/6BIWzqcghCXbq1lp8Cb6hdMKFtQHeUYEy//k25rIFyeyz0
         aTlw==
Received: by 10.180.95.129 with SMTP id dk1mr6366793wib.3.1333105983615;
        Fri, 30 Mar 2012 04:13:03 -0700 (PDT)
Received: from [192.168.1.13] (aeh224.neoplus.adsl.tpnet.pl. [83.25.111.224])
        by mx.google.com with ESMTPS id l5sm5463379wia.11.2012.03.30.04.13.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Mar 2012 04:13:03 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vobreq2zp.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194347>

On Fri, 30 Mar 2012, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> --------------------------------------------------
>>> [Cooking]
>>
>>> * wk/gitweb-snapshot-use-if-modified-since (2012-03-26) 3 commits
>>>  - gitweb: add If-Modified-Since handling to git_snapshot().
>>>  - gitweb: refactor If-Modified-Since handling
>>>  - gitweb: add `status` headers to git_feed() responses.
>>>=20
>>> Makes 'snapshot' request to "gitweb" honor If-Modified-Since: heade=
r,
>>> based on the commit date.
>>
>> What about "[PATCH v2 0/8] gitweb: Highlight interesting parts of di=
ff"
>> series by Micha=C5=82 Kiedrowicz:
>>
>>   Message-ID: <1332543417-19664-1-git-send-email-michal.kiedrowicz@g=
mail.com>
>>   http://thread.gmane.org/gmane.comp.version-control.git/193804
>=20
> I was waiting for the review cycle to come to a resolution.

Ah, so you were waiting for review before even considering this
series even for 'pu'...

=2E..which I have only just finished (the review I mean).

>> I have copy of them in 'gitweb/diff-hl' branch:
>=20
> Thanks for collecting them. I wasn't paying much attention to the lis=
t
> discussion.
>=20
> Do you mean "I collected them for you to review, I do not yet vouch f=
or
> them"?  I see one of them has your Ack, but otherwise there is no Sig=
n-off
> by you on any of the commit, so it is unclear if your "What about" wa=
s
> your way of saying "I think this round is ready, go ahead and pull." =
with
> a rhetorical question, or a pure question "What is your opinion on th=
is
> series?"

I meant "I collected them for you to have an option to pull rather than
apply set of 8 patches".  Anyway I applied them to examine how well the=
y
work.

I think this series is in quite good shape, and I expect in next revisi=
on
or two might be even ready for 'next'.  One more serious issue that I'd
like to see solved is requiring untabify() run before format_diff*() vs
having format_diff*() do it itself which is more future-proof I think.

>> -->8 --
>> The following changes since commit 455cf268dbaf227bdbd5e9fbf96525452=
bcfe44f:
>>
>>   Git 1.7.10-rc3 (2012-03-28 11:18:42 -0700)
>>
>> are available in the git repository at:
>>
>>   git://repo.or.cz/git/jnareb-git.git gitweb/diff-hl
>>
>> for you to fetch changes up to 60b06478f0349729dc9a4ddeb1abf5e28986f=
b7e:
>>
>>   gitweb: Refinement highlightning in combined diffs (2012-03-29 21:=
26:36 +0200)

--=20
Jakub Narebski
Poland
