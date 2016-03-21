From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH][Outreachy] branch: allow - as abbreviation of '@{-1}'
Date: Mon, 21 Mar 2016 12:03:55 -0400
Message-ID: <CAPig+cR0dvKUOVwd=Mt=4mzEDVE4NVanPJTdztzEQajzm71=pw@mail.gmail.com>
References: <1458305231-2333-1-git-send-email-elena.petrashen@gmail.com>
	<xmqqvb4jrcle.fsf@gitster.mtv.corp.google.com>
	<CAPig+cQYYPmUtOoTGDzzQJC8n+9UoVEskmnZ19E=rroyU5+Pkg@mail.gmail.com>
	<CAJPOeMd-zeThDhx-OWW_6LwG9A+U3UU-oKPOZGcycR-xQRPcgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: elena petrashen <elena.petrashen@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 17:04:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai2JF-0001V5-Os
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 17:04:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756564AbcCUQD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 12:03:57 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:34064 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756391AbcCUQD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 12:03:56 -0400
Received: by mail-vk0-f51.google.com with SMTP id e185so219924078vkb.1
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 09:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=27OEnP8GwtWFS6LaCxJjunaI2e4IpJ7ejTdyxpH/4VU=;
        b=mQcZvrHx647DVJIMBLdNuUMbKnNn5wsOhVn8dVZX1JXl4K2LztsyScMJLvkcpYmZw9
         T6wtCCtMa1zShcEd0lpLk/KhO1+5GNButLC30WouVsX5VxLJCPPxlClRITaLcnpkCKUO
         mAf9jvhmoNirmrlwW7g518mlWxy0TU12Ap0zgHC4YTiVKqXALFV5sxwUTxTUJ9nRtgHk
         83KbGAUoPAJA+9MuDY9GV1GjOXt+EEOx+rvHcedQyHNCDM1isE1YI7wxTqnz2rI9cBXN
         ZmqKM3a756WLEYi8c+VYnS9mkCMOrUg/vBZyVn+YrEqIr62adsX+tyIBSWkZckp8oYcS
         E+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=27OEnP8GwtWFS6LaCxJjunaI2e4IpJ7ejTdyxpH/4VU=;
        b=I4KI3sPS7Xe/Y2N0Y4B8a/hGRFKu9CRKK66ViHEdmnNc8uC4FLrAO7xBFxb+6K6Zcq
         KCqFPcZh6u8aPJtrNdksB0ZH2OkjIzuVj3oWRO88SUbjrV2CKqmlJlqHOMoYCN7RX55L
         ePMTg//FCfyATmbULl4IodZQcKeMAzGA4WgaGbGBkF98v6dsyKJZcVzLs/TqwJ5bP77K
         MJaiHA3RCp9jMpluq7zv79W7MH8KEU/kjwDSk39mTbXDe93hTVplEBpna4PsWu9dsWI/
         iVQkQsboQz+aoTqTdk/IhitH+z4G205FqscsDCr2T9j+JLO06Ogl/SoBEYlo9XHxWK3+
         eRVA==
X-Gm-Message-State: AD7BkJJENiZTJXn593y2te/JsPW/qeo+DQKInOSraeaY0+BTKrFTEveJE0p4AOk3PMPX7SXTfCcHtlHpfm4HUQ==
X-Received: by 10.31.141.2 with SMTP id p2mr32879346vkd.37.1458576235232; Mon,
 21 Mar 2016 09:03:55 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Mon, 21 Mar 2016 09:03:55 -0700 (PDT)
In-Reply-To: <CAJPOeMd-zeThDhx-OWW_6LwG9A+U3UU-oKPOZGcycR-xQRPcgg@mail.gmail.com>
X-Google-Sender-Auth: RroHEO1Pa7oMxh2sdLWO4GXpOKU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289422>

On Mon, Mar 21, 2016 at 11:12 AM, elena petrashen
<elena.petrashen@gmail.com> wrote:
> Hi Eric, Junio,
>
> thank you very much for your feedback! I honestly apologize I
> got so many things wrong.

No apologies necessary. We understand that it takes time for newcomers
to the project to absorb the codebase and become familiar with Git
development. And, aside from gauging technical ability, an important
aspect of these microprojects is to expose the candidate to the Git
review process and see how the candidate absorbs and responds to
review comments.
