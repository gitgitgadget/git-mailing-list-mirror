From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2] Documentation/urls: Rewrite to accomodate 
	<transport>::<address>
Date: Mon, 5 Apr 2010 00:57:13 +0530
Message-ID: <k2hf3271551004041227sfade965aubb4273a6340b7518@mail.gmail.com>
References: <f3271551003290959v263fe04bt1047f390788916c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 04 21:27:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyVU8-0004MS-Jt
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 21:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890Ab0DDT1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 15:27:36 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:51793 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735Ab0DDT1f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 15:27:35 -0400
Received: by yxe29 with SMTP id 29so1783279yxe.4
        for <git@vger.kernel.org>; Sun, 04 Apr 2010 12:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=gW4iVjedumIMeMA/5asSIwtH4Mx/ENzwMk5c/ac/zTs=;
        b=xCfwqRUehMoXlMXHea+hWunjvGh8LT7fIUZb5/wM+/Ao2tQl0iLnGosNmF0cthim51
         mdFKEWCnBl4HMdh1S/Z515UmCH110ebZW+q/PtnbhzPaEjv7slvn91+xCZVVtyifk9lR
         xCEM/r26OFvExz8P5rq7W7YMC7l0Ntu2rvOHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=X1MvR77skOGX3MXmEsNvbg6SukPf1qC1SV5PqdSrBaE03KRYc44JVXTa/14D4tUT1T
         mfzcZWjTzDF7c31TJ09I5ATMmUbSdW27Z7XTrkLN8D6g4xtxbd0fkilcOc/auwwfkMwO
         sj+scSMlB7fR6gdpVrNU4n4dV8TiHVLWih1pU=
Received: by 10.90.69.14 with HTTP; Sun, 4 Apr 2010 12:27:13 -0700 (PDT)
In-Reply-To: <f3271551003290959v263fe04bt1047f390788916c2@mail.gmail.com>
Received: by 10.90.236.8 with SMTP id j8mr778344agh.5.1270409253367; Sun, 04 
	Apr 2010 12:27:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143941>

On Mon, Mar 29, 2010 at 10:29 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Rewrite the first part of the document to explicitly show differences
> between the URLs that can be used with different transport
> protocols. Mention <transport>::<address> format to explicitly invoke
> a remote helper.

Could someone remote helper experts kindly review/ ack this?

I forgot to sign off:
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

Thanks!
-- Ram
