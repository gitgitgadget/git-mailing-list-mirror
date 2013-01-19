From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 4/8] git_remote_helpers: use 2to3 if building with
 Python 3
Date: Fri, 18 Jan 2013 23:52:16 -0800
Message-ID: <CAGdFq_gwNUxug+AKMWebf4=-7D0PSdSm87mwzb3L3XGsg+MkTA@mail.gmail.com>
References: <cover.1358018078.git.john@keeping.me.uk> <cover.1358448207.git.john@keeping.me.uk>
 <bcef80fb913ca829bd2d08284e364ebd55b7297e.1358448207.git.john@keeping.me.uk>
 <CAGdFq_gew1-YmeUh=brWREHSYQvaV7vRBmEo0KFzi-ViqzOnaw@mail.gmail.com> <20130118103241.GM4574@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git List <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat Jan 19 08:53:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwTF8-00048e-Ec
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 08:53:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440Ab3ASHxC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2013 02:53:02 -0500
Received: from mail-qa0-f45.google.com ([209.85.216.45]:39045 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497Ab3ASHw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2013 02:52:58 -0500
Received: by mail-qa0-f45.google.com with SMTP id bv4so1910734qab.4
        for <git@vger.kernel.org>; Fri, 18 Jan 2013 23:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=cOb7967DpX/PNRLoG0QxdBK20NpIXiWacTC7BIjEAzs=;
        b=mO384kw3el7T+mr0r9s1dI1n0e68Ze0sYNn5TWfSAtg5iMpJpn4147gV7P5aocyFjL
         0gs75FKmh5Ga3Wu7IHH/ChVx3/4kDf6cRazyQIOYCpztCk7mILsmOFEFKO+qZmuXGBPn
         eNtJbZ/83r1/HFhakaVljp3olVx2yzerztIJg+Pf8sA5zhqyA8DwKKnITLiaqTVycIA7
         0mq8FO7xkTaUZ0DVOPrQKNE/XK1iBBmvn9SfuBxTM2Idn4IEupbjYaom/dVnocGfWVje
         tzoD+7RQz+yEXQQINCj0RpuKwwbW/7t9veH95Exqhd4y58fLwWQmbKOZEThIFq7PjeRd
         +NaA==
X-Received: by 10.49.59.48 with SMTP id w16mr13735022qeq.38.1358581976643;
 Fri, 18 Jan 2013 23:52:56 -0800 (PST)
Received: by 10.49.51.227 with HTTP; Fri, 18 Jan 2013 23:52:16 -0800 (PST)
In-Reply-To: <20130118103241.GM4574@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213962>

Assuming you tried this out on both 2.x and 3.x:

Acked-by: Sverre Rabbelier <srabbelier@gmail.com>

On Fri, Jan 18, 2013 at 2:32 AM, John Keeping <john@keeping.me.uk> wrote:
> On Thu, Jan 17, 2013 at 09:15:08PM -0800, Sverre Rabbelier wrote:
>> On Thu, Jan 17, 2013 at 10:53 AM, John Keeping <john@keeping.me.uk> wrote:
>> > [1] http://wiki.python.org/moin/PortingPythonToPy3k
>>
>> This link seems dead.
>
> Looks like the Python wiki is down [1].
>
> I'll replace it with [2] since the content is similar and it should be
> easier to find a mirror of the Python documentation than of the wiki.
>
> [1] http://pyfound.blogspot.co.uk/2013/01/wikipythonorg-compromised.html
> [2] http://docs.python.org/3.3/howto/pyporting.html#during-installation
>
>
> John



-- 
Cheers,

Sverre Rabbelier
