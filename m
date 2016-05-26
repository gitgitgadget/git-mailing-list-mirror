From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: [RFC/PATCH 1/2] log: add "log.showsignature" configuration variable
Date: Thu, 26 May 2016 20:34:16 +0530
Message-ID: <CA+DCAeSYr-q-0uSeDymJPHZwVZDZhh4yHH48peLOKodbxW1N7A@mail.gmail.com>
References: <20160526130647.27001-1-mehul.jain2029@gmail.com>
	<20160526130647.27001-2-mehul.jain2029@gmail.com>
	<156149583.51074.1464270131166.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Austin English <austinenglish@gmail.com>
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 26 17:04:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5wpi-0005vY-Aw
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 17:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008AbcEZPES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 11:04:18 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:34135 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900AbcEZPER (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 11:04:17 -0400
Received: by mail-qg0-f42.google.com with SMTP id 90so38297013qgz.1
        for <git@vger.kernel.org>; Thu, 26 May 2016 08:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=wu9DkLtQwCl8Uig/VR5JfX5Tmeb5jQNreyzT2q6GPgQ=;
        b=HOFlM+CQf1nrdzKhKXau6XoChXGxHn6THGg3gSpI+tHbk8d8MpZVZr2Zs7xSRZERwd
         D5rfNsen5a2/s6jYdp+qkFWLEvbveBotMrQfdQzvGGWfeyUdy/TOEBJ/9xO8wPG48rFP
         ytJjFQWIqHTlmXbPfgzeRPM+6NiIxzRyKXKPxu6twxEPWrSHHNXtj+vpxevUH3q/mjcl
         k/rELM/PysSXl4N5vY5i6Cwg3dUV/d0DjgPlnkyHzutGKnP1j5y7sSAXSkI4j7LqUKWB
         Pub5ji48FnKtDGJYj0d7x+EiLieFyY2Fg/qUED4p91R/06mNZ+imYyMhYYD79OUsGfsz
         xlrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=wu9DkLtQwCl8Uig/VR5JfX5Tmeb5jQNreyzT2q6GPgQ=;
        b=cNFHKHB2dvihPQWyFzKOMLU6OPu/Tq2ZDqMj5crMQO6BrvKI0mWHwoLZNOfVK1SE5o
         rwGpe7L8BhBhI+s8Cm+6lbUnuxsT6/hdZjJn3es/eAC1PKNaREcyroMZ0FOzBxMBDIXO
         ngzNFprBamjrpO5q//xqwcYTO67LLOAL30KPZEoerozQIRMFufoG7AY2Izs12Rj6F9O+
         1YjuiTZkNryFxZXzxlSBt3Tmu3GUPDvaaKnZlNokM12NptNZd4ptI8Vf6fbD4R/+rr0j
         9nN9oFF8Th+PTO2Q8BdpPUkDo5kJqcf1dx9qpyHh+dJDalKYvTzxVa4tptTpfMdtH34p
         9bqg==
X-Gm-Message-State: ALyK8tKo0bHdCQYj66BlhFeI0evjri8lW7sLGa2Jm8jYUK2Umv3lO0QbRxBDa5ORGx6uriAozBZeQ3WIlIpoGg==
X-Received: by 10.140.170.5 with SMTP id q5mr1170363qhq.50.1464275056334; Thu,
 26 May 2016 08:04:16 -0700 (PDT)
Received: by 10.55.51.212 with HTTP; Thu, 26 May 2016 08:04:16 -0700 (PDT)
In-Reply-To: <156149583.51074.1464270131166.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295658>

Hi Remi,

Thanks for your input.

On Thu, May 26, 2016 at 7:12 PM, Remi Galan Alfonso
<remi.galan-alfonso@ensimag.grenoble-inp.fr> wrote:
> Hi Mehul,
>
> Mehul Jain <mehul.jain2029@gmail.com> writes:
>> When log.showsignature set true, "git log" and "git show" will behave
>
> 'When log.showsignature is set to true' ?

Pardon me, but I don't understand your question.
I think you are suggesting me to write
"When log.showsignature is set to true"
instead of
"When log.showsignature set true".

>> +test_expect_success GPG '--show-signature overrides log.showsignature=false' '
>> +        test_when_finished "git reset --hard && git checkout master" &&
>> +        git config log.showsignature false &&
>
> Any specific reason as to why you don't use test_config like in the
> first test?

None, actually. It was just that I forgot to use test_config while
writing the tests. I will make changes  accordingly as test_config
automatically unset the config variable, which is necessary.

Thanks,
Mehul
