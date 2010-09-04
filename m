From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: inaccurate commit message message?
Date: Sat, 4 Sep 2010 16:55:44 -0500
Message-ID: <AANLkTinGNss5siAjpic07OB036y8K0kvBjSj=unDhQWs@mail.gmail.com>
References: <AANLkTinbq8z-ygVUWPRq9PA95-+8O8SwOJCLkfMKCg9T@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ramana Kumar <ramana.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 04 23:56:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os0ia-0006S6-2l
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 23:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753883Ab0IDV4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 17:56:06 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57609 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753689Ab0IDV4F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 17:56:05 -0400
Received: by ywh1 with SMTP id 1so1242660ywh.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 14:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=RHEJyXJo8f2/7j5aplVsnY9jiKCb/nkObCM95scvifY=;
        b=UoKoFIRGGoNVI+i4Ux+i2nFNGmG/1vVGvZfRfV3PmIflL576pxp/Itf3dC4HKsPrWk
         NY2H1jaCq94OjhLj4OpNae84AyPm8qVbF/xn3jCjFTzJHZ1MvHDPa/bR3p+pyUewdPmi
         H4oAOgyJ12IfhdpGjkf/A6NhgVcaD42VJt79E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=pvxojSx9Y8oEI25dOjuvW4rqvgGYhuthKsfzCrvykh5ogLcg6lZxQS3n/AuzLeN/i2
         cYm2NA540IqzWsXh05AKrL7SkAbw3F65IyJOq98/q466IAX3O7pVemEyYTpXwL8qm69h
         EScPNB3buTnJyyDb0fEHI5AKTB+G2+plHjDg8=
Received: by 10.150.136.17 with SMTP id j17mr756889ybd.345.1283637364085; Sat,
 04 Sep 2010 14:56:04 -0700 (PDT)
Received: by 10.150.204.21 with HTTP; Sat, 4 Sep 2010 14:55:44 -0700 (PDT)
In-Reply-To: <AANLkTinbq8z-ygVUWPRq9PA95-+8O8SwOJCLkfMKCg9T@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155365>

Heya,

On Sat, Sep 4, 2010 at 16:37, Ramana Kumar <ramana.kumar@gmail.com> wrote:
> The commit message message says "Lines starting with '#' will be
> ignored", but fails to say "Lines below this message will be ignored,
> even if they don't start with '#'".

Because they're not. Only those starting with # are ignored.

> If the second sentence is true, I think it (or something equivalent)
> should be said, especially because of the relevance during commit
> --verbose.

It is not true.

> In fact the documentation for commit --verbose explicitly says to note
> that the diff lines won't start with '#'s, as if warning people that
> those lines might show up in the commit message.
> Yet they do not seem to show up... (and I don't think they should)

Ah, you are apparently talking about 'git commit --verbose'. It works
a little different there, all lines starting with # are ignored, as
well as everything in and after the diff.

-- 
Cheers,

Sverre Rabbelier
