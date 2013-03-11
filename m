From: Dmitry Ilin <dmitry@mylovecompany.com>
Subject: Re: Textconv
Date: Mon, 11 Mar 2013 15:30:21 +0400
Message-ID: <513DC04D.9090904@mylovecompany.com>
References: <513DA7E1.7050206@mylovecompany.com> <vpqtxoicl2l.fsf@grenoble-inp.fr> <513DB273.2090007@mylovecompany.com> <vpqd2v6b4n5.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 11 12:30:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF0wP-0001hZ-Rb
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 12:30:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754010Ab3CKLa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 07:30:27 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:53406 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970Ab3CKLa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 07:30:27 -0400
Received: by mail-lb0-f177.google.com with SMTP id go11so2966692lbb.22
        for <git@vger.kernel.org>; Mon, 11 Mar 2013 04:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mylovecompany.com; s=google;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=T63jvYqPCzQB7WH+d6OIbPbsN1BVVDtmIbNjRsfWrBI=;
        b=YJe4blPe2hj5sUw4/8VLh8vVNYziI1EjN6LW2Weu31T+ag/TMEx7Jzhp0rJduNaZkx
         s70PvnQVNIEd9ZJH/yTKfvyq4E9XyTqAcKJu+AzjBGKHvYpamRpDbSqUhvAuyOhjsEWE
         qRnqWO240izSEpIRxku4AdBGD7PQVKyeVMd1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=T63jvYqPCzQB7WH+d6OIbPbsN1BVVDtmIbNjRsfWrBI=;
        b=ly/mULB1WZsujxhWiUCBZiBGC3oQ3Q7lccOfv1B424GQG2hWxNX36dpwuvTPTlkhbw
         cKE/Qoao0lHIAMicdRLlRC8W/t6avyczWIkEUivblU8e/oTPOhHRTga9sSJVZm0WKti7
         Lwcy3Z7oMZTCl1/ILBJqRSymZh3W6lrbU2F5PO8UeECQCl5vrVBCArpdM/MCHfCrrYcO
         bYLHPDNUBbNa8cD7QZOcXUy2O+n0lF9Oz6nv1Y6qLs/8BsAhKN7lV2cX8U+152Em8Rp/
         krNrCqlSuGXVcHjWDGXAvpvnmDYmfCKugu5ChXAVWsUP7I4owG0oDgQBuUo13C7lEuwd
         RNaw==
X-Received: by 10.152.132.170 with SMTP id ov10mr9867649lab.21.1363001425339;
        Mon, 11 Mar 2013 04:30:25 -0700 (PDT)
Received: from [192.168.1.11] (broadband-178-140-233-175.nationalcablenetworks.ru. [178.140.233.175])
        by mx.google.com with ESMTPS id fz16sm7109828lab.5.2013.03.11.04.30.22
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 Mar 2013 04:30:23 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <vpqd2v6b4n5.fsf@grenoble-inp.fr>
X-Gm-Message-State: ALoCoQm6wy3l1VLvSagiixb2/C4fGkX2hBBkO7YbKnSU6lfVWU988E1LqFAuO9h+jXg/LQ/J/v8Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217867>

I tried this command and I got following result:

trace: built-in: git 'show' 'a1bffde'
trace: run_command: 'openssl enc -d -base64 -aes-256-ecb -k 
'\''abcde'\'' 2> /dev/null || cat'
trace: exec: 'sh' '-c' 'openssl enc -d -base64 -aes-256-ecb -k 
'\''abcde'\'' 2> /dev/null || cat' 'openssl enc -d -base64 -aes-256-ecb 
-k '\''abcde'\'' 2> /dev/null || cat'
trace: run_command: 'openssl enc -d -base64 -aes-256-ecb -k 
'\''abcde'\'' -in $1 2> /dev/null || cat $1' '/tmp/CLPGPk_config.js'
trace: exec: 'sh' '-c' 'openssl enc -d -base64 -aes-256-ecb -k 
'\''abcde'\'' -in $1 2> /dev/null || cat $1 "$@"' 'openssl enc -d 
-base64 -aes-256-ecb -k '\''abcde'\'' -in $1 2> /dev/null || cat $1' 
'/tmp/CLPGPk_config.js'
trace: run_command: 'openssl enc -d -base64 -aes-256-ecb -k 
'\''abcde'\'' 2> /dev/null || cat'
trace: exec: 'sh' '-c' 'openssl enc -d -base64 -aes-256-ecb -k 
'\''abcde'\'' 2> /dev/null || cat' 'openssl enc -d -base64 -aes-256-ecb 
-k '\''abcde'\'' 2> /dev/null || cat'
trace: run_command: 'openssl enc -d -base64 -aes-256-ecb -k 
'\''abcde'\'' -in $1 2> /dev/null || cat $1' '/tmp/Uyc2Dj_config.js'
trace: exec: 'sh' '-c' 'openssl enc -d -base64 -aes-256-ecb -k 
'\''abcde'\'' -in $1 2> /dev/null || cat $1 "$@"' 'openssl enc -d 
-base64 -aes-256-ecb -k '\''abcde'\'' -in $1 2> /dev/null || cat $1' 
'/tmp/Uyc2Dj_config.js'
diff --git a/path/config.js b/path/config.js
index c4ad2d4..a67d13f 100644
--- a/path/config.js
+++ b/path/config.js


And also not encrypted data of my commit.


On 03/11/2013 02:41 PM, Matthieu Moy wrote:
> Dmitry Ilin <dmitry@mylovecompany.com> writes:
>
>> I mean that our filter doesn't work with 'git show' and I need to
>> enable it for this command.
>>
>> This is part of my git config file:
>>
>> [filter "openssl"]
>>     smudge = openssl enc -d -base64 -aes-256-ecb -k 'abcde' 2>
>> /dev/null || cat
>>     clean = openssl enc -base64 -aes-256-ecb -S '12345' -k 'abcde'
>> [diff "openssl"]
>>     textconv = openssl enc -d -base64 -aes-256-ecb -k 'abcde' -in "$1"
>> 2> /dev/null || cat "$1"
>> [merge]
>>     renormalize = true
> Maybe a bad interaction between the [filter ...] section and the
> [textconv ...] one. Can you run:
>
> GIT_TRACE=true git show <some-relevant-commit>
>
> to see what's going on?
>
