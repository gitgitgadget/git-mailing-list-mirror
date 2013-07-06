From: =?UTF-8?Q?Beno=C3=AEt_Person?= <benoit.person@ensimag.fr>
Subject: Re: [PATCH v8 3/7] git-remote-mediawiki: New git bin-wrapper for developement
Date: Sat, 6 Jul 2013 11:45:46 +0200
Message-ID: <CAETqRCh0_gc_MqN5eXLn_guCELYKgfHdN3986d9WPubxUFeLqQ@mail.gmail.com>
References: <1372970340-6545-1-git-send-email-benoit.person@ensimag.fr>
	<1372970340-6545-4-git-send-email-benoit.person@ensimag.fr>
	<vpqfvvtzdw4.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Celestin Matte <celestin.matte@ensimag.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Jul 06 11:45:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvP3x-0004hA-Pw
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jul 2013 11:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837Ab3GFJpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jul 2013 05:45:47 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:39718 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783Ab3GFJpq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jul 2013 05:45:46 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so7034961ief.12
        for <git@vger.kernel.org>; Sat, 06 Jul 2013 02:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=QWSRFMIpZx7LV+0mSS9NVEcN9Mwl97M82aYGPkhW52w=;
        b=ant5cXR0S6g+mWoBuSv08JalmvQ5fLChQPht2ocwXujWI8HIHgilXAH/oD9yu7Two9
         csy/pq5NDOUlkPx3In57zQTPo4Dn42FTpXx6sPIj7/KIwNTkRJIHznDoR29jkQshF8Lp
         gv5GjiJcMkyy3+Ybi+ejwbdNTvTkO1z4Z0zb33nkxhgPtDbEZ2QsTid8kLlNmb/bPiW4
         KHkGgKAidKfNMJqvmxuLkblZLFB8axN4t7IOHWaRRAbSiNkwz9ui9L5aAGGtHlQNCGAR
         LohD11BBzHx3loBfN21vy8BdDxVOcIiy72ZLiiQAWaB8cC9WPRnNwVJhjXqIoXfOJLei
         IX6Q==
X-Received: by 10.50.20.232 with SMTP id q8mr6024416ige.0.1373103946380; Sat,
 06 Jul 2013 02:45:46 -0700 (PDT)
Received: by 10.42.210.20 with HTTP; Sat, 6 Jul 2013 02:45:46 -0700 (PDT)
In-Reply-To: <vpqfvvtzdw4.fsf@anie.imag.fr>
X-Google-Sender-Auth: H6sWZ6w8Hs6PSrif-SFdDoAuc-M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229698>

On 5 July 2013 09:04, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> benoit.person@ensimag.fr writes:
>
>> --- a/contrib/mw-to-git/Makefile
>> +++ b/contrib/mw-to-git/Makefile
>> @@ -2,6 +2,12 @@
>>  # Copyright (C) 2013
>>  #     Matthieu Moy <Matthieu.Moy@imag.fr>
>>  #
>> +# To build and test:
>> +#
>> +#   make:
>> +#     bin-wrapper/git mw preview Some_page.mw
>> +#     bin-wrapper/git clone mediawiki::http://example.com/wiki/
>> +#
>
> The colon after "make" and the indentation look weird. Shouldn't this be
>
> +# To build and test:
> +#
> +#   make
> +#   bin-wrapper/git mw preview Some_page.mw
> +#   bin-wrapper/git clone mediawiki::http://example.com/wiki/
> +#
>
> ?

oops, yes definitely.
