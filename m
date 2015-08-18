From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v9 3/6] note: extract parse_notes_merge_strategy to notes-utils
Date: Mon, 17 Aug 2015 17:15:13 -0700
Message-ID: <CA+P7+xohUHsJfxjKMTkOfmAmRNPJ5S-z4HgtcGZB0VmYDf5Oyg@mail.gmail.com>
References: <1439847214-2980-1-git-send-email-jacob.e.keller@intel.com>
 <1439847214-2980-4-git-send-email-jacob.e.keller@intel.com> <xmqqbne5bkx7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 02:15:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRUZ0-0004a7-6s
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 02:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbbHRAPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 20:15:34 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:32827 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975AbbHRAPd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 20:15:33 -0400
Received: by iods203 with SMTP id s203so171000494iod.0
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 17:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Y4G3w7bcG+IMO4m3ZXGOyIkIcAFRbPYA4Ul0FptXz2g=;
        b=do7ZOe1g+bAicrXZO2eYW9dw+/qiPUfhjmhE8e8aFLnIxmiCqIAomZf3Ab4uzzZTyc
         x7AYyV2Omy3laXHdyQYR579dIjmoUSVU52BT8VNUQEfPNzioqkgmjeJZJUPFL2Uj97XB
         3sLn162FCZH/It5psQXvwB4w3hbWkru/H9fQofJ5TCWceW4/TOsg5Dmu/rb+34cA5gSI
         9/wuhHv21CKAHui8vpQTFtJJ0YYOvK3slnN4rF3stlHnU7a0nJSR5xpnkY2qztlEtBKf
         GYI4x4OL3k0woYgHzsqMjRqJ9Uw09muBrLlLtSf3V1IHmGwT8By4FyBfpE+XafRIRki1
         vFNw==
X-Received: by 10.107.133.137 with SMTP id p9mr3983281ioi.146.1439856933215;
 Mon, 17 Aug 2015 17:15:33 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Mon, 17 Aug 2015 17:15:13 -0700 (PDT)
In-Reply-To: <xmqqbne5bkx7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276109>

On Mon, Aug 17, 2015 at 3:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> Combining rewrite and notes-merge functionality has been left as an
>> exercise for a future contributor.
>
> This comment is probably unnecessary; we haven't even established if
> such a combination is desirable AFAICT in the discussion.
>
> The patch itself looks very straightforward and obviously good.
>
> Thanks.
>

Feel free to fix that up if you want. Probably easier than me
respinning the whole series.

Regards,
Jake
