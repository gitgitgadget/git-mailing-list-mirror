From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] object.h: Add OBJECT_ARRAY_INIT macro and make use of it.
Date: Sat, 28 Aug 2010 21:15:12 -0500
Message-ID: <AANLkTikTeZqqBhzOuA+f7OpQq4nEQmOAOUATO+kN-HjK@mail.gmail.com>
References: <b5ec0461c869bb49b190c2f4f3203fa59107ac25.1283046991.git.tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 29 04:15:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpXR0-0006SQ-Bz
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 04:15:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188Ab0H2CPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Aug 2010 22:15:33 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43209 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328Ab0H2CPc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 22:15:32 -0400
Received: by ywh1 with SMTP id 1so1279784ywh.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 19:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=qkTmSbbCaABx2b9Pnguucy6wReA78GzVAmrTidhuF38=;
        b=JLDZ8aNgzxohf7Re0wsz+7XQBW78AVwQT3kED/kdVcntdedR7pahJr8EdsKG4LdLJ/
         aqOOHMRziYQyTLSzlIXMW2a+vmwf6jnMQSgImv7Z6lNHKLmVcF82+4a3w2a+kX0R6uAY
         uKJkGbBtKcCwRxPhC3OY/O++dWdWJUVO+44H8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=sNRq8Xu8cdGY+SPSq6xaP0FCMZtDQQeYNV4upcdN2oJ1wuJS9D6ULNqXXXPTFVnMyt
         P6iNQHyUNkplNfn6oKEG5e+CWZt7493OLs945o8n9+JDqBwGasAZG1XXsHCPogAenqRN
         eC7DVh5Q69An/4ydpGiOoeC0phFTvlZGT0c5Y=
Received: by 10.150.51.4 with SMTP id y4mr3848910yby.340.1283048132093; Sat,
 28 Aug 2010 19:15:32 -0700 (PDT)
Received: by 10.151.49.17 with HTTP; Sat, 28 Aug 2010 19:15:12 -0700 (PDT)
In-Reply-To: <b5ec0461c869bb49b190c2f4f3203fa59107ac25.1283046991.git.tfransosi@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154667>

Heya,

On Sat, Aug 28, 2010 at 21:04, Thiago Farina <tfransosi@gmail.com> wrote:
> As suggested in: <AANLkTimWQwBdcVgZK5GGmIXOcpgLpgp28ywFi6MJVnyJ@mail.gmail.com>,
> by Sverre Rabbelier.

For those who wondered like I did, the related "string_list: Add
STRING_LIST_INIT macro and make use of it." (which was discussed in
[0]) was committed as v1.7.2-rc1-3-g183113a on Sun Jul 4.

[0] http://thread.gmane.org/gmane.comp.version-control.git/149779/focus=150160

-- 
Cheers,

Sverre Rabbelier
