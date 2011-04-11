From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2011, #02; Wed, 6)
Date: Mon, 11 Apr 2011 20:11:59 +0200
Message-ID: <BANLkTino7ZxfUnGTXSG3jQm1VZDKMtmqTw@mail.gmail.com>
References: <7v8vvni1t3.fsf@alter.siamese.dyndns.org>
	<BANLkTinTVinnDLPnHGoF9DY97ky_MFiLAQ@mail.gmail.com>
	<4DA23551.4040304@web.de>
	<BANLkTinRRJAvMrbUUwGTcgK+9-Bh5QATcA@mail.gmail.com>
	<4DA3409A.9090206@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Apr 11 20:12:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9Lap-0001gH-Jk
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 20:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754739Ab1DKSMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 14:12:01 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33991 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754236Ab1DKSMA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 14:12:00 -0400
Received: by fxm17 with SMTP id 17so3760593fxm.19
        for <git@vger.kernel.org>; Mon, 11 Apr 2011 11:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=b+1OZ4xxaWydxCQ9dQ9IrHZTfJbfbZJ/qSxLMwBO8Js=;
        b=M1xbs64Tr4pzwnYiQtoU2uZ1tdAG5+oPby7Asz2MpTaXZ10AevGNjS11/8AGrBHXEY
         xg3qDmW7G9Bg4xX1NBc2t0woQiBNdeHQ9asXVB4NK12eLIhjFuLPptpT2IX+jLlBIH56
         aPcQ0AMLddnWtHbLnM0UoeNX+cOfhxzCgjKv8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=he/5yKbcLeFuy4sowSV9XiMWockNizyb/ukY4U3ZAltM2qXtWSz7HL8MPuHKZ4hiZy
         EwlEXee8wKclYLjtUaq79iWFvB1sP7J0WMd77SW0BFcGchKv34SiILM5zm1l7iWJMTDx
         z8kEg7DqWhWp3sUFZE1XgUe2LxhcB8QFQFYeo=
Received: by 10.223.72.132 with SMTP id m4mr5902802faj.86.1302545519197; Mon,
 11 Apr 2011 11:11:59 -0700 (PDT)
Received: by 10.223.105.201 with HTTP; Mon, 11 Apr 2011 11:11:59 -0700 (PDT)
In-Reply-To: <4DA3409A.9090206@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171342>

On Mon, Apr 11, 2011 at 19:55, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> That shouldn't be necessary for t5526, I'll tackle that when I find some
> time. The question is: Do we need a commit now adding the prerequisite as
> a band aid fix to restore the ability to successfully run the test suite
> with GETTEXT_POISON=YesPlease, or do we have some time so I can rewrite
> t5526 properly to not depend on the language anymore?

There's no urgency. I'm the only one that runs that testing mode.

It's just something that needs to be fixed at some point, either by you or me.

So put it low on your TODO list, if at all :)
