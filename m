From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 00/18] git notes merge
Date: Wed, 29 Sep 2010 17:20:52 +0200
Message-ID: <AANLkTinjAoAYW2as1VfeWJ=t4MORjC9s7=eMCbYttier@mail.gmail.com>
References: <1285719811-10871-1-git-send-email-johan@herland.net>
 <AANLkTi=gL_6ueBvO7URth-rbbHyZLpwYEAMwErh1ciba@mail.gmail.com> <201009291716.52831.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, jrnieder@gmail.com, bebarino@gmail.com,
	gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Sep 29 17:21:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0yT6-0001w7-Vm
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 17:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564Ab0I2PVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 11:21:14 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37753 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529Ab0I2PVN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 11:21:13 -0400
Received: by ywh1 with SMTP id 1so310282ywh.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 08:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=jySm9W4SHphHyO0e0MGeiwEls+5t+whfjCpuELQ+b1s=;
        b=aPXmtHuuJK55or0twnkDTJrhjjqMSz6vH/arIfPe6Uwvb/AOy5Rouj17ZT9zF7pMkP
         p61p92TxLJxBBOJyzUl7XnMDzNGjGZpNyGFaSUrDtsGHShJLOdfB3xYZxo2iAKadEkuU
         v+h+75NyvSxmdud/zVGwIaWwvWj9LVX4JlMA4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=aJtbpKK1pLGqxNVj33L4PNYfhHmNVAkt+n6ScQF6zlsfUS/ANjB2BQOFnl58T6qGur
         cVjggNVSQX0zn/InTl7TIw2ZeKRq4Xu898tpCOY2TYXsc6q5i5y2//LKT/OJEI5+iXqV
         AmvMipK/xhBw+viES1zBQu9jBD1mRFp9KrD1w=
Received: by 10.150.135.5 with SMTP id i5mr2292703ybd.129.1285773672701; Wed,
 29 Sep 2010 08:21:12 -0700 (PDT)
Received: by 10.231.33.138 with HTTP; Wed, 29 Sep 2010 08:20:52 -0700 (PDT)
In-Reply-To: <201009291716.52831.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157577>

Heya,

On Wed, Sep 29, 2010 at 17:16, Johan Herland <johan@herland.net> wrote:
> Yeah, I'm torn as well. What about providing both? Or is that bloat?

Definitely not both, that would be confusing, and would limit us if we
decide to add 'git merge --abort' later on.

>> I know that there's no 'git merge --abort', but IIRC that's for
>> technical reasons only.
>
> Maybe there _should_ be a 'git merge --abort' (as a synonym to 'git
> reset --merge')?

Hmmm, I don't know if that does what the user wants, (I haven't used
'git reset --merge' before), but if it does, that sounds like a good
solution.

-- 
Cheers,

Sverre Rabbelier
