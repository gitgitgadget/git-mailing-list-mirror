From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/7] push: describe --porcelain just like commit and status
Date: Mon, 14 Feb 2011 23:25:00 +0100
Message-ID: <AANLkTintLstPrvs_AqCixmXzRcrthfy+qAaPmve2oSu-@mail.gmail.com>
References: <cover.1297695910.git.git@drmicha.warpmail.net>
 <3b6a87b585eea1722bd31bc9cf5ba2c80e37aefa.1297695910.git.git@drmicha.warpmail.net>
 <7vmxlys89t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 23:25:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp6ra-0005bS-Oy
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 23:25:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882Ab1BNWZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 17:25:41 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:59445 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197Ab1BNWZl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 17:25:41 -0500
Received: by gwj20 with SMTP id 20so2284354gwj.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 14:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=mL9PMWy27VuyJDlMg8RGrlffdyNpPIbc967PIhg6Hms=;
        b=mLxj4zN+RBealDRCakEF7GgmqXTX8btmBdEJHaCBAFSr892N6qRH4SwDeFO80ilUFn
         T19dxds7UVPTMXheVlkNXDXMFwYCzQvLvCrVHj+hBzj80xvD+alnQzCeZfVGOOiuU1QP
         Va7AjANLTfGiVJAekKDla3px0pO2o+dke9uw4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Gcbiw3VoESCMMFZ9GFw6ZHWPA+vfg836TA6H+0LUotncoO50oDh/03jzjdojxUDhxd
         Wyk1mAyh211FuJg1erFdWTQ47zV8HQ5FsaOCmXwQDYsqEDZ8aqT3ZjKlvojcw+Q6Pzu7
         wZIZBUaoSuV5gPoSOANeBrl/QUKXfXIna+5Wc=
Received: by 10.151.44.19 with SMTP id w19mr5156874ybj.165.1297722340365; Mon,
 14 Feb 2011 14:25:40 -0800 (PST)
Received: by 10.151.158.10 with HTTP; Mon, 14 Feb 2011 14:25:00 -0800 (PST)
In-Reply-To: <7vmxlys89t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166785>

Heya,

On Mon, Feb 14, 2011 at 20:53, Junio C Hamano <gitster@pobox.com> wrote:
> The option was meant to mean "output format for Porcelain script writers
> to stay machine readable" but it can be misunderstood as "output format
> a Porcelain command would produce with chromes and glitters".

I've always thought this to be a rather awkward option name. If it had
been named '--plumbing' there'd be no room for such misunderstanding,
it outputs it a format suitable for use by, and as plumbing. Perhaps
something to remember for the future, or would we want to stay
consistent with the current --porcelain?

-- 
Cheers,

Sverre Rabbelier
