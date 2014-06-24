From: Noel Grandin <noelgrandin@gmail.com>
Subject: Re: bug: git grep -P and multiline mode
Date: Tue, 24 Jun 2014 09:34:44 +0200
Message-ID: <53A92A14.8010607@gmail.com>
References: <53A7CF25.7060508@gmail.com> <xmqqa993cykl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Noel Grandin <noelgrandin@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 09:34:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzLFq-0008Jy-6l
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 09:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375AbaFXHey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 03:34:54 -0400
Received: from mail-we0-f172.google.com ([74.125.82.172]:49667 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbaFXHex (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 03:34:53 -0400
Received: by mail-we0-f172.google.com with SMTP id u57so8298557wes.3
        for <git@vger.kernel.org>; Tue, 24 Jun 2014 00:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=lhVDR4xVMVuaWxtKuFz3kMuwD3YpKFxlWVbk9SLQ3Tw=;
        b=G9YSS8RYG8M0qbX0YRNPAZgmQMeFqmIgppnHnq6bHsI3XPnBtMT0zcnBgFX/tyNr8v
         0CV7Iv7FXXQ0ALpYqIZlzBJWi5ctlwjauknINAYa45E/ZgGoGiLGM/OWFXZd2tiGfWUv
         CAbfDJClTpxEBGB2DtWfAqgjtaUn5gSHUgVwrYxjPaHOqxd9hMwvHvpWG76P20SLFbCn
         +HuNShBjNG+hVZ+QdWvmGWW3687NyY5kwP3ZQ9fhH6XvBPz3PD8Efz8tSw2C24eVIkT+
         McDSUsmZxSXbXiBal1JMT/RgkVOIZfpR5IqTvLRa5EVQ9sM7yS6QBMpEUpB489SSV0BF
         bflQ==
X-Received: by 10.194.192.65 with SMTP id he1mr32719502wjc.91.1403595292597;
        Tue, 24 Jun 2014 00:34:52 -0700 (PDT)
Received: from [192.168.1.212] ([41.164.8.42])
        by mx.google.com with ESMTPSA id o2sm40681989wia.16.2014.06.24.00.34.49
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 24 Jun 2014 00:34:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqa993cykl.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252389>

On 2014-06-23 07:42 PM, Junio C Hamano wrote:
> Noel Grandin <noelgrandin@gmail.com> writes:
>
>> It looks like the perl regular expression multiline mode does not work with 'git grep'
> Yes, and deliberately so, to avoid having to think about things like
> "how would a multi-line match interact with 'grep -n'?"
>
>

Ah, that is a pity.

I find the multi-line mode very useful for finding code problems that span multiple lines.

I'm sure there are other options that conflict, and the solution is to normally write out some kind of informative error 
message?

Anyhow, since I'm too busy working on LibreOffice right now to work up a patch for git, I'll stick to using
     find | xargs grep
:-)
