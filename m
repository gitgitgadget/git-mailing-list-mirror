From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2012, #10; Thu, 26)
Date: Fri, 27 Apr 2012 07:59:22 -0700
Message-ID: <xmqq7gx1b4qd.fsf@junio.mtv.corp.google.com>
References: <xmqqlili6xfu.fsf@junio.mtv.corp.google.com>
	<20120427110352.GA1828@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 27 16:59:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNmdu-0003aq-MU
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 16:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760316Ab2D0O7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Apr 2012 10:59:25 -0400
Received: from mail-ee0-f74.google.com ([74.125.83.74]:46026 "EHLO
	mail-ee0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760158Ab2D0O7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2012 10:59:24 -0400
Received: by eekc41 with SMTP id c41so43407eek.1
        for <git@vger.kernel.org>; Fri, 27 Apr 2012 07:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=6PaetEwrEZ/GclZzAY4LhpNIY5jKGPAFaqpuG/iyp6M=;
        b=M6c0hWh85uLlHPx/aStgwUASwLxYcd3xzfC60+SVaS24b15KCba0ZWMya+PUu1Hy7F
         2dl6gYvUAbAPiPZXGiyy3YMhKu4pdeSqb3Jh3AKpu6BRSBVJH+vuFWrLYgtYCQIr1Lfc
         hVJNNThpVLn3JmOU4DQFxO84x1brcpILpVM6JMeOFayACCm6nBaARkeMQIQAIAsHfBqG
         F9FoEpd7gS6xeMwRtFn8eoZLubUGd8eBZMRayVhGaWWhIFN7mBn0Aj8sfwbNJj/2wnfJ
         NtqyqoDBdioLFVU6JnTmHXd9RWVZsvg4U1X+tAaWUkSPDZ14OsZr5jiLiIQ9WrB0hX6/
         a9aw==
Received: by 10.213.26.206 with SMTP id f14mr645146ebc.15.1335538763482;
        Fri, 27 Apr 2012 07:59:23 -0700 (PDT)
Received: by 10.213.26.206 with SMTP id f14mr645134ebc.15.1335538763355;
        Fri, 27 Apr 2012 07:59:23 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id s9si6426567eei.3.2012.04.27.07.59.23
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 27 Apr 2012 07:59:23 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id 2CB865C30E8;
	Fri, 27 Apr 2012 07:59:23 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 758DCE125C; Fri, 27 Apr 2012 07:59:22 -0700 (PDT)
In-Reply-To: <20120427110352.GA1828@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 27 Apr 2012 07:03:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQkty/DOAG1Pe7TxTTEcDeCqetWXshpoKSysnVvBiI+sQlDAHIV8j/aSC7CeH+XqlLq8wWBniEhydrkSoZ8EioZDCeCxOfpasltkKEcGn/fRkGrmYl2ryqIlmtSbIVqb3Quap80PIQMwseQ6ix0fH8KZzsg4UmdCu4tUM/h2o/yVqa06T7M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196472>

Jeff King <peff@peff.net> writes:

> On Thu, Apr 26, 2012 at 01:38:13PM -0700, Junio C Hamano wrote:
>
>> * mm/include-userpath (2012-04-25) 2 commits
>>   (merged to 'next' on 2012-04-26 at c68e261)
>>  + fixup! config: expand tildes in include.path variable
>>  + config: expand tildes in include.path variable
>> 
>> The new "include.path" directive in the configuration files learned
>> to understand "~/path" and "~user/path".
>
> Oops? Was this supposed to be squashed before merging to next?

Oops, indeed.  Mistakes happen ;-).
