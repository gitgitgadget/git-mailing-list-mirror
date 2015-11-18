From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH] blame: add test case for using tag object as a final ref
Date: Wed, 18 Nov 2015 12:35:38 +0200
Message-ID: <CAF7_NFRBJ+6qPkeRx2JQUMTf16WPGhz86MpmX0u994ABXbpMww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Edmundo Carmona Antoranz <eantoranz@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 18 11:35:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zz05X-0006bm-SN
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 11:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736AbbKRKfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2015 05:35:39 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37706 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbbKRKfi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2015 05:35:38 -0500
Received: by igcto18 with SMTP id to18so34871108igc.0
        for <git@vger.kernel.org>; Wed, 18 Nov 2015 02:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:cc:content-type;
        bh=vsGJBQzAj4t7/AOQwioTJUkMMT8I8glGpxjdMvuvSpc=;
        b=08CYdelCFEDopbd19HUDUq8VxlKv3XxmJXROFm1uIucLT7rBPydT50RyWJ4KGpHr/t
         6GVX69X6k2d7OYO9y8eefWy9pPJs+GSDvOgJA6g8qYt/JNp1/HcwHmtyXcJ+nip/coOv
         mtrC4w1Px8srGTA1HVNLW5BEpSE2VwfUC1fd+nshN3/x9WR/i+1XKJx9TjgDU+MWZBZo
         qDPELTVCPoHhW2Qrq9nQcHPPKlgKqMy2N9FilX37oQrYJ+8uGWp5ChJh34K3DxcqyFLo
         OeW2afUWSF0vVWvk27zU7i4w2HaO0pAOzBapS1FzSLuQWM2g+UH8lmakqVAhneSR8DGB
         nqbg==
X-Received: by 10.50.83.38 with SMTP id n6mr7117758igy.92.1447842938122; Wed,
 18 Nov 2015 02:35:38 -0800 (PST)
Received: by 10.64.129.168 with HTTP; Wed, 18 Nov 2015 02:35:38 -0800 (PST)
X-Google-Sender-Auth: gIkqJ7MbbUKhJGGw4-r8VwDRFCw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281446>

On Wed, Nov 18, 2015 at 8:00 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Nov 18, 2015 at 07:36:32AM +0200, Max Kirillov wrote:
>
>> It was discovered [1] that 1b0d40000a broke blaming starting from tag object.
>> Add test which verifies such blaming works.
>>
>> [1] http://mid.gmane.org/20151117224809.GE27862@sigill.intra.peff.net
>>
>> Signed-off-by: Max Kirillov <max@max630.net>
>> ---
>> Thank you. Sorry, I should have noticed that obj ended up unused.
>
> Thanks. Do you mind if I just squash this into the patch with the fix?

Not at all, please squash. 2 patches seem too many indeed

-- 
Max
