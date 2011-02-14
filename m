From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: [PATCH] Obey p4 views when using client spec
Date: Mon, 14 Feb 2011 10:16:10 +0100
Message-ID: <AANLkTinVp3EYFX3Ow2G8dO6Zn5BEWxuYjwO8vW2yOjcF@mail.gmail.com>
References: <4D55D56C.6050207@vmware.com>
	<20110212215133.GA21494@mew.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ian Wienand <ianw@vmware.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 10:16:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PouXa-0003W4-4s
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 10:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452Ab1BNJQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 04:16:12 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49319 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079Ab1BNJQL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 04:16:11 -0500
Received: by ywo7 with SMTP id 7so1955851ywo.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 01:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=CHUcz3x7UdGJrnYvDe5KitYbtl1f0ihGj0zv83qGWVE=;
        b=MZZhX9ZTHbeDh2LD/Po+M/IdxCmJG2Yuq6k/xvomgljD46xDLKMA9suSeBjKGA7A26
         L0DXoOdYv1GBm5JbpCGUkD3KJBV8sdksWwEn98kfqAg/9J0+LcXVA6XbkuQpPiWJ7Lwu
         +YaMelwovShOZQaAiHtUsJghTZoZltfikZWLI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Om/nF1D/eUAMEU9O8rUG4N+/fNV2/FQ4lGSCHOqOPtEboC+3gZwqeW3zkOEzA/954n
         FbYnO8eV+KRap7rzhSeAtiKhOlwMf8Yfz40FPPaVvsHgT4HEWF/Sx+Ql+yu4wsyzfmgZ
         ePIXUhdpCvfQsaKUvlXJZkHBtKn9JFuvgqL2E=
Received: by 10.101.13.2 with SMTP id q2mr1522384ani.148.1297674970185; Mon,
 14 Feb 2011 01:16:10 -0800 (PST)
Received: by 10.101.1.19 with HTTP; Mon, 14 Feb 2011 01:16:10 -0800 (PST)
In-Reply-To: <20110212215133.GA21494@mew.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166698>

On Sat, Feb 12, 2011 at 10:51 PM, Pete Wyckoff <pw@padd.com> wrote:
> ianw@vmware.com wrote on Fri, 11 Feb 2011 16:33 -0800:
>> When using the p4 client spec, this attempts to obey the client's
>> output preferences.
>>
>> For example, a view like
>>
>> //depot/foo/branch/... //client/branch/foo/...
>> //depot/bar/branch/... //client/branch/bar/...
>>
>> will result in a directory layout in the git tree of
>>
>> branch/
>> branch/foo
>> branch/bar
>>
>> p4 can do various other reordering that this change doesn't support,
>> but we should detect it and at least fail nicely.
>>
>> Signed-off-by: Ian Wienand <ianw@vmware.com>
>
> Nice, thanks for making the changes.
>
> Acked-by: Pete Wyckoff <pw@padd.com>

Good work, Ian! Thanks.

Acked-by: Tor Arvid Lund <torarvid@gmail.com>
