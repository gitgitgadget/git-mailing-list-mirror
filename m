From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH] Documentation: add instructions to help setup gmail 2FA
Date: Fri, 27 May 2016 17:17:00 -0400
Message-ID: <CANoM8SV6=Fita3a4y7c51OKmhD-r9ASjxMJWcwm=N2HD1Pd3fQ@mail.gmail.com>
References: <1464381597-27634-1-git-send-email-rappazzo@gmail.com> <xmqqpos7p5vy.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 23:31:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6PMN-0002gD-BV
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 23:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754780AbcE0Vby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 17:31:54 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36260 "EHLO
	mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915AbcE0Vbx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 17:31:53 -0400
X-Greylist: delayed 872 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 May 2016 17:31:53 EDT
Received: by mail-it0-f65.google.com with SMTP id p81so665245itd.3
        for <git@vger.kernel.org>; Fri, 27 May 2016 14:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NfPP1M1mN5j3QzNsFFQBx4zVr4BdyB3d9bdfW/1nLaE=;
        b=SzUCh0Riovv3/qnufl/S3x1y2s1AxyPzAaGUdKrf0sOfBN9HJaqyAUoYX8pyRxO9to
         5tjVOHIwUDgREGd3IIxkZkujw5UP7O0uiJIjtfwJSn2f91fR9b6UFGffswAqX69p4i1K
         qdqrjEJ0dM3IIliBG75D+khAc3rRb5RQgEwsSE3Eqco0mTPXVpGuNAEKbF2udRbI+oVj
         lZWvDHZ24sn/kN7s72EkwK7/0s8e/NuqX/lTUXEr8h3SiDX/Z30WySA0P+iwRfCLzjtU
         q2WNGbYiJQv9yUn9nnIid0d+C8gYT9a55MH7fWr2A2JmDlc7UzYSObCjK9kshXfnn9/R
         C+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NfPP1M1mN5j3QzNsFFQBx4zVr4BdyB3d9bdfW/1nLaE=;
        b=SpaS0CWcLA9WxnO48mTLJsX+YjUJ6/VHa2pnWHSmth0na+Z1cbnF9Bwx+DJuYAuWYE
         Iacq01nFRhDEGxgqKXjxrLk02mWnAwYp1dhj/j6uUQL68FKrkgTTwWv2PibvKdRjuTUV
         uSzMrs9TAJ6q7zjbBa+8oz1nYVtPM46cYfubqNFXj2UXzZWo7yYjoXZK/2X/yOkr+/Di
         b6+++O4xXNk8viSQmr9RyFYuW5188Yx6RWU0u1qCa/3mLnkKOUxW9COLEZArIUI0qGjs
         TNZq+iyj+4mr9Rs8cwFzm4O/rJzNokG48svFk0czzZtuECJzaXf6ZPoiCrgIbSTg49RI
         fhvQ==
X-Gm-Message-State: ALyK8tI1lIXLCayGgRB802RwtQbLL6ViYsoAuaagBGSHv4wofQ58wfLE9UMvtvwIVfPt3VTxZ8copq61liNbfg==
X-Received: by 10.36.131.67 with SMTP id d64mr637836ite.34.1464383839970; Fri,
 27 May 2016 14:17:19 -0700 (PDT)
Received: by 10.107.34.11 with HTTP; Fri, 27 May 2016 14:17:00 -0700 (PDT)
In-Reply-To: <xmqqpos7p5vy.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295797>

On Fri, May 27, 2016 at 5:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Rappazzo <rappazzo@gmail.com> writes:
>
>> For those who use two-factor authentication with gmail, git-send-email
>> will not work unless it is setup with an app-specific password. The
>> example for setting up git-send-email for use with gmail will now
>> include information on generating and storing the app-specific password.
>> ---
>
> Sounds good.  We'd need your sign-off in order to be able to use
> this patch, though.
>

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>


>>  Documentation/git-send-email.txt | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
>> index 771a7b5..edbba3a 100644
>> --- a/Documentation/git-send-email.txt
>> +++ b/Documentation/git-send-email.txt
>> @@ -450,6 +450,19 @@ edit ~/.gitconfig to specify your account settings:
>>               smtpUser = yourname@gmail.com
>>               smtpServerPort = 587
>>
>> +If you have multifactor authentication setup on your gmail acocunt, you will
>> +need to generate an app-specific password for use with 'git send-email'. Visit
>> +https://security.google.com/settings/security/apppasswords to setup an
>> +app-specific password.  Once setup, you can store it with the credentials
>> +helper:
>> +
>> +     $ git credential fill
>> +     protocol=smtp
>> +     host=smtp.gmail.com
>> +     username=youname@gmail.com
>> +     password=app-password
>> +
>> +
>>  Once your commits are ready to be sent to the mailing list, run the
>>  following commands:
