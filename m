From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH v4] checkout: add --progress option
Date: Sun, 1 Nov 2015 11:58:30 -0600
Message-ID: <CAOc6etbaQhE6tcS5m_3rvD7FFV9hTSdBD3RM5=OvqR_7VLqf0g@mail.gmail.com>
References: <1446400076-9983-1-git-send-email-eantoranz@gmail.com>
	<CAPig+cSLC_xkpXEznzPQdA=FE6GV5VSuwSrFy62Nzybv7jQf1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 18:58:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zswto-0004zN-8H
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 18:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbbKAR6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 12:58:31 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33392 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbbKAR6a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 12:58:30 -0500
Received: by padhy1 with SMTP id hy1so117489954pad.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 09:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iCjsJyMDaMmZj/74grAm0k2dTd7zvsscZFTOW5fuiqQ=;
        b=fPo3AjnuW7yhO4RBcdclI+yLLA6OWmOaIEkZVxUumBlod8FveC0iYiMTcrp6lxXk32
         X+xk/2UmqA92GuShrDkr7YiwiYOXTQMkkmN8J5xgUMtjjv+T4jvYeouoorlKV5A/Li49
         o8tnPX5MfB9Evuj5rvZBtLF4kpzmp39khduCd/YEp/GDRCVWLTrD0sZ5xc8ih5ste/rq
         DxyrFGiEcCh5UsJrEyNypM6mWcjJ20sIjbgg1NClsOo+LTvsL2A23CwSUuVADU00dNZB
         KDnpwzcqTLf698dBR8aGBgChuhOQOzIk6rifOF1wPXwRDYU8HTaAxnqm7jMNIqhYWh9a
         afNg==
X-Received: by 10.68.134.232 with SMTP id pn8mr21774919pbb.47.1446400710102;
 Sun, 01 Nov 2015 09:58:30 -0800 (PST)
Received: by 10.66.97.70 with HTTP; Sun, 1 Nov 2015 09:58:30 -0800 (PST)
In-Reply-To: <CAPig+cSLC_xkpXEznzPQdA=FE6GV5VSuwSrFy62Nzybv7jQf1g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280643>

On Sun, Nov 1, 2015 at 11:52 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> +               if (opts.quiet) {
>> +                       opts.show_progress = 0;
>> +               } else {
>> +                       opts.show_progress = isatty(2);
>> +               }
>
> Style: drop unnecessary braces
>

Ok. WIll do!
