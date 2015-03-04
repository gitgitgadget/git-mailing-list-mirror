From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] xmerge.c: fix xdl_merge to conform with the manual
Date: Wed, 4 Mar 2015 05:01:08 -0500
Message-ID: <CAPig+cS2hPN_7HwmZL5xBu6XtnkyKosxCSsscU2TZcNfw+ZavA@mail.gmail.com>
References: <1425404233-89907-1-git-send-email-anton.a.trunov@gmail.com>
	<54F616DD.8040904@web.de>
	<CAPig+cQSNLH2poz-gtrsTd5XWpUgDh6a9APfj3K7TC78trf6xA@mail.gmail.com>
	<54F6D695.7030109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>, charles@hashpling.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Anton Trunov <anton.a.trunov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 11:01:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT67C-0001nd-1v
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 11:01:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932618AbbCDKBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 05:01:12 -0500
Received: from mail-yh0-f46.google.com ([209.85.213.46]:33896 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932603AbbCDKBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 05:01:09 -0500
Received: by yhai57 with SMTP id i57so21518877yha.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2015 02:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Ej+m9dkNjlWViyOUGunHwNiLcTOwkKujAyG7p9kzEmg=;
        b=zPSwkkncmIFX0p45w6+8p8wa1pNm9+gEv2XEEC0nRl4H1q9Qvz58k2001NxJpyaKsg
         x32phCzA3gZJXFcMSc+cpoRbd15Bkr01/mbdvbLkZs5/HJtESNCCVFGojQciApSsP+QA
         +ryTIHA4CyC3qpE27empgvx5k4l/+FMfqBtld47ObageckFPwFH1/0dX4aGVvEvpvVhb
         sraI+SIz7GCNlnVKnOtMrNfEtFvPWb9i8ZSz2z6vvtdTPcjsw7Z8qe8s/33MnOKna8Yl
         a1YTUJjJa5yCWbcmzmWSjG4b1hh8HLg7SL7VdixhYiQXcTraylMZkED1npcFCZ4MAkKU
         H14w==
X-Received: by 10.170.136.19 with SMTP id d19mr2694335ykc.2.1425463268968;
 Wed, 04 Mar 2015 02:01:08 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Wed, 4 Mar 2015 02:01:08 -0800 (PST)
In-Reply-To: <54F6D695.7030109@gmail.com>
X-Google-Sender-Auth: wHonid-MZTv_RwrUZhKAiGv_exs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264744>

On Wed, Mar 4, 2015 at 4:55 AM, Anton Trunov <anton.a.trunov@gmail.com> wrote:
> On 04/03/15 10:07, Eric Sunshine wrote:
>>>> +     echo " \t\ttwo     words  " >text.txt &&
>>
>> Use of echo "\t" is not portable. Either embed literal tab characters
>> or use printf "\t".
> OK.
> Shouldn't it be printf "\t\n" for exact substitute for echo "\t"?

Yes, that was implied; it didn't seem necessary to describe the
conversion to printf in full detail. Sorry if there was any confusion.
