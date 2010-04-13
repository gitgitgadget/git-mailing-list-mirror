From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: TODO: git should be able to init a remote repo
Date: Tue, 13 Apr 2010 17:42:25 -0400
Message-ID: <q2j76718491004131442q5ec8588en75611f97af26fac@mail.gmail.com>
References: <i2i76718491004131030sc2f8ffa3u97a91aa9a57923b5@mail.gmail.com>
	 <20100413195826.GA11597@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Apr 13 23:42:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1nsO-0001qA-SP
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 23:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021Ab0DMVm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 17:42:28 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:63831 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753961Ab0DMVm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 17:42:27 -0400
Received: by gxk9 with SMTP id 9so4358884gxk.8
        for <git@vger.kernel.org>; Tue, 13 Apr 2010 14:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=tRWicAogDm2x2LCOvi7dGVMKrHwR/8RZ/USYRRcvXLg=;
        b=IytTGR0DbtTIjF6nY91AIoivIbPbv+cmwT52xnSNZuEyz9WTiyqpp8SuilxDh1gijG
         XTcrCmHsjjnM2hVBfDPTXs7P/9tHCIFe/Wyc4C0wCU2lTUnPdfQiZSbc/aHi4v4G6H9d
         2wQItUH4XR+iIij3nsxWT2RXG82g9RZyyRH48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=om0PSyjv+WvE2CUMaBKvFfoMlCGiF7BqV+07iqvDmpT5JyiuISqWDR03nBlWRgMkjf
         tG53rwCoRD0QOBP2TVSE3V7Nkqq/rYONFKMBLipRp1vIryWJntU8E1/Vk6JiPZz4CK6q
         dxU9lzCTkQzNYm6CcWKX9ODoTmRKa1i+hwG8o=
Received: by 10.231.36.9 with HTTP; Tue, 13 Apr 2010 14:42:25 -0700 (PDT)
In-Reply-To: <20100413195826.GA11597@LK-Perkele-V2.elisa-laajakaista.fi>
Received: by 10.100.238.12 with SMTP id l12mr11092282anh.239.1271194945920; 
	Tue, 13 Apr 2010 14:42:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144833>

On Tue, Apr 13, 2010 at 3:58 PM, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> Couple of concerns:
>
> - That seems awfully ssh-specific[1]...

Of course it is. It's not meant to cover every scenario, just what I
feel is a common one.

> - How remote end could deny the operation, modify paths and/or
> get post-creation notification?

Huh? Obviously this only works if you've got remote shell access, and
that's the only scenario it's intended to cover. As I said, it just
simplifies 3 commands down to 1.

> - How to handle systems that would autocreate the repository anyway
> if push was attempted?

Again, that is not the use case "git remote init" is for.

> [1] Well, its not like one would want to do that with gits:// anyway,
> since there's probably gitolite install on other end anyway...

And this isn't for that scenario.

j.
