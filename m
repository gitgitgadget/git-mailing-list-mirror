From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] document submodule sync --recursive
Date: Thu, 3 Dec 2015 12:22:04 -0800
Message-ID: <CAGZ79kaX4ZM++jhPcpU0T8eYDobME=iNtbH3KceWbQOOavpHnA@mail.gmail.com>
References: <1449171207-27201-1-git-send-email-sbeller@google.com>
	<xmqqh9jzthh3.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, cederp@opera.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 21:22:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4aOI-0003Nj-T9
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 21:22:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753576AbbLCUWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2015 15:22:06 -0500
Received: from mail-yk0-f174.google.com ([209.85.160.174]:35422 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753541AbbLCUWF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2015 15:22:05 -0500
Received: by ykba77 with SMTP id a77so99749464ykb.2
        for <git@vger.kernel.org>; Thu, 03 Dec 2015 12:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mGngws3I3f1m9tuY5mzWOgn/kwuK3jwK4JzMuqjOhJM=;
        b=oa/N+UYrTJMosMLu/xZjXuphqlL4U+1folRoM1G72AEHDcbn7C+mhHUvB/m3w6YLLa
         tiNUD8m88MmuMRe3eAIoyMRdOJ8hPKB2uhj8xhO8NZAdofgIJLRJdhfiQLNPi16GTEew
         rEynu2YNxBv53RtBu6gP6iGyfwSsyn+RH6Z3torPN7G+eMyltNt3TCT9C9ommQanzFWV
         thGEV6eF5JsndiO7VAxoLjb2aWHjR5ez37Y4TMgvAW66AevQrggyrIhHScyBvBPIU48m
         91HtFbDsv++P7SSxJewGVpFhnpjkDt5my6eg9Wi2txvfH4i6pSmQVCXBK5Bt/UfoxUJ+
         C9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=mGngws3I3f1m9tuY5mzWOgn/kwuK3jwK4JzMuqjOhJM=;
        b=lcMVEBilhdDRKo3K+216bwDtVu2QxIKY3YHioHWzvhkvNmcnApdsReDWvdW8WvK3Qe
         jFNAhQUUZGCTh8b3OiOkPzsWCUeP6P30+V0FvdhYM0iMVGpDn2SZPOeaFc1gcc7innf6
         nR5G9JSW8zlduM/k0pw8GqgwOJw5LZkLKREy8QYflI7MytQJ7vWc4fGQJJKGCoX8GU+a
         lCZ2ORO2frtXEi5EUT45Fy52NNsMlRTxpC2zmyYxYz25FbQkhWwGdGdOO4KOW+abq6zH
         kj64OJY+/XyFAPfUcOtXQ4s0oBe/2f8gkHMEgvGPEmhoOn+Gu/sqYtxEcchFJGT3V80E
         53KQ==
X-Gm-Message-State: ALoCoQln6iGOwShTrY6vkn/gPK0PcM91LiEY8oSN//W17oC5Kls/tYdnLKEskBWtMnhu4TpI4Gm/
X-Received: by 10.129.133.69 with SMTP id v66mr8661147ywf.68.1449174124242;
 Thu, 03 Dec 2015 12:22:04 -0800 (PST)
Received: by 10.37.215.16 with HTTP; Thu, 3 Dec 2015 12:22:04 -0800 (PST)
In-Reply-To: <xmqqh9jzthh3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281968>

On Thu, Dec 3, 2015 at 12:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Tested-by: Per Cederqvist <cederp@opera.com>
>
> Isn't this Reported-by? (genuine question; I haven't caught up with
> my inbox backlog and do not claim having seen everything Per wrote
> to this list).

Per wrote he tested `git submodule sync --recursive` with 2.6.3,
so yeah the tested refers to the underlying command, not this patch.
So Reported-by is better here.

>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>>  This applies on origin/master.
>
> Thanks.  Should it go to maintenance track (iow, was the feature
> that wasn't documented already in maint)?

It was introduced via
(82f49f294c,  Teach --recursive to submodule sync, 2012-10-26)
so I guess maint is fine, too

>> @@ -237,6 +237,9 @@ sync::
>>  +
>>  "git submodule sync" synchronizes all submodules while
>>  "git submodule sync \-- A" synchronizes submodule "A" only.
>> ++
>> +If `--recursive` is specified, this command will recurse into the
>> +registered submodules, and update any nested submodules within.

I should have paid more attention here and s/update/sync/.

I'll prepare a resend.
