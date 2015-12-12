From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 2/8] update-index: use enum for untracked cache options
Date: Sat, 12 Dec 2015 10:25:37 +0100
Message-ID: <CAP8UFD24Xm6bVYYJShDXui=ot+YpScaGZ9HC3K+Rqem3y1Rn0w@mail.gmail.com>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
	<1449594916-21167-3-git-send-email-chriscool@tuxfamily.org>
	<xmqq1tawlpqw.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD3+gsHZuaBweP83or=rEh-LFnz6=ycBCeuhApxp0PzN1A@mail.gmail.com>
	<xmqqh9jqi1ky.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD3AHMEZB+6Ajt8XSsecTp_PSxV_ZxFLbMAYgA3CDhPDng@mail.gmail.com>
	<xmqqio44g9rm.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 12 10:26:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7gRb-0000SG-R4
	for gcvg-git-2@plane.gmane.org; Sat, 12 Dec 2015 10:26:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbbLLJZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2015 04:25:41 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:35094 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbbLLJZj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2015 04:25:39 -0500
Received: by lbpu9 with SMTP id u9so76189634lbp.2
        for <git@vger.kernel.org>; Sat, 12 Dec 2015 01:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xVUnmsURIa9/OP3bqa6mEZ6iwyVQTOblKsmJ/oFO9BQ=;
        b=Pb6n0BztQm/9dB6gof0LT8QatikBJueoHnHLhoCt4UhksW76iVcI1TNzSZS9fecX5X
         4l8fcKttv6sUvbYtD2vbkE4ByR393njoRau4DHJFBNcdCcHsF6qgtAVVqNh2GdHJbMg5
         0sIE44cEPDCV0IclQ0gzLA9WZxC7gMtewL6A8UO1ug+wxot2nMjwERVogUfcJB9m3Nxq
         +YsOuKZeWsnZHzw1swFUjwv5Cq79K6N2w2tR0SFw7Hp+NkReF5U7K/edS4WAXhJ43+eW
         J607Vzcp1DthKVaF6n4x/ijw/7yUhYyTfG9pKBS57I2H9GGpUjTMtUWqTsVk+hraaqBG
         YVnA==
X-Received: by 10.112.184.45 with SMTP id er13mr9454500lbc.133.1449912337572;
 Sat, 12 Dec 2015 01:25:37 -0800 (PST)
Received: by 10.25.152.7 with HTTP; Sat, 12 Dec 2015 01:25:37 -0800 (PST)
In-Reply-To: <xmqqio44g9rm.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282299>

On Fri, Dec 11, 2015 at 6:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>>> As you know I am bad at bikeshedding; the only suggestion in the
>>> above is to have common UC_ prefix ;-)  Don't take what follow UC_
>>> as my suggestion.
>>
>> I am bad at finding names too, so I think what you wrote is pretty good.
>>
>> I thought about the following:
>>
>>      UC_UNDEF
>>      UC_DISABLE
>>      UC_ENABLE
>>      UC_TEST
>>      UC_FORCE
>>
>> but I am not sure it is much better.
>
> I hated the DONTUSE/USE I listed, and I think DISABLE/ENABLE is much
> much better.  I do prefer unspecified over undef, though.

Ok, then it will be:

    UC_UNSPECIFIED
    UC_DISABLE
    UC_ENABLE
    UC_TEST
    UC_FORCE

Thanks,
Christian.
