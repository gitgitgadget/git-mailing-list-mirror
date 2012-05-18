From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] archive: simplify refname handling
Date: Fri, 18 May 2012 11:22:14 -0700
Message-ID: <xmqq1umh4aeh.fsf@junio.mtv.corp.google.com>
References: <4FB5DAE5.6020307@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri May 18 20:22:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVRoo-0002M2-I8
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 20:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966456Ab2ERSWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 14:22:19 -0400
Received: from mail-lb0-f202.google.com ([209.85.217.202]:38411 "EHLO
	mail-lb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966445Ab2ERSWR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 14:22:17 -0400
Received: by lbbgp10 with SMTP id gp10so190222lbb.1
        for <git@vger.kernel.org>; Fri, 18 May 2012 11:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=+hqx90FkX5OOwNMUbG5WtE5iOLSD4r1g435zCxYw8kw=;
        b=b42DVQP6J4+iQO8KEr6nm+XcpYulmjNTmRztAmyAd6uoG5tNlsjte4FTqRjoKJBI/y
         2MCwigJVAMRab1XsiMIHJkPlFp1eEub7rvyCBWYCc3kR8rPOIT5pWjS5krD5DDCdvN8m
         rvqrFWwBzdGqWpkmnG/PZtvyYixF+WlaP/TuBBUUCYVjuEz5ngii9J1xa1WZrfrg0P/c
         7E60KFLv9IUO39jD97+LDdCMMDZfytJegoHAEgPOdDR+5sGu5s/jn/4o6hfN/y4/mo0n
         YGxUDRsuAp9zAEn97BonyA0m1HoyEISo42pjh4d0fzWxgF/WboxQZNKA4yKTnsxGkrPm
         r1tg==
Received: by 10.14.199.133 with SMTP id x5mr2544242een.7.1337365335703;
        Fri, 18 May 2012 11:22:15 -0700 (PDT)
Received: by 10.14.199.133 with SMTP id x5mr2544236een.7.1337365335634;
        Fri, 18 May 2012 11:22:15 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id b16si9403087eeg.3.2012.05.18.11.22.15
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 18 May 2012 11:22:15 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id 70CCD5C0050;
	Fri, 18 May 2012 11:22:15 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id BF4BCE1772; Fri, 18 May 2012 11:22:14 -0700 (PDT)
In-Reply-To: <4FB5DAE5.6020307@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of
	"Fri, 18 May 2012 07:15:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQkDRWDFxUMVLRw87qzqsjz1z7Wlop4NcTR9aNMk6nwQ2+rS03Ye83Y4LuGFkK0wI+lojo+pzgAhLCMkRjcMUFm+0brls9p3DcZ4mZGirlGHNu9b3+igKT/sD48O1VdfjUbM+qZy8DrlHLksZVALLGYcE+FTiA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197964>

Looks good to me.  Thanks.
