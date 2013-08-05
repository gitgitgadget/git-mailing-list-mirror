From: "Rafal W." <kenorb@gmail.com>
Subject: Re: Fwd: Bug: SEGV in git when applying the patches
Date: Mon, 5 Aug 2013 12:10:13 +0100
Message-ID: <CANmdXCHornfQ7FBGzQCHazwOYp3egGEiNAgsS_SE3N3CJcMRjg@mail.gmail.com>
References: <CANmdXCGZKBwjUP2FgcgmBQ12Gv-ttv78y0ZDjfWRAmR69S2mNQ@mail.gmail.com>
 <CANmdXCFFfRJiCMV5U7Ap8wd=ek7Rs92TuaXDk8XNqQ_U7OxSKw@mail.gmail.com>
 <CANmdXCG2sQ9ujL07=S93+g6DgahiEAnMRgwaAmy16qkNw6OeSg@mail.gmail.com> <20130805110911.GX2337@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Aug 05 13:10:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6IgW-0005wx-UG
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 13:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754526Ab3HELKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 07:10:36 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:61362 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754502Ab3HELKe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 07:10:34 -0400
Received: by mail-oa0-f51.google.com with SMTP id h1so5811642oag.38
        for <git@vger.kernel.org>; Mon, 05 Aug 2013 04:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=eMb1uD3+3S7ruMzS+WoKqVAeaG3Mp5PtbwvthTa4+/Y=;
        b=UK5/WCCgQ/JGn/w2V6XIq5RAmESyc4P/cc3lD19JZFZrSqnaJwujdn/LQNp46J+xED
         TPalUC6pk+6A5/gH6bE8r0JF4Qp6LNW124TUQPRvKmAYZ8O/LEs5Eg38hrsoBHy1uEDQ
         3N41pXvl5yeNWZdWC6hzgoP5//HN0PfpRBXrNueEcJKhYVp4fdTd2RGerkC3H+TTaiBb
         fhP8IpGk2uyzyZk43GfExBNkmZWSVMPUUA5fOksnd3K+8d8FsgjSdGE2kB5IB0oGvrkk
         CTVXiLH2bWqajMCRYdTGG0DubZzGVvFRhkZcUeHtYLeYuGs6v7TU2FYRpaWeRttc+ln/
         qQYQ==
X-Received: by 10.43.48.2 with SMTP id uu2mr1547119icb.109.1375701033814; Mon,
 05 Aug 2013 04:10:33 -0700 (PDT)
Received: by 10.64.49.37 with HTTP; Mon, 5 Aug 2013 04:10:13 -0700 (PDT)
In-Reply-To: <20130805110911.GX2337@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231646>

Thank you, I'll test with the newer version.
---
kenorb


On 5 August 2013 12:09, John Keeping <john@keeping.me.uk> wrote:
> On Mon, Aug 05, 2013 at 12:01:44PM +0100, Rafal W. wrote:
>> Hi,
>> When applying patch via git, it is doing sometimes SEGV.
>> Please find more details in the attached crash logs.
>
> This looks like the issue fixed by commit 212eb96 (apply: carefully
> strdup a possibly-NULL name, 2013-06-21), which is in Git 1.8.3.3 and
> later.
