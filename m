From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [RFC/PATCH 1/2] log: add "log.showsignature" configuration variable
Date: Fri, 27 May 2016 09:31:39 +0530
Message-ID: <CAFZEwPOajimmwh9DW=zbacqLYh1mREii8QGWTMiMQFg0TsdVQQ@mail.gmail.com>
References: <20160526130647.27001-1-mehul.jain2029@gmail.com>
	<20160526130647.27001-2-mehul.jain2029@gmail.com>
	<156149583.51074.1464270131166.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<CA+DCAeSYr-q-0uSeDymJPHZwVZDZhh4yHH48peLOKodbxW1N7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>,
	Austin English <austinenglish@gmail.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 27 06:01:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b68y0-0004cQ-Bb
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 06:01:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbcE0EBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 00:01:40 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:34222 "EHLO
	mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbcE0EBk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 00:01:40 -0400
Received: by mail-yw0-f169.google.com with SMTP id c127so95561809ywb.1
        for <git@vger.kernel.org>; Thu, 26 May 2016 21:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=upC3i9PKgsOdLwNtQVOc868mrGN3YI8bbCeGC16FIZs=;
        b=QXcezHKqzk0syAj18p6EyUKgcgibS5s1QVWTJIx3Pvw33wEmbbjiw3z/ljuRfbXzK1
         ZhVLOOQIg0YmZ8iRnk+EYCSyLdcXA5eEYKBTQm/d/1ePZOedmWvo9ySIb6n+QJS0oC55
         //qlqPQrJnY3ymDMwruzfgYCjxBZMoh5CBXTY2VwOFkNeD/+fpn9d7wfty9VtSKNtEL0
         kvzg/7sXKgj6RlKGU/ZLuYjh8xy89B3gh+9cod47NFIf4hNC6n3Q9HBYPAm/vLGyyt3+
         3wMg13CausURbsoElCxJmx5DQNS6FNEWYzi9ee+UYZ8KvAQSd7bucxI349Z0ZNmudspK
         sU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=upC3i9PKgsOdLwNtQVOc868mrGN3YI8bbCeGC16FIZs=;
        b=HSy1yyECxUavd2oYbAYPtYRZndVtJka8ptz73jMVTdoatjWrUHlixzoIMldwfEeIIL
         BzWas1gA6HtMtaux0zGEWROkbbifjLSd0fv2mwDuuz0ocgbz1WiNgF7AG+8/z7McPkC9
         qnjraD4TxtjWq0KTj+n2PGmEng0mtyFFgFo9UA7XA8r8nfd0xG9ybmMyX0JyMnR4Mwn6
         5ptgEo2bNtUhLKG3OFlvm9oTKX0r/Vya95kiQ6IVBuzFCrIAxurpMTXt5PGk81sEBF/B
         foMqjbdW3CNODHmjuQLV5UvWxEwlBMv9GzHIJuPqpcGcx+ATcr4mYVW3CkN2Yb6N9QXp
         PGSw==
X-Gm-Message-State: ALyK8tKtvShwsz+EilCcvhrrICG6A449vN2mIq2CNLWSL92pcFtL3rbwI9eFgRa27qVyOVJeuBafpKZjfczjGQ==
X-Received: by 10.129.81.87 with SMTP id f84mr7265307ywb.154.1464321699186;
 Thu, 26 May 2016 21:01:39 -0700 (PDT)
Received: by 10.129.124.132 with HTTP; Thu, 26 May 2016 21:01:39 -0700 (PDT)
In-Reply-To: <CA+DCAeSYr-q-0uSeDymJPHZwVZDZhh4yHH48peLOKodbxW1N7A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295727>

Hey Mehul,

On Thu, May 26, 2016 at 8:34 PM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> Hi Remi,
>
> Thanks for your input.
>
> On Thu, May 26, 2016 at 7:12 PM, Remi Galan Alfonso
> <remi.galan-alfonso@ensimag.grenoble-inp.fr> wrote:
>> Hi Mehul,
>>
>> Mehul Jain <mehul.jain2029@gmail.com> writes:
>>> +test_expect_success GPG '--show-signature overrides log.showsignature=false' '
>>> +        test_when_finished "git reset --hard && git checkout master" &&
>>> +        git config log.showsignature false &&
>>
>> Any specific reason as to why you don't use test_config like in the
>> first test?
>
> None, actually. It was just that I forgot to use test_config while
> writing the tests. I will make changes  accordingly as test_config
> automatically unset the config variable, which is necessary.

Or you could probably use 'git -c' which makes it all the more compact.

Regards,
Pranit Bauva
