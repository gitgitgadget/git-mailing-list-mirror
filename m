From: phillip <phillip.szelat@gmail.com>
Subject: Re: [PATCH] l10n: de.po: fix interactive rebase message
Date: Wed, 02 Mar 2016 20:09:17 +0100
Message-ID: <B55AE545-A7E5-4454-BB8F-FDE4D5F05B7E@gmail.com>
References: <1456940183-6712-1-git-send-email-ralf.thielow@gmail.com> <CAGZ79kZA0rC87yJGHB8NaS0aR6fvWJQsBaw998dRySYhBgrD7Q@mail.gmail.com> <CAN0XMOLrO98XB9DN39=bZpXUyTtUz0y-HuTxDGFBJ3nRR9z3_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Thomas Rast <tr@thomasrast.ch>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	=?ISO-8859-1?Q?Matthias_R=FCster?= <matthias.ruester@gmail.com>,
	Magnus G <magnus.goerlitz@googlemail.com>
To: Ralf Thielow <ralf.thielow@gmail.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 20:09:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abC9G-0000y7-NY
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 20:09:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754826AbcCBTJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 14:09:22 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35079 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187AbcCBTJV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 14:09:21 -0500
Received: by mail-wm0-f49.google.com with SMTP id l68so100256084wml.0
        for <git@vger.kernel.org>; Wed, 02 Mar 2016 11:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=st45ruvYyNdijG6lvT05F/75S6ybm+ripWypmeaQJzk=;
        b=Xm21FuituYc3sFbwXi7TxsExJoaqWs7ksePNKS2nydmtXjUgLixbiihOGjEEy5yKNt
         Xo9XOuU8+LKtDViP+f0IoLsBLX+A+pPeL+KUGJvY5t4mFqL/kMI78LK/bk0/M2+doSh5
         lBilmB+vQrXEPCWLpVR+RyjZAgsWwBWqmZ851+/b8zUVKQo1huRaE4mej4B0t4p0OPvQ
         QQUtyIpN3DpdYfMUBnAYt9MOCa64V+R6UtDFtrl5D1ipceJnr/laTHdWXLWGBzy8OK05
         IRwp6jh2WUjN1ikwBKCqjXJCvX0/IcgErbkIKmymfu0Xio4tcOYqGUkHQi8GbdiolPv7
         Gr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=st45ruvYyNdijG6lvT05F/75S6ybm+ripWypmeaQJzk=;
        b=N08SByOJ1SS51ldFigDiMKaE3eF0cqzMelLB7cCk++71LV000AJFmWVkjSltvLG9M4
         pvcenPhvU7AOCjJ4fprbWkue5/mDZCODLkZvB+IdNYrlrlgljcZWmPsqHYFfFhicz4KW
         tZ2IvzHJZC1EVzf4J7o2tFR+dWmYwfhAI5pEgV5RQRna4B5gzlH4+JkqlegoXdhassET
         gQq0X56P/LpgKpwkz1DZL9I1WMqOzp3omDlyFslG4i5UGd6FnMps5Mgx6hCPnNTsEXK/
         ZQ9/PYIL7xSEmf4K0YQZ/Oia9dBNnIXHis/5YDOsVdlZ+9T2t3xKxdFllGP+nJXc3NrS
         SQiA==
X-Gm-Message-State: AD7BkJJmaaIsChWy2x4uTFeAGHR0oWlbOhmf1dI8us7vS+Uepd3ycjHxJO/KaqcSO6ulmw==
X-Received: by 10.28.179.84 with SMTP id c81mr1523844wmf.13.1456945760216;
        Wed, 02 Mar 2016 11:09:20 -0800 (PST)
Received: from android-b7bb6bce7d91de53.fritz.box (i59F45C86.versanet.de. [89.244.92.134])
        by smtp.gmail.com with ESMTPSA id b203sm5476960wmh.8.2016.03.02.11.09.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Mar 2016 11:09:19 -0800 (PST)
User-Agent: K-9 Mail for Android
In-Reply-To: <CAN0XMOLrO98XB9DN39=bZpXUyTtUz0y-HuTxDGFBJ3nRR9z3_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288145>



Hi,

>
>Looking at the standard translations in Ubuntu [1],
>"command" is supposed to be translated as "Befehl" if
>it's the first part in the command line (the actual command)
>and "Kommando" if it's the second part (a subcommand).
>
>Currently we almost always translate as "Kommando", which,
>following this guidance, is only partially correct.
>In this case here I'd interpret it as "Befehl", too.
>
>I personally am happy to go this way.  However, this should
>be done in a separate patch that updates the whole translation.
>
>Phillip, you're by far more experienced with other translations
>than me, what do you think?
>

Well I would just use "Befehl". I have never used/seen the translation "Kommando" for a subcommand, because most people would not know the difference.

Maybe we should also change that in the ubuntu guidelines.

Phillip
