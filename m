From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: Re: GSoC 2016 Microproject
Date: Sun, 28 Feb 2016 15:42:56 +0530
Message-ID: <56D2C828.6010901@gmail.com>
References: <56D19EF9.3070702@gmail.com> <vpq8u26qo3y.fsf@anie.imag.fr>
 <56D1BEC8.9010302@gmail.com> <vpq1t7yqgi4.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Feb 28 11:13:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZyLb-0007cB-Sq
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 11:13:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756981AbcB1KND (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 05:13:03 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34337 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbcB1KNB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 05:13:01 -0500
Received: by mail-pa0-f41.google.com with SMTP id fy10so75198651pac.1
        for <git@vger.kernel.org>; Sun, 28 Feb 2016 02:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=fuEN+8zLc6cMw47JrRk8hyy8Qns0nL4X+lKUa/GxzDY=;
        b=DHzQTsRl+huSM2guacwqwGqW0Xp5J4HzoUZZvIv8wR0hPKEs+aj3VKGmNkiKRBRFhf
         o3qH+CeJyyMKBpyTMEngRbXA2WUgWuG9dg0OTuzPrKsw91nPWSTk0z2Btbg4So/nAfG/
         LNZeZWMAjtL0Y4NMCaeA/feOp/jhsLMtd0NZrYbop1L5hu3E686VNfZSB6gsphQhSMLU
         S/KiINNEEO8dHc5xgaBYEhWZvqPr6Fr94T12xaaNv7RRljnV9PmSMuh1mtFyLsQBG9z5
         UF9FzTHC0J0mu3Qec/i1yd/qZobMh3zxAE7PkWLRqtsRZoESW0SPFx3gQ7wI1YsdsRjV
         ErXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=fuEN+8zLc6cMw47JrRk8hyy8Qns0nL4X+lKUa/GxzDY=;
        b=Rr+ZMYjPzraTlQPTriuX4rt2lZhtzpV7AdXlma6qrpC/EfJ62qXCaP6pQ2k3Hp50n7
         CPTmmMturQs/PwyAyDHyeNXJDWQh+q6wROG4oQb1H+xVi62HhJziVo71p8+fNTEZUrC/
         sZ4i27Hq9dCCBAa+u/0oTj4v+zKogE1/IakJjSRgCfmhM+nhuc/9hzVUHkCl+uDGYLp4
         F0YD7YRCBtMF22N6Vl9FV5rSR+tl03iXDqlc7/IzCJ7fhxXOmIvaKM+rKK7M1gCzjL3y
         35S39d5ZMsztZ7FV+sFqBFbiy4tIv0UoXbj9j+uog2MOYgml0ug08IquVLDG0fyg5WCb
         S2tw==
X-Gm-Message-State: AD7BkJKMKAIevypl9rZsbGivvEjxoR2NFllrQbKYUwyCQUwiInOZXAHFwqMjyLXbZL+wQA==
X-Received: by 10.66.228.97 with SMTP id sh1mr14308802pac.77.1456654380635;
        Sun, 28 Feb 2016 02:13:00 -0800 (PST)
Received: from [192.168.1.10] ([182.68.63.13])
        by smtp.gmail.com with ESMTPSA id x88sm30568345pfi.66.2016.02.28.02.12.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 28 Feb 2016 02:12:59 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <vpq1t7yqgi4.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287763>

Hi,
> I didn't see anything going on for this one, but you may want to
> double-check with the ml's archives.
>
I checked the archives and there doesn't seem to be any active work on this.
I made the required changes and ran the test suite. Though all the tests pass, there still are two queries I have.
First, I'm not quite sure what to put in the help message for the options (--quiet, --stateless-rpc, --advertise-refs and --reject-thin-pack-for-testing).
Second, regarding the reject-thin-pack-for-testing option, currently when the option is entered, `fix_thin` is unset (https://github.com/git/git/blob/master/builtin/receive-pack.c#L1736). But using `OPT_BOOL(...)` for the same, the variable would instead be set when the option is given. I think one solution can be to invert `fix_thin` after calling `parse_options`. Am I going right so far? Suggestions and corrections welcome.



Regards,
Sidhant Sharma [:tk]
