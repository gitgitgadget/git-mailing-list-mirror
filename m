From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCHv5 1/8] commit.c: prefer get_header() to manual searching
Date: Thu, 7 Oct 2010 23:12:16 +0200
Message-ID: <AANLkTi=HLp_=MgC=oEqTB-4mNHGVJ7Ai=3Ba-_nE5BV_@mail.gmail.com>
References: <1286478657-61581-1-git-send-email-patnotz@gmail.com>
 <1286478657-61581-2-git-send-email-patnotz@gmail.com> <AANLkTinj5eZ7p8qW7U1iqNcjN4EG6HcftD2+etGvSKPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Pat Notz <patnotz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 23:12:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3xlc-0002vi-Sj
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 23:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756162Ab0JGVMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 17:12:37 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35081 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755726Ab0JGVMh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 17:12:37 -0400
Received: by gxk9 with SMTP id 9so118774gxk.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 14:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=cnFzqbc1rNasztATPE+rxbYGdCkp4VhMW9AIFtqtiGw=;
        b=KwFMpDAUEi0L5t7XmUcdL3fCjjdh+Q78axRuNzkxN8sOs2jexuiv+mzDBmsuiJhj6T
         11+yZV73TzX7XLZuLrUZZ+oeJPDL2tG04cnMOAvXUqdjwG7t9Xd9Cbb3ROpzcMtd93Mj
         PJk+Jlf99nQibSa2lBlvp1payAMQzABvZhacE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=hBye34JELaLVoovMxcw7tIf4W2VFHKtgb5wBk0TCKtB0vCZXOOoWxQEcy54VqsdReH
         4+lVtHBEXs9wgBjrlVcCobYuD1VIfg4WIClU87HbOaXZwC+mKsqze2GM2XFGAsy0RVhP
         1UByNfkZoEQLwyRKEuKKxGvGeF4ls8knmLruU=
Received: by 10.151.1.41 with SMTP id d41mr1734396ybi.215.1286485956715; Thu,
 07 Oct 2010 14:12:36 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Thu, 7 Oct 2010 14:12:16 -0700 (PDT)
In-Reply-To: <AANLkTinj5eZ7p8qW7U1iqNcjN4EG6HcftD2+etGvSKPA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158458>

Heya,

On Thu, Oct 7, 2010 at 23:11, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Cover letter?

Ah, there it is, sorry for the noise.

-- 
Cheers,

Sverre Rabbelier
