From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH 0/7] Improve git-pull test coverage
Date: Wed, 6 May 2015 14:30:44 +0800
Message-ID: <CACRoPnRKcDcvRgMqQefXHhaoFs6s3UMb3CNvNOxo-Rt8hyYnFg@mail.gmail.com>
References: <1430581035-29464-1-git-send-email-pyokagan@gmail.com>
	<vpqoam0sqp5.fsf@anie.imag.fr>
	<xmqqlhh4tfd0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 06 08:30:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ypsr6-0003Y9-0Q
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 08:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379AbbEFGar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 02:30:47 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:33571 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbbEFGaq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 02:30:46 -0400
Received: by lbbzk7 with SMTP id zk7so311874lbb.0
        for <git@vger.kernel.org>; Tue, 05 May 2015 23:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BrG8HoGC6N1yw2uQ7HgwMjJ7JqZDGwZ2eYqknlze89Y=;
        b=jQiHzHTMz/+lT2wbpOZfZ+aS5b5U2SbeUF4Dy008ya0xX0oooWytFdyXVFLGb+Dpdu
         3d3TLyG9nFLDe7MbHg7iEqVQbvrZrz3fohXFOAngJjcAA4eosD6K5vIusp7/3WbCXfYF
         uw9NHB886y8eXoK2q+ZL7gXK87JWBHm+Emd/xrXj3mXTrgs9AdxYZK8c4Ce7jvfoJoW0
         IVXGvSN+pvcDNE2xpz8vMvnR27xen3ETDaovSphmalpB/ct/NicYeL7fQdbYNi5Ufit+
         PoNn3TdAWGUkAiCypqPC1LE/pLsXFPYNos6zrnWBwF4p63xoEHGLtIPgP9G7apVkykxk
         lnCw==
X-Received: by 10.112.142.232 with SMTP id rz8mr26326943lbb.74.1430893845035;
 Tue, 05 May 2015 23:30:45 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Tue, 5 May 2015 23:30:44 -0700 (PDT)
In-Reply-To: <xmqqlhh4tfd0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268452>

Hi Junio,

On Tue, May 5, 2015 at 1:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
> One test was duplicated with jc/merge series and caused a textual
> conflict, but that was nothing major.

I will be rebasing the git-pull tests on top of your jc/merge patch
series (as it makes the git-pull rewrite easier), so I will remove
that offending patch.

Thanks,
Paul
