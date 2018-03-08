Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C99C41F404
	for <e@80x24.org>; Thu,  8 Mar 2018 15:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934342AbeCHPxc (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 10:53:32 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:40133 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932888AbeCHPxb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 10:53:31 -0500
Received: by mail-vk0-f47.google.com with SMTP id n82so93530vkf.7
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 07:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=mFp/Dh8x6piMB3V+CTjTBWtepOjdNvwhEt/Ut02E3tQ=;
        b=HDBPIGy802I38qEZIuo0aQ35EdkBnAy+893Qx0UC2dzw+RBZHciS4SuOamvuTMUZSe
         qkit0bPuviEHncS0zvsjHwURRAN+DmzzAGdoBxPisFGXd8yCbLQK9rEhJeawApS853XD
         tYUYrlXuF8HGtogK9OgVglxLn4UormfK1Yb9GNvHDpozurx1Mp4NDQEZpUoHn3Z+deDG
         hEXlSyb5AE/95SBXn5OK+sQRwjFNSpa5OSKNkCVsG/kkCTDjr5nd6FkUXwFW5bYTF+hu
         hRoY7+fMF/sfCQDTfpClTMjFgGXLgW9FmaRP/LDhKdDy3YpCzL+Srri1tSM+eWvZzEGy
         kLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=mFp/Dh8x6piMB3V+CTjTBWtepOjdNvwhEt/Ut02E3tQ=;
        b=epALV166m+gNCkzkTg2A2ZSLbT6X1NJGBYMiD8miWkVRJjnh/SvMyit2EeCUmeTDnj
         LhX+/+qn3r8t8YEHb+7Ih2WOWWnCQ8gvbyOx6wL1JIgytx3y4pHLCmzYkjFgxCTu9Zzz
         ytMkM+MbhO7IO5WfymjrLpYSaD4BSRez5chHzlfe30glsecXWjoqfH4D8YRdanONJbjG
         +tos+kZPdXrdknaU8eaSWy4lPJBR+oTfV1n8fxtqg+TWTgc2ekBDKc6ZiIMaUB9MF8dX
         7y9LBzHaywPNMljPcgrF3UXoKL/ZtXJAIj6DpeS30X6RrhEBgSGT9Pgv0z9xj9MKCSed
         b8MA==
X-Gm-Message-State: AElRT7Hj8LE702TzD1gDQWBvnMRNrPE/zS6WQAVWPyhkXOFQq6WD7J67
        tyQLkNeEFLwTi56kqtKHbRMPObbQ
X-Google-Smtp-Source: AG47ELtjL1pZ4X/3yS23MJUw5mPJuwfGa+5bNvvp2rGX7Xo01eSYIUzYeFN86151/rpums8jGjUWGQ==
X-Received: by 10.31.175.129 with SMTP id y123mr8211185vke.189.1520524410555;
        Thu, 08 Mar 2018 07:53:30 -0800 (PST)
Received: from [192.168.88.42] ([190.191.20.243])
        by smtp.gmail.com with ESMTPSA id h125sm8647428vke.11.2018.03.08.07.53.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Mar 2018 07:53:29 -0800 (PST)
From:   Gaston Gonzalez <gascoar@gmail.com>
Subject: Error compiling Git in current master branch
To:     git@vger.kernel.org
Message-ID: <ce6250a8-c1e2-433d-7d5f-399115aa9f55@gmail.com>
Date:   Thu, 8 Mar 2018 12:53:27 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Just to let you know, I get the following error compiling Git in master
branch:

$ make prefix=/usr NO_GETTEXT=YesPlease all doc info
...
     GEN git-remote-testgit
     GEN perl/build/man/man3/Git.3pm
Can't write-open perl/build/man/man3/Git.3pm: Permission denied at 
/usr/bin/pod2man line 70.
Makefile:2317: fallo en las instrucciones para el objetivo 
'perl/build/man/man3/Git.3pm'
make: *** [perl/build/man/man3/Git.3pm] Error 13

This didn't happen in v2.16.2. Doing a git-bisect I've got the following
culprit:

$ git bisect start HEAD v2.16.2 --
2530afd3519a34b66e72cc29e7751d650cedc6dd is the first bad commit

make clean fails too:

rm -f -r perl/build/
rm: no se puede borrar 'perl/build/man/man3/Git.3pm': Permiso denegado
Makefile:2734: fallo en las instrucciones para el objetivo 'clean'
make: *** [clean] Error 1

Regards,

Gaston
