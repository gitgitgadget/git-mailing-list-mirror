From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Redirect "git" subcommand to itself?
Date: Fri, 29 May 2015 08:38:34 -0700
Message-ID: <xmqqsiafe6md.fsf@gitster.dls.corp.google.com>
References: <CAGZ79kZHa9wUrRsWfHgGdSdx+cN9VAirAAfu3YLVTuSmggcehg@mail.gmail.com>
	<xmqqoal5ii21.fsf@gitster.dls.corp.google.com>
	<87zj4n4w3t.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Christian Neukirchen <chneukirchen@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 29 17:38:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyMN0-0006uo-CQ
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 17:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756461AbbE2Pim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 11:38:42 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36478 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756429AbbE2Pig (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 11:38:36 -0400
Received: by igbpi8 with SMTP id pi8so17056001igb.1
        for <git@vger.kernel.org>; Fri, 29 May 2015 08:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=gnwvZv5j8Wk19phsd87CelrqKq42wZxI3sn+eesm3zI=;
        b=HaWfcOVwGRynsRKlPWjo7Jt00I5wGX6zTdsY+Yv29QN79zQwqSdPpbuNprAGsHKSxZ
         u5gXTqLS/P1r+CSkAYL5lFQGlinNZRKvUum0rN31LSlpll2STfAozkgY3QdHCddmY0ez
         /5adBgm2uaSIiv+C1xnOwy/PuyaMGjwVO0FK1InhlTHcom9MBRV0gdSKVZWn3amKOKrJ
         YF3X6DShOR5qnxZEzpkDhFAh/1CLguSjAE5u58x0djvaHjordsNDjTzfFgZiw1wCY+uW
         Qwp/yBC9f4/Gtm3Ag1g7DF9pd4zvCkFwt/REfRL3XZu5tQW8ngrt8oZOhvOq7pvt5uv5
         MQEw==
X-Received: by 10.42.205.132 with SMTP id fq4mr15744445icb.33.1432913915978;
        Fri, 29 May 2015 08:38:35 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:89d0:c49e:8012:77d2])
        by mx.google.com with ESMTPSA id i185sm4409455ioi.24.2015.05.29.08.38.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 29 May 2015 08:38:35 -0700 (PDT)
In-Reply-To: <87zj4n4w3t.fsf@gmail.com> (Christian Neukirchen's message of
	"Fri, 29 May 2015 10:38:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270245>

Christian Neukirchen <chneukirchen@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>  * You can help yourself with something like this, I suppose:
>>
>>    [alias]
>> 	git = "!sh -c 'exec git \"$@\"' -"
>>
>>    but I personally feel that it is too ugly to live as part of our
>>    official suggestion, so please do not send a patch to add it as
>>    a built-in alias ;-).
>
> So I thought I was clever, but this didn't work:
>
> % ln -s /usr/bin/git ~/bin/git-git  
> % git git
> fatal: cannot handle git as a builtin

Why did you have to do that when I already gave an alias that works?

Or didn't the alias work?
