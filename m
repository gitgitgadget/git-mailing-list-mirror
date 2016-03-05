From: Guilherme <guibufolo@gmail.com>
Subject: Re: Git clone sends first an empty authorization header
Date: Sat, 5 Mar 2016 11:46:33 +0530
Message-ID: <CAMDzUtyAzRsYYu+Txg8X6QztHygmPrrxfYpYn5kcfsQdRP+dXg@mail.gmail.com>
References: <CAMDzUty+O2Gu7o4bFib71AaNZn647WQ1v7ceiznHOs7-xwZGUg@mail.gmail.com>
 <CAGyf7-HAaWp+V99aP1b7HiZwgHXCTiAfL5865ng+9-PY_UwuDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 07:17:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ac5X2-0007Pm-DE
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 07:17:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbcCEGRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 01:17:24 -0500
Received: from mail-vk0-f54.google.com ([209.85.213.54]:32854 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbcCEGRN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 01:17:13 -0500
Received: by mail-vk0-f54.google.com with SMTP id k1so58004580vkb.0
        for <git@vger.kernel.org>; Fri, 04 Mar 2016 22:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wMNgUerg1PU4/bYqlCuFxqUXs6DxIswqNkvipsTGKcI=;
        b=oRowOtaMcb3FV/kAl5EksFLR99ycp20TXzYqRhzHmCzZ28m95qwTQBBWv72QJMf2Zz
         /lG8nHksUSNFB8jhoyI2EBUl+3SffYuNLCea8HdiSvG4OSMUVzoUk2ytiErsc1l15yu4
         nTfmqnKKvFjX487aJl38Cijnp+uoJ4/I43tgLvZNe0TtwFoTgo0+HI7KP0Bw72orubT2
         ISDf1nhO967QdXkVHiTyooBEy53RQEbL9GwRJWYOmz2LmR0elK/Z1xX+hd7NZ31crMEg
         dCP1imbNMZlmMuUARotPzjTRr46nfzzeEWZb13WyHHRCHSS+iOY1bX8P+gkmc+H3NfqZ
         JV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wMNgUerg1PU4/bYqlCuFxqUXs6DxIswqNkvipsTGKcI=;
        b=WKc1BtFbF7WRXTqd1G1jKp0ND+3Acd+TnBIJMkeD36y8xCYrPKlGOED8/3UNcj+lWN
         hdd6Pd9j5zjrdI/cwjomMGvyatNUH65UmHnqtVLrfI6AZjzkCEg/GdNPiUowahfAgSAL
         3Fo64Y+I/5qPRHL0azS+YNqh8iG76kwssW29NiW8ovqtABYIGC5RUB0m/GxlugOEyT1x
         o0vtHj/PdGfemByQiB+PEeD6+iHEcTMpPOxYb+GqyatzxJnpp8a4xjxqbnl96s7wM2zp
         B5wIt+MeukMDBavONjwTQfUUhTvx8OSp6OmGHfEU46Vi0tFvG/YJhYt78tZmMg+mIwBU
         Q9aw==
X-Gm-Message-State: AD7BkJJGveAxOrINOpJV2IXGZP7D8MSKo37rLjS6hPTsVbKVrB0H5nrZxcLPZ1dZVe19bybBu7LtHGUee9Po5w==
X-Received: by 10.31.135.79 with SMTP id j76mr8485280vkd.91.1457158632631;
 Fri, 04 Mar 2016 22:17:12 -0800 (PST)
Received: by 10.31.162.145 with HTTP; Fri, 4 Mar 2016 22:16:33 -0800 (PST)
In-Reply-To: <CAGyf7-HAaWp+V99aP1b7HiZwgHXCTiAfL5865ng+9-PY_UwuDw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288295>

Hey Bryan,

Yes that will happen he will get a prompet for username/password but
he already provided them in the URL and it worked before. He could
clone. I think this is a little bit confusing.

My problem is that the tool I'm trying to build is trying to provide
the username used to log in via an environment variable. And due to
the fact that the anonymous login is always the first to be tried,
even if the user provides an username/password on the URL I'm not able
to retrieve it.

On Sat, Mar 5, 2016 at 11:20 AM, Bryan Turner <bturner@atlassian.com> wrote:
> On Fri, Mar 4, 2016 at 9:51 PM, Guilherme <guibufolo@gmail.com> wrote:
>> Hi,
>>
>> When doing basic authentication using git clone by passing the
>> username and password in the url git clone will first send a GET
>> request without the authorization header set.
>>
>> Am i seeing this right?
>
> I believe this is an intentional behavior in either cURL or how Git
> uses it. Credentials aren't sent until the server returns a challenge
> for them, even if you include them in your clone URL or elsewhere. So
> yes, you're seeing it right.
>
>>
>> This means that if the counterpart allows anonymous cloning but not
>> pushing and the user provided a wrong usernam/password, it has two
>> options:
>
> I'm not sure why this would be true. If the remote server allows
> anonymous clone/fetch, then you never get prompted for credentials
> and, even if they're supplied, they're never sent to the remote
> server. If you then try to push, if the server is working correctly it
> should detect that anonymous users can't push and it should return a
> 401 with a WWW-Authenticate header. When the client receives the 401,
> it should send the credentials it has (or prompt for them if it
> doesn't have them) and the push should work without issue.
>
> Perhaps there's an issue with how your server is setup to handle permissions?
>
>>
>> 1. Allow the access and leave the user to figure out why he is not able to push.
>>
>> 2. Reply by setting the WWW-Authentication header and see if a
>> password/username is provided. This has the downside that if no
>> username and password is provided the user will still get a login
>> prompt for password and username. Upon entering twice nothing he will
>> still be able to clone. This can be confusing.
>>
>> Can this behaviour of git clone (and I guess all the other parts that
>> do basic auth) be changed to provide the authentication header right
>> on the first request? Or am I doing/interpreting it wrong?
>>
>> Thank you.
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
