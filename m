From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 15/15] for-each-ref: use get_pretty_userformat in --pretty
Date: Tue, 4 Jun 2013 17:15:24 -0400
Message-ID: <CAPig+cTjYjhn5_r3AdoCJvt8fGOeVr=-5yu_tmzpDszjsDX8ag@mail.gmail.com>
References: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
	<1370349337-20938-16-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 23:15:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjyZm-0005H9-2m
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 23:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422Ab3FDVP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 17:15:27 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:54289 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236Ab3FDVPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 17:15:25 -0400
Received: by mail-lb0-f175.google.com with SMTP id v10so1166065lbd.6
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 14:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=X7gyx4uLTafk6X7pWPg+jHmXz96sd6vGehtAsBwN3V0=;
        b=lDn9pFqSznRgrHVU2lo1MzSBpj56MbAiRoGbD2ci6zj0ATroiyp72GJaEXpnXcBHhW
         qqEYppD2wynCvcHPw7ZAWfo2QK0oSEz974l+EAhIWu0+Prgvkc9bImI7UbTj7BCGIK7U
         hiigFSbU3rH6fwk6wLFFWj+E338BRe5xxGgoBc8lZBs551T0Rg2cTXen3XvzxkIbSazq
         qmAMTw7E+cc87e0wNA82vOBvr2CD42ZEyjU9ootmfQBV7hQYc+NiXqJf/yUF65HPXpy5
         mWDj9AVPmy0WdVI0sxSb5G/6xoxpJanEEuFYk+e6AFP3pZ6pwJXc8ob5Ly2tQhz89tta
         3Vnw==
X-Received: by 10.112.141.70 with SMTP id rm6mr13583244lbb.115.1370380524352;
 Tue, 04 Jun 2013 14:15:24 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Tue, 4 Jun 2013 14:15:24 -0700 (PDT)
In-Reply-To: <1370349337-20938-16-git-send-email-artagnon@gmail.com>
X-Google-Sender-Auth: QDzniayTk-l604rEmH3seGgZAKI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226407>

On Tue, Jun 4, 2013 at 8:35 AM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Use get_pretty_userformat() to interpret the --pretty string.  This
> means that leading you can now reference a format specified in a pretty.*

s/leading// perhaps?

> configuration variable as an argument to 'git for-each-ref --pretty='.
> There are two caveats:
>
> 1. A leading "format:" or "tformat:" is automatically stripped and
>    ignored.  Separator semantics are not configurable (yet).
>
> 2. No built-in formats are available.  The ones specified in
>    pretty-formats (oneline, short etc) don't make sense when displaying
>    refs anyway.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
