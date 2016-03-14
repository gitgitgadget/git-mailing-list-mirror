From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: Re: [RFC/GSoC] Introduction
Date: Mon, 14 Mar 2016 10:55:49 +0530
Message-ID: <56E64B5C.7030405@gmail.com>
References: <56E3BE3E.9070105@gmail.com>
 <1924FEBB-46F2-46EE-B190-5289588D4BED@gmail.com> <56E5B27D.7010808@gmail.com>
 <20160313211910.GA22052@ikke.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Kevin Daudt <me@ikke.info>
X-From: git-owner@vger.kernel.org Mon Mar 14 06:26:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afL14-00052S-Q0
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 06:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932856AbcCNF0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 01:26:00 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35160 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932784AbcCNFZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 01:25:58 -0400
Received: by mail-pa0-f53.google.com with SMTP id td3so121774816pab.2
        for <git@vger.kernel.org>; Sun, 13 Mar 2016 22:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=oz7rxSelV4rpTiJ02HlY1rNAZx6x/MvnVuz/PF79cHc=;
        b=f/l9I0gTTjHnHhqEdKTeZBKMSJGfrj09tqsoH8JeZZDLHDWyMS5QO4BdWuGqtOftNu
         OfqNHwu9+Dgew4ZhnjkZ2YtQpxQRbJoHKBLnTa3YLsh+0D9MOO3fN/FNt1mcgYNABz5O
         KSYoEpawuxxdJ/kdND/Ldd7VYh0Rqa4reFllJPHWqXYHSsx0zTDb53bKVfWj/hcZRZHq
         26cvb9sgwnzMQDu/5n2WKK5YjFmNKgEAzp8zfmfm6JJam92C7uyD21JgiIeb3uM+XSdB
         w6qfOUC94FKF0fFA6tMzJiE3mq1fWvp6XMW5/yMvbChtwUxlm69T4gEXaJVQSl3MbxR2
         BVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=oz7rxSelV4rpTiJ02HlY1rNAZx6x/MvnVuz/PF79cHc=;
        b=e59WzWEOQI5zENZL3qZSGrCaKxlsc3rVxkib2K7dNm6as4N9JZqElsFSzVCtiFcsqQ
         JbYb4MA3K6Vna+uXtKE5tiorGsamjiybpKB+krfuZRNfn10rKCsnw+tYK70k3Iq6fytL
         35nVivBkaG4fyoBEVLxL9Dh0gZQbzWarA6AOvhd/4YiQLjgWOctheo2FtXtJnSoUmRw3
         FpkF6TKgtg9RZOFWpinW4W6SZEnuogA4FgJdTCIL1B8HhzUxlhaq1X2WZh8T5BvTiZHw
         LZlTuaNsZGprgqmF5iPC5Q28GX9wgHn6oYvpTWZzOjKnrst6CRN8q/08ZOBYLqXHn61H
         42jg==
X-Gm-Message-State: AD7BkJJ/psCSTlWi6rnIYk1g/lEHUR4IpN8xuVPqDX4wzglIYoqJx/pVEBOReVXLFAjIag==
X-Received: by 10.67.24.104 with SMTP id ih8mr35296790pad.124.1457933152921;
        Sun, 13 Mar 2016 22:25:52 -0700 (PDT)
Received: from [192.168.1.10] ([182.69.45.48])
        by smtp.gmail.com with ESMTPSA id 82sm28593505pfb.64.2016.03.13.22.25.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 13 Mar 2016 22:25:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <20160313211910.GA22052@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288767>


On Monday 14 March 2016 02:49 AM, Kevin Daudt wrote:
> On Mon, Mar 14, 2016 at 12:03:33AM +0530, Sidhant Sharma wrote:
>> Other than this, I also tried to expand the list of potentially destructive
>> commands and updated the list as follows (additions in brackets):
>>
>> * git rebase [ git pull --rebase ]
>> * git reset --hard
>> * git clean -f
>> * git gc --prune=now --aggressive
>> * git push -f [ git push <remote> :<branch>, git push <remote> +<branch> ]
>> * [ git branch -D ]
>>
>> Are these additions appropriate? What other commands should be included?
>>
> git checkout [ref] <file> is destructive too if it would overwrite an
> uncomitted change.
Thanks, I'll add that one too. Also, should git checkout -- <file> be
added, since it'll discard all uncommitted changes?

Regards,
Sidhant Sharma
