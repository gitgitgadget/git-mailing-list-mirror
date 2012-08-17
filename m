From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v3] contrib: add win32 credential-helper
Date: Fri, 17 Aug 2012 13:50:43 +0200
Message-ID: <CABPQNSaBK=nyyW2bibTkQKFaihiyd8k_MHeUJRiBhA6tZ-XnFw@mail.gmail.com>
References: <1343409006-5056-1-git-send-email-kusmabite@gmail.com>
 <CABPQNSZt0a+447qbr6j9ELHfsmfr03VUw6-efAiu0vLicaKyEg@mail.gmail.com> <7vtxw2w5s4.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 13:51:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2L5O-0005DO-OQ
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 13:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293Ab2HQLvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 07:51:25 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:46219 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753557Ab2HQLvY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 07:51:24 -0400
Received: by vbbff1 with SMTP id ff1so3139938vbb.19
        for <git@vger.kernel.org>; Fri, 17 Aug 2012 04:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=jTj992ZdiISVO9/8XvsbfGvKiUJcNwLZgXaN7aKAy/U=;
        b=E/f7CrZrx6gy5v2ysQDBcNgNL/0Y9H449Rs3L7PpAp9wQubHMTgNSCJ8y/QujiNyvd
         3cuhhCZqiABp5p1Ph/KJHWl8wTXaBcGSxFmCiixniqH1HnyJh8c8YSqJO4PjVfowZfy4
         MvM5+1xfavLZADk0d42OqNvuwN1/x/rk525PiGE6iSyb9gA+R2dBSfdsdSaGVFhZbaHr
         RHGgAgDxV8QuZ0FLR8SQaTZzoOR8gi7aEqr40BxTCjYX3+BqRUpVQPtXLh1ZFR8xBDmu
         4Gmgfee4yMRhq98VWtA/rhe56uWeimR9ZKVLHERmzcKzSgSuDXghqeFDR1/SLk6RQI+N
         1ASw==
Received: by 10.52.35.99 with SMTP id g3mr1883668vdj.21.1345204283281; Fri, 17
 Aug 2012 04:51:23 -0700 (PDT)
Received: by 10.58.237.166 with HTTP; Fri, 17 Aug 2012 04:50:43 -0700 (PDT)
In-Reply-To: <7vtxw2w5s4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203611>

On Fri, Aug 17, 2012 at 5:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> On Fri, Jul 27, 2012 at 7:10 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>>> Since the Windows port of Git expects binary pipes, we need to make
>>> sure the helper-end also sets up binary pipes.
>>>
>>> Side-step CRLF-issue in test to make it pass.
>>>
>>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>>> ---
>>>
>>> Sorry for the delay, but here's the third iteration of my credential
>>> helper for Windows' credential API.
>>>
>>> The only change since v2 is that it now supports protocols without
>>> a host component, as suggested by Jeff King.
>>>
>>
>> ...aaand just as I sent it out, I realized that my Makefile was a bit
>> on the light side. Imagine this patch on top for now, please :)
>>
>
> I notice that I didn't queue either of these; are you still
> polishing them, or are they in good enough shape that it wouldn't
> make things harder for you if I queue it, with a plan to merge it
> soon after 1.7.12?
>

As far as I'm concerned, I consider this complete from my point of
view. Should I send out a new version with the fixup squashed in?
