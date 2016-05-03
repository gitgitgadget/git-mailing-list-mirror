From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/3] submodule deinit: lose requirement for giving '.'
Date: Tue, 3 May 2016 12:22:12 -0700
Message-ID: <CAGZ79kb=jNKFPrnfYD5u64o6HBv5deh2QBpt-wSL4YxVSDNiuQ@mail.gmail.com>
References: <1462227844-10624-1-git-send-email-sbeller@google.com>
	<1462227844-10624-3-git-send-email-sbeller@google.com>
	<xmqqoa8nnjld.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaHmtRooJ7J6BknqWDkVFN0Bx3xngkEH0CnAp7Aaehnig@mail.gmail.com>
	<xmqqzis7m023.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 03 21:22:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axfu0-0001qX-AU
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 21:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756119AbcECTWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 15:22:21 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37726 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755635AbcECTWO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 15:22:14 -0400
Received: by mail-ig0-f181.google.com with SMTP id s8so29086949ign.0
        for <git@vger.kernel.org>; Tue, 03 May 2016 12:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=gTpWIYAqfZn5IWbSeGIet9ZkDZIPtUuT41OCfyDKNKU=;
        b=GpKP14t+VhGa65OaKT+UwbMQUk+3AfpVnE5Zp2Vgpf0puBrDtr24AwtL9ISLptUrxW
         kDOVyVKgXq3yVZRa1FZG70F32hB4ktvPxoCY+naoiZtSMZEPwxo32nc37LN378JkLqPG
         hCbuUKF5EBVjqJVFWwr50FntJQQ4tpatFcTqiYuAJp8zNPNQT6Fsu2VrogcTFXJ1TiUK
         TFIPXYheebDleAtD32bDsPsGn6TF7w4MfR3A8BFhtLhPnKXGtM3iCH4A52kXLIuXxhWN
         B5qQV0BnZFUsPe8RjipYfWK8e08P3H37J5ELH3z0QZG45Ys4kpiMnked8afFRF81yDnE
         rNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=gTpWIYAqfZn5IWbSeGIet9ZkDZIPtUuT41OCfyDKNKU=;
        b=AHWedAvBm6OK098EaVFr8Kru7EM7VsRvJnGRS4ajRCkHEU1Re1sV6BfnOVdbsOh92i
         TYuDnt2NF2K3hbZqz9l7N/I/8fHSb1bemvD0UC2Nv8MEPD8yB4gUS2g7XS9yJxQGOy5B
         oKkPkEDuVpL7mTkfzpqMrAqlmGLLp8M6Owqu9D5z5R0ItPuReJO/ure9xb4j1jynsDmC
         9haWWB+n+LNchX8bU3L+JoPvLZjhX6Zxfd2Ew8exd6lfnk5sd3upF8IFxYo4UTBgITnx
         pYgDyIIlZpYDMmuakcgDPrBDC12GJB7a9l58bMom5cGyWr4/UCtXNq25QsrWMjrriGIF
         rYRQ==
X-Gm-Message-State: AOPr4FVOleyz082+deSXxc4d0v/y/ChC+a8z7NXILhbgVwH4T2l/2wFap4G01Mc1Z7ehwDQUgC7cPKpoTKiW9kyY
X-Received: by 10.50.170.68 with SMTP id ak4mr5631173igc.93.1462303332308;
 Tue, 03 May 2016 12:22:12 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Tue, 3 May 2016 12:22:12 -0700 (PDT)
In-Reply-To: <xmqqzis7m023.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293441>

On Tue, May 3, 2016 at 12:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> On Tue, May 3, 2016 at 11:07 AM, Stefan Beller <sbeller@google.com> wrote:
>>
>> So maybe we want to add a check that no pathspec arguments are
>> given when
>> --all is given?
>
> Yeah, I overlooked that case.  Just like "commit -a path" errors
> out, we should.

Thanks for the patch, though. I'll add the error-out in a resend of the series?
