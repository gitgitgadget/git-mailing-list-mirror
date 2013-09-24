From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH v3] build: add default aliases
Date: Tue, 24 Sep 2013 05:19:08 -0400
Message-ID: <CAEBDL5WQLx4rsN+yRs62fgTBWkuAhCSWDRkoCc8M_akpSqMKvg@mail.gmail.com>
References: <1379791221-29925-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 24 11:19:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOOm4-0005uu-DA
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 11:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229Ab3IXJTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 05:19:11 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:57831 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870Ab3IXJTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 05:19:09 -0400
Received: by mail-wg0-f45.google.com with SMTP id y10so4330262wgg.12
        for <git@vger.kernel.org>; Tue, 24 Sep 2013 02:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=xaDIqoN9JPPw6Dx23S16Z3x+6L0Ea0Y4ZzNjhkxEUSg=;
        b=CbxGOAlG0UWvqrm0DNjzbgi0ZHAvGDRhCwQ+RW/weGVv/yNsxBHn+clS8yMcZY4/6J
         cMykxzNBzDyfIhsJDR6xHcydjkf6jMpaWbxAr//Bb8r++W3O4FXqGGK3FAnL2WHScChp
         ZLBIgB3Pk6OuKh8YKfoygozAYVGtbMXJArnaJHdRuiCLgE4Ky0UK7lBNCmLemf2ty6ft
         fzGdHQMxsefzViOJFPK6kFzY2ThDLZv1H8wgE+3j8mA9wk0ZX91fo1MiN14T2oi76TgN
         AlxGmyq9bsatp/FyeIHTAG/2yDgFyP22T8AcbC7zI9OC/IBgVrgDrswtFRZshFUksElQ
         knig==
X-Received: by 10.194.134.97 with SMTP id pj1mr487258wjb.58.1380014348779;
 Tue, 24 Sep 2013 02:19:08 -0700 (PDT)
Received: by 10.180.228.42 with HTTP; Tue, 24 Sep 2013 02:19:08 -0700 (PDT)
In-Reply-To: <1379791221-29925-1-git-send-email-felipe.contreras@gmail.com>
X-Google-Sender-Auth: OOPHkXxV-pg_wbFoG7HKjY66gSI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235288>

On Sat, Sep 21, 2013 at 3:20 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> For now simply add a few common aliases.
>
>   co = checkout
>   ci = commit
>   rb = rebase
>   st = status
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>
> I still think we should ship a default /etc/gitconfig, but the project needs to
> agree it's a good change, and nobody every agrees changes are good. So this is
> the minimal change that achieves the desired result.

I wish you would stop attacking the project every time you send a
patch--it's simply not productive and it's certainly not getting you
any closer to a resolution.

That said, I think the idea of having some default aliases is good,
and these match what several other version control systems have
already.

FWIW, I alias st to "status -sb", but I'm not convinced it's a good
default.  I think the safe thing to do is to just alias it to
status--like you did here--and let folks override it, if they want
something more.

-John
