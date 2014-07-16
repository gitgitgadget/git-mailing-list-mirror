From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 00/20] ref transactions part 2
Date: Wed, 16 Jul 2014 15:52:10 -0700
Message-ID: <CAL=YDWnQpLxM1TJ3dja+hGGNd1ckFUJHz83Z=WsOcfo24PT0Vg@mail.gmail.com>
References: <1405467258-24102-1-git-send-email-sahlberg@google.com>
	<CAL=YDW=At4isTCtwdeGZ-v3cS=vbGyC7aQ-CwAEzxKN0c_3Jyg@mail.gmail.com>
	<xmqqegxlq799.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 00:52:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7Y3e-0006vl-Th
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 00:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858AbaGPWwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 18:52:13 -0400
Received: from mail-vc0-f169.google.com ([209.85.220.169]:34607 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbaGPWwL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 18:52:11 -0400
Received: by mail-vc0-f169.google.com with SMTP id hu12so3120433vcb.28
        for <git@vger.kernel.org>; Wed, 16 Jul 2014 15:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=a6NnUyriW5FMhWQjgcjYG5NiB4GULFn4C2+O+HDU4RM=;
        b=iY8gvlFtjfeKQT46r7FNNoLknjI39FGl3crZKtnyAiA0BaLUnRb97pXliXDYrIU3XT
         cGe7j3tbaUMHzsMN/8jJe5A5LEJq2D+T++xqf0BNGjV1ZouF9Tbu2AniHeFg9n6Th7GG
         yn6f4eTWgALnVZwoFJt6oC3CiaLwFWyw75lVHg2ZumMbSu8seXkPHG+PYnFKpb0E3Xt5
         QOHgZT1FlTQcUcwDqxn0IYBMAdUt27qU316S9/MVWjOAXDYxtTuzwZDzRyd3O56lIwt8
         yKE1UlNCl4hrbxSrICMIQk9QVphLCf/mHb6keVbKmH3rKI1g2VqsRRyfN8VjidyEj/9M
         M1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=a6NnUyriW5FMhWQjgcjYG5NiB4GULFn4C2+O+HDU4RM=;
        b=WYG85NPHjWn3FSLA3wNoU8cDr/+ZkUIdm35FrdTi0QThfE+d2y2W11ltZqwiZRhZBu
         JYoGzm/zRn0pjqArHZMmBlMd+XgEMkoEKwm5GG7RSK9JKARg28L6vfFZtrgWiw2Pa0Ok
         aXH081GZyBCQnIrDXBdsBleloGtV/k98sAfwrREIe0gbeccixIM85Cowijv3lOEO/8Rp
         Luv101j+ag8PgAow7ZBjqbvorkVR4O+cKhnycBchbkYCdB65cunjBNV20fyLUfjDgFfY
         0VBzqEod4VTltI8fHm4sg67HNDFUsn3ohBwvpJgWve/HmfrB6DvlnBupFpvywC5MMR/F
         Vfyw==
X-Gm-Message-State: ALoCoQlxeXiOwu1CaQotL+v4KHPyL5o+J3T1EbBOzNEF3v8In+WRXoZ5dc0FgJZHc5QtcyUXl/G+
X-Received: by 10.53.1.231 with SMTP id bj7mr10441408vdd.49.1405551130186;
 Wed, 16 Jul 2014 15:52:10 -0700 (PDT)
Received: by 10.52.136.166 with HTTP; Wed, 16 Jul 2014 15:52:10 -0700 (PDT)
In-Reply-To: <xmqqegxlq799.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253715>

I had a look at the changes in origin/pu and they look sane to me.

make test   passes all tests too.


regards
ronnie sahlberg


On Wed, Jul 16, 2014 at 3:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> On Tue, Jul 15, 2014 at 4:33 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
>>> This is the next 20 patches from my originally big patch series and follow
>>> the previous 19 patches that is now in juns tree.
>>> These patches were numbered 20-39 in the original 48-patch series.
>>>
>>> Changes since these patches were in the original series:
>>>
>>> - Addressing concerns from mhagger's review
>
> One patch in the series did not apply cleanly on top of the tip of
> the previous series (now queued as rs/ref-transaction-0) and I had
> to wiggle it.  Please check the result (queued as three topics, this
> one is rs/ref-transaction-1 which is built on the abovementioned
> "-0", and the remainder from the previous round is rebased on "-1"
> as rs/ref-transaction), all of which are queued on 'jch' (which is
> part of 'pu').
>
> Thanks.
