From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/4] lib-gpg: drop unnecessary "missing GPG" warning
Date: Tue, 15 Mar 2016 15:50:51 -0400
Message-ID: <CAPig+cRqP7jd1VJcGWXUiqHHPnrmeQY7pxpiYa_5joD8-9YNRw@mail.gmail.com>
References: <1457309427-30124-1-git-send-email-sunshine@sunshineco.com>
	<1457309427-30124-2-git-send-email-sunshine@sunshineco.com>
	<alpine.DEB.2.20.1603152033140.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 15 20:50:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afuzY-0004bN-Sg
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 20:50:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755047AbcCOTux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 15:50:53 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:34099 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbcCOTuw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 15:50:52 -0400
Received: by mail-vk0-f46.google.com with SMTP id e185so35010359vkb.1
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 12:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=8+e9CDJq6sVlHPawXCAL6LBHr4bfz+WDA0o86dLO9K8=;
        b=ulO1fNXOe8zgemG0lBbCdXREu0XQB0jnPpngBs6IYavTDosdzBCKRRFF+ZqlplnhLi
         FNJ+umKYGfS4TPMx07al1hng8rbeIgI+EPh0oYVTzKUGzQKmHgi9zwkjW0LuICy5qXtc
         v9QqmkmBVxS/dH/ITP4wJuR1bULhKrhrl/up64mEBMlH0jYSIga9I1Ag1doIOyXy59sl
         atmFhYI7Cc7+BvWUqMfQv8MJFrQmKvuMvdDeEGvriO7smE/MZgHxVQJPF3Jz4sPfhjRw
         3Da6mfu+hSQ8n9kKT83fH/yYaxH7JOf3MTDJJWa+kbSeTDWNdAXvohnhW/rHaS5h2d7F
         4J9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=8+e9CDJq6sVlHPawXCAL6LBHr4bfz+WDA0o86dLO9K8=;
        b=iipfOmDI7A/B76uKgxrRolkz4Ff+IQhs+1rJ9q/rerCpsP/dERmkv7eTqLU7xZ36fj
         nrcN0XPYYrHxo+O/Jpqk18ms54fc6OoUo7dxtsFCyjf4gc2Kbfub+viqy8sxmFRMg8Le
         A4b4yhBYTSXv9Ig/BE+IlBOpTYwTMYYVBbm/7dJjPZL4/WNUqY2E+fxWTHn/TiLepWxY
         plUlFNiUc06ffUBgZ8vnnEJf7JJXzD+jH7pN9K0w6u7uixleUjf8g7kXkFSgHQOd6XJ9
         YNxEQyV0WUfcKSg0mzZ58TTfQ3rGEUHW7vVvzzPmljIP8fRHmGWKO+9q23uWDpgRe/8U
         N4Rw==
X-Gm-Message-State: AD7BkJJ7c0GKR2Bk2TWeEeiGdJ05IIdO7oQSAwVs1Lz//JautvXOkAxiU0FBv2sq9saIVWRU7WwhrQOgkP5yMA==
X-Received: by 10.31.21.4 with SMTP id 4mr33487729vkv.151.1458071451189; Tue,
 15 Mar 2016 12:50:51 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Tue, 15 Mar 2016 12:50:51 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1603152033140.4690@virtualbox>
X-Google-Sender-Auth: ypCA7CfLnEexTmPXCO6LIbla8OY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288904>

On Tue, Mar 15, 2016 at 3:33 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Sun, 6 Mar 2016, Eric Sunshine wrote:
>> I also sneaked in a minor style cleanup.
>
> Isn't this "snuck"?

I'm no grammarian, but [1] says either would be fine (and we know that
the Internet never lies).

[1]: http://grammarist.com/usage/sneaked-snuck/
