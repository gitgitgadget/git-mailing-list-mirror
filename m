From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2012, #03; Tue, 13)
Date: Tue, 13 Nov 2012 20:18:53 -0500
Message-ID: <50A2F17D.4010907@gmail.com>
References: <20121113175205.GA26960@sigill.intra.peff.net> <50A2B14C.9040608@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Nov 14 02:19:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYRdI-0005VD-7X
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 02:19:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274Ab2KNBS5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Nov 2012 20:18:57 -0500
Received: from mail-vc0-f174.google.com ([209.85.220.174]:46238 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932152Ab2KNBS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 20:18:57 -0500
Received: by mail-vc0-f174.google.com with SMTP id fk26so8073313vcb.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 17:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=NdS6ih3camXB59SpHifJ5P7DfrXV0RKFWfe9MFz3NBM=;
        b=Ep3lEqy+xc0hg2ARYccYYk7hT7jc7RdPAw14cz3Qs5qjOj4jyN71ST/1FfZUETEdQe
         0fbkh6IoufxfNKvRU/COTXhaq4+cQ2KbDGvbmVoslFBHPfr/k0TjtAS7YXX1Gcxt+H0x
         psYH1Y0ODTB+Sk85ZL/a/KV3ocIfDcTiJ6zZXja0D9tL8/LOJFK7RKjnlc9xkj4MUNjF
         rPV1M4oUK5IGBJviKNZsbLJntHWBq8yItK7ORCKGUpWZicR9s6mHmBYT77prmqta/OAN
         oGeB15kepm9ujPbFW0CAdnZFyp30w2Rj2HkKqxRkZW+6IUVPiwEeCi24qjB26VsKCV25
         VYLg==
Received: by 10.52.74.6 with SMTP id p6mr279817vdv.124.1352855936322;
        Tue, 13 Nov 2012 17:18:56 -0800 (PST)
Received: from mark-laptop.lan (pool-173-79-107-139.washdc.fios.verizon.net. [173.79.107.139])
        by mx.google.com with ESMTPS id dq8sm11071968vdc.4.2012.11.13.17.18.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Nov 2012 17:18:54 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121029 Thunderbird/16.0.2
In-Reply-To: <50A2B14C.9040608@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209692>

On 11/13/2012 03:45 PM, Torsten B=C3=B6gershausen wrote:
>> * ml/cygwin-mingw-headers (2012-11-12) 1 commit
>>   - Update cygwin.c for new mingw-64 win32 api headers
>>
>>   Make git work on newer cygwin.
>>
>>   Will merge to 'next'.
> (Sorry for late answer, I managed to test the original patch minutes =
before Peff merged it to pu)
> (And thanks for maintaining git)
>
> Is everybody using cygwin happy with this?
>
> I managed to compile on a fresh installed cygwin,
> but failed to compile under 1.7.7, see below.
> Is there a way we can achieve to compile git both under "old" and "ne=
w" cygwin 1.7 ?
> Or is this not worth the effort?
> /Torsten
>
>
>
I found no version info defined that could be used to automatically=20
switch between the old and current headers. You can always

     make V15_MINGW_HEADERS=3D1 ...

to force using the old set if you do not wish to update your installati=
on.

Mark
