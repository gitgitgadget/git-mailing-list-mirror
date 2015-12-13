From: Victor Leschuk <vleschuk@gmail.com>
Subject: Re: [PATCH v7] Add git-grep threads param
Date: Sun, 13 Dec 2015 22:25:06 +0300
Message-ID: <566DC612.60409@gmail.com>
References: <1450019856-14609-1-git-send-email-vleschuk@accesssoftek.com>
 <CAPig+cTybb9d4enQjCuAefexcP=rPG2SF3VvvB78SUW1UmkuQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Victor Leschuk <vleschuk@accesssoftek.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>, Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 20:25:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8CGl-0006uf-HQ
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 20:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431AbbLMTZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2015 14:25:14 -0500
Received: from mail-lb0-f170.google.com ([209.85.217.170]:35959 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752306AbbLMTZM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2015 14:25:12 -0500
Received: by lbblt2 with SMTP id lt2so95848362lbb.3
        for <git@vger.kernel.org>; Sun, 13 Dec 2015 11:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=2vJToi1zjczG+1oQt4shdRt+wNcO5/dAFiovLJrO7sA=;
        b=SEspHpaKN/BQqDF6AvCEWzBIXRnMJ/qrs00OUywFGwMAzKo9hu+MIIjVHRtzCzAtc3
         eGSt7P9omRfufFYdjNTNc/REbJ1VfpnEkJEHXthFR9QwpCuaZXfzIn9ppSczyyv2VZS2
         gasOb6zcMF+m7u0bn6hqgZYtmvRvymEiNjhCLl4HWh78NWHmoHMWkmJP6hBEi8Gpeq0c
         z4luoYxOvDXEAXy+UMROiPI0YO7tpet7ZvG26h/v5rXOwNAUBSQnojpW/W/dHUSBqxY4
         eCi5T5iJL0EuvjYEQmyNUBFK0FOsx9ATRxeboXRi6nUHChji+atWK6RXWGBQYVlN9dHr
         uqkg==
X-Received: by 10.112.143.129 with SMTP id se1mr12440623lbb.55.1450034711104;
        Sun, 13 Dec 2015 11:25:11 -0800 (PST)
Received: from [192.168.1.10] ([31.173.85.127])
        by smtp.gmail.com with ESMTPSA id w132sm5061451lfd.11.2015.12.13.11.25.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 13 Dec 2015 11:25:09 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CAPig+cTybb9d4enQjCuAefexcP=rPG2SF3VvvB78SUW1UmkuQw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282344>

Hello Eric:
> Hmm, v7 doesn't seem to address any of the v6 review comments here[1].
> Was that review merely overlooked or did you disagree with the
> reviewer?
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/281817
Sorry, it looks like I missed that letter. My bad.
>
>> History of changes from the first version ($gmane/280053/:
> It's generally more helpful to reviewers if you provide a link to the
> previous version and describe the changes since that version. (If you
> prefer, it's also okay to describe all changes, but they should be
> organized by version so that it's obvious which changes were made in
> which version.)
I will prepare v8 and list changes starting from v6. Please kindly 
disregard this one.
