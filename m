From: Christian Couder <christian.couder@gmail.com>
Subject: Re: RPM spec file broken by README.md
Date: Fri, 1 Apr 2016 13:24:31 +0200
Message-ID: <CAP8UFD0xFj9CxYtqsdMz9ug_eTf0y+9eEEJ7r2r8og3XBAevTQ@mail.gmail.com>
References: <CADrzLrOaeQXjWeCnZSJfWWyfr3kzgm59QvR6SeTiw_E2Xg7ugQ@mail.gmail.com>
	<CAP8UFD101cKKMcTOxARnWkoNWp-waUMo3B4RH+Co9D9fkpQdfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Ron Isaacson <isaacson.ljits@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 13:24:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alxBs-0004SN-Ds
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 13:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467AbcDALYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 07:24:33 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35388 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143AbcDALYc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 07:24:32 -0400
Received: by mail-wm0-f52.google.com with SMTP id 191so16531553wmq.0
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 04:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=zAtvaFBgEOrjwSOmXEtByxDsv26i1ySRIZ4drJglu1A=;
        b=sg7xPXIcxTn1XHwQpzkIeSerzIgwyz5/hUmRs0W6nZNNQGD3U9y0OORcaNhxo77QQN
         PTiwujyRE4cu9p744th24rdjhCNlwHOgcrb+EhwbDVHzinRGMr2vTPVgwb1BQK+ZCire
         1+sqaiVQ+0nXfSoCSmEpsqspM4FKkyjOI8ugV34cE4jgJJLEpMuARssrMtuRxw4TTIn4
         rNQD3jeAS3NsWO/jEOAXnOtNnGDsFIRNFLW27bWEkKQ3Dagf+L7TPyxpV/RDdjgmU9hC
         L+gadTf8HfpLgRq4KwFItig8Dg5MDn44EvmsXpv898KAQhyvd8bHBLVzmYkFmt3X6EbM
         8zHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=zAtvaFBgEOrjwSOmXEtByxDsv26i1ySRIZ4drJglu1A=;
        b=HHiGen9x4D/gBWS5Xg8PDeMc8N1Rl24DQyzCga6GlJq6jpu63xKMmTkYJDx/T9Fnqj
         G+p5t7mGmfg/oeFspxdQdgyyQ0rH+XqZtJri5Edvyx48MEdH0XJruhjecajcukJRGc/J
         lq9EBVuqvNvmbFg+eopdnUHmaZpu8+C5CWepvZ0fOmYa+/EnLLeq20L7pDPpOwkq++W8
         56VP2hmfrwbdMTZzva7AovxmYEkymU2yAjKLKfnpZYqfvYK2FpoozK6GJN7I4h9lWMpa
         1BOI7oCGS3lmfOBZmcnaWg+mhSiU9D4YN6+OTmX7MP0aU2+23IhWn36IG6H5nWHvxWXu
         2J+Q==
X-Gm-Message-State: AD7BkJK4T63IV/ipJdT3/yYjzB55Koc4Fcl5j59F3IlIrzNeax9WoJ5LKnGyCkMnhGj9pd07yKRqtooW2EEUfQ==
X-Received: by 10.28.97.10 with SMTP id v10mr3486576wmb.62.1459509871055; Fri,
 01 Apr 2016 04:24:31 -0700 (PDT)
Received: by 10.194.151.131 with HTTP; Fri, 1 Apr 2016 04:24:31 -0700 (PDT)
In-Reply-To: <CAP8UFD101cKKMcTOxARnWkoNWp-waUMo3B4RH+Co9D9fkpQdfg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290526>

On Fri, Apr 1, 2016 at 1:23 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> Hi!
>
> On Fri, Apr 1, 2016 at 7:35 AM, Ron Isaacson <isaacson.ljits@gmail.com> wrote:
>> Hi everyone,
>>
>> I've noticed that "make rpm" is failing for 2.8.0 because README was
>> replaced with README.md. This line in git.spec is the culprit:
>>
>> %doc README COPYING Documentation/*.txt
>>
>> Would it be possible to change this to README.md to match the source
>> tree? The rpm packages build just fine with that change. Thank you
>> very much!
>
> Thanks for this bug report.
>
> Would you care to send a patch?

Ooops, it looks like Matthieu already sent a patch. Sorry for the noise.
