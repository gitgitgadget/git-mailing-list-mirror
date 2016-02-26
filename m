From: Guilherme <guibufolo@gmail.com>
Subject: Re: Fwd: git clone does not respect command line options
Date: Fri, 26 Feb 2016 13:16:39 +0530
Message-ID: <CAMDzUty5oWjS=4kvvYL7XNCY=xHm3N=+kaeT_zTtpkaMakMrmA@mail.gmail.com>
References: <CAMDzUtzoiJWzckTX818HJV=su0eEP35gsNDJ=+k_me08EDvxRg@mail.gmail.com>
 <CAMDzUtxQPMty0Nncr7Yj3up6Zb6F-E0QudOMOZO_jG-Goq0YBg@mail.gmail.com> <20160226073444.GA26340@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 26 08:47:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZD7V-000451-Js
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 08:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437AbcBZHrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 02:47:21 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:34795 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbcBZHrU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 02:47:20 -0500
Received: by mail-vk0-f42.google.com with SMTP id e185so70328336vkb.1
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 23:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NnmH/vsMdYGcVelBib0RTy5BgY5F1UhGZzCA2Qby864=;
        b=IvJ2hJxKf0gNFZMRleefj6L2y8E2u6sBN7PEpn3JjCEQnoGo6OQv7rSMYjEzmlXriD
         DUCj2QQXpafp6vKa87a9yI7voi8nSSJsfbS4Zws+vSRwhKDpxvmLLjHFJ3EewUhYqAF5
         4swsIrXYoYlf4ytKG8MI/2a4XUjfGeQ8786wpwSWSUPzdRPdf8I4rl5EbY90iBrE5rKc
         0DDDiva2GFMfou0zWnEXvdq1bwjhHhRiHgtm4l7muvCtD6Jy17rp1TcZhMzLzY6jWy+K
         iNoyL7WiS6g+tZrp3l4c9cCuJ2CFQhPO55f0m3AyyS/r1YkZmH3sfzPCn4Kle4apgETO
         2Puw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NnmH/vsMdYGcVelBib0RTy5BgY5F1UhGZzCA2Qby864=;
        b=XOa4n+KgEF7KOOOfxBXui4MK6E4LwYvl/7iQjsOqq60NpMtfQ+7OmgHc2Ihq4hVUzW
         abY3823Vrgxws3NOmrjCR27zoG3/q60ZqRL/1BTQFF3rI5NmFraMDVJmvzd7WQq+STXO
         WZHlOaFlzNMlF50hvqh6Mq7CJeCqaugVCe0RFVYnKzIEk4eJgunfifkqHi/IPN04DLxo
         htdtHagvjVsARaa5STDyhmAsnarTX5UAeSC/4AY9NVj1XwxUPTxuGHBDOGvbQtFQ2U7y
         cpsNj//oRcjtEqU9IT/rbCRjo0l7L7aBqx5uC5KWtbEuFfya9bg2U0DJYQwd9fTyi0KE
         X9+Q==
X-Gm-Message-State: AD7BkJLY6ObpB/hPX7A2Ko34dAT5ZGglDm/Qacu8LFHZuC4e0qwizG5K0eVB2uknPnTp3KY6EqkrxM8bcpNwUg==
X-Received: by 10.31.54.12 with SMTP id d12mr109449vka.34.1456472839160; Thu,
 25 Feb 2016 23:47:19 -0800 (PST)
Received: by 10.31.162.145 with HTTP; Thu, 25 Feb 2016 23:46:39 -0800 (PST)
In-Reply-To: <20160226073444.GA26340@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287543>

Thanks for the quick reply.

Is there any documentation on which variables are muli-valued?

git -c credential.helper="store --file=creds" config --get credential.helper

only returns one value.

How can i even know if there are multiple set. I mean someone might
have just created an extra credential.helper in `--system` that I'm
not expecting...




On Fri, Feb 26, 2016 at 1:04 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Feb 26, 2016 at 12:17:49PM +0530, Guilherme wrote:
>
>> I'm trying to use git in an integration test and i'm having trouble
>> with configuration options.
>>
>> On windows developer machines we use wincred as our credenital helper
>> and thus have it set in ~/.gitconfig
>>
>> For the integration test that is no use as it will make testing
>> unauthorized logging in impossible.
>>
>> Since there is no way of disabling configuration options on the
>> command line i tried setting it to store with a file I could delete.
>> So in front of every command we insert `-c credential.helper="store
>> --file=creds.txt"`. In the end the command line looks like:
>>
>> git -c credential.helper="store --file=creds.txt" clone
>> http://admin:admin@oururl@20000/TestRepo.git
>>
>> I see the file creds.txt being created containing only
>> http://admin:admin@oururl@20000/TestRepo.git but the credenital at the
>> same time appears in the windows credential store.
>>
>> Can anybody else confirm this?
>
> That's behaving as expected. Unfortunately, you cannot currently do what
> you want easily; there is no way to "unset" a multi-valued config
> variable (like credential.helper) with a later one. Git will ask both
> configured helpers for the password, and will store a successful result
> in both.
>
> The simplest way I can think of to work around it is to point your $HOME
> elsewhere[1] during the integration test, so that it does not read your
> regular ~/gitconfig.
>
> -Peff
>
> [1] Actually, that is what I would do on a Unix system. I have no idea
>     how the home directory is determined on Windows.
