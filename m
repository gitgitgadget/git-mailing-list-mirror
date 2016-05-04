From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3 2/2] travis-ci: build documentation
Date: Wed, 4 May 2016 10:04:24 +0200
Message-ID: <32CC7549-3A50-42F3-A6CC-9B15EFA01A46@gmail.com>
References: <xmqqziscw2g7.fsf@gitster.mtv.corp.google.com> <1462220405-12408-1-git-send-email-larsxschneider@gmail.com> <1462220405-12408-3-git-send-email-larsxschneider@gmail.com> <xmqq60uwrxyi.fsf@gitster.mtv.corp.google.com> <6483CF6A-5C14-42C9-BE1A-6D6AA33999BB@gmail.com> <xmqq8tzrp2pd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git Users <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 10:04:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axrnV-0000MU-SQ
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 10:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757198AbcEDIEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 04:04:31 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35826 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421AbcEDIE2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2016 04:04:28 -0400
Received: by mail-wm0-f52.google.com with SMTP id e201so176288899wme.0
        for <git@vger.kernel.org>; Wed, 04 May 2016 01:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ow5PWuYxQX3rJv1auNCoLULQl4gpEHN2+nglJck0apU=;
        b=0WO0xkUn1qZo3kxz54rl7m3ZC2izhOJCpKvqYx0alWx+cKdE2+ahMGvWeeW/48SUbs
         IxVqKdNckdDuLPXn/2zg5coLlXrHbxAr4NXW6ngOz+8nlEIDviCsAtTgmoE/1GpIRAS/
         7uORDgPgAxB7LF57LIuDVBDeaVI8+nAbroqK3mKrFl/DYKS5Y9e/e0jJ2xMaQJMnyJB+
         EhLckOjlTddgyhHQf+OVLtqyUHu7crrG9niXf5t7joDxN1R8865Kj41XnOptR0prU/0L
         sftmVtcknkd92sZDfiMRb42NRd8fXYZtYiMeYZV4DdkpNpRHoOpKj3XcMXO9jgR7iFJj
         0Z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ow5PWuYxQX3rJv1auNCoLULQl4gpEHN2+nglJck0apU=;
        b=H0Txi302zDXKF5g+PzdF9Qmnufwa4yTMfCnJRe5WFoEPpM5tcXscYRq6bXyo8QH8M2
         GYpgMQlThQBpgWv6VuYAUpTPbIqev2u9XF4W3B8H9pLl0IiYgt+yQC7Qjkwn2GktIklG
         VDyUtyKDtKHaDD3oNeTRIIvF/xQye8qjUf7fU5njpLvZ+zIqBq+vpOeQvc2RYVpGKnoH
         4PgpfYPJmwNYgOFBtZvQ1Jgv1UJeLcqP7csCdFZ/OOFSZGUpoKWUYo9kjK4BquP+JG3e
         T46wAs+KGCowO1zkK9kfeAc90Ek1Sn/RrRxmGFD3zipbbhwxwV2ehCPnGWXbZ5vxcm+M
         u9iA==
X-Gm-Message-State: AOPr4FWHjykF23x6dAj78DVY40vBKLL09SNG3uiQE1VV5CzhGdN2+k0WYbgRZ8QPeZSBfA==
X-Received: by 10.28.14.73 with SMTP id 70mr7450231wmo.15.1462349067073;
        Wed, 04 May 2016 01:04:27 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB740E.dip0.t-ipconnect.de. [93.219.116.14])
        by smtp.gmail.com with ESMTPSA id f188sm3481251wma.2.2016.05.04.01.04.25
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 May 2016 01:04:26 -0700 (PDT)
In-Reply-To: <xmqq8tzrp2pd.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293510>


On 03 May 2016, at 17:43, Junio C Hamano <gitster@pobox.com> wrote:

> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>> On 02 May 2016, at 22:45, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>>> larsxschneider@gmail.com writes:
>>> 
>>>> +set -e
>>>> +
>>>> +LINKS=$(grep --recursive --only-matching --no-filename --perl-regexp \
>>>> +    '(?<=linkgit:).*?(?=\[\d+\])' Documentation/* \
>>>> +    | sort -u \
>>>> +)
>>>> +
>>>> +for LINK in $LINKS; do
>>>> +    echo "Checking linkgit:$LINK..."
>>>> +    test -s Documentation/$LINK.txt
>>>> +done
>>> 
>>> Please separate the above link check out of this step and do so
>>> separately after the move of test body to a separate script
>>> settles.
>> 
>> OK. I also wonder if the link check should rather go to the 
>> "check-docs" Makefile target?
> 
> That sounds like a good direction.
> 
> Which in turn means that people on all platforms are welcome to run
> it, which in turn means that the script must be even more portable,
> with avoiding GNUism and bash-isms etc.

OK. I am not that experienced with shell scripting and therefore it
is hard for me to distinguish between the different shell features.
Do you know/can you recommend the most basic shell to test/work 
with? A quick Google search told me that "dash" from Ubuntu seems
to be a good baseline as it aims to support pretty much only POSIX [1].

Thanks,
Lars

[1] http://www.cyberciti.biz/faq/debian-ubuntu-linux-binbash-vs-bindash-vs-binshshell/
