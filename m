From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v2 3/3] am: let --signoff override --no-signoff
Date: Wed, 12 Aug 2015 11:07:20 +0800
Message-ID: <CACRoPnQufFJuK+JcdZprBRfaFczkMo0Q=ddp2M6=SiThXPDvTw@mail.gmail.com>
References: <20150728164311.GA1948@yoshi.chippynet.com>
	<1438697331-29948-1-git-send-email-pyokagan@gmail.com>
	<1438697331-29948-4-git-send-email-pyokagan@gmail.com>
	<16ad6c2da8f85b9f5fc26ee6ebad944b@www.dscho.org>
	<CACRoPnSmeR9ETZ4M6GqkbtEZxM-_J-Dxgsx34ntPnojM1j0ZqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Jeff King <peff@peff.net>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 12 05:07:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPMNz-00044H-5U
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 05:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933323AbbHLDHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 23:07:23 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:35438 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933064AbbHLDHW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 23:07:22 -0400
Received: by lahi9 with SMTP id i9so2081425lah.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 20:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=e2Sgjof3AVCPEE43R1XWbdY2LSlSb+6C3TknbKrbSJ0=;
        b=XwzkwN7DOroXUf1YesK96Y92GLy6FbvXovF/kP+ZZCs1X4nhjvRRUxOObckunaoxZJ
         ToKSzfZK5w3Kyc1jnQg5m+L5FeyyXVVFRVmyWd1+cvjlRX2YGhjcK495e4jZZmJ7vaD6
         /5vugX/86wjre4Y4eb0XkYvNRJFXhtxtcB9mcRK4q1t2r33rC3JKkOFdz3m2MOizNM2z
         jNQEWNNAy+D7aWy0v3vl9jH5yaCpPbHIwhupXd/tQSXWuWHI1HQTwT3UcZoUh4PX56xz
         nfb9x1hmBPtlbHGXm4uLyqwbiGQtjcLM1WEuyqNd7xBbgERlQ8Tp9xSl9flhbEIQUCYa
         RgBw==
X-Received: by 10.152.3.199 with SMTP id e7mr29737098lae.98.1439348841044;
 Tue, 11 Aug 2015 20:07:21 -0700 (PDT)
Received: by 10.112.62.196 with HTTP; Tue, 11 Aug 2015 20:07:20 -0700 (PDT)
In-Reply-To: <CACRoPnSmeR9ETZ4M6GqkbtEZxM-_J-Dxgsx34ntPnojM1j0ZqQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275754>

On Wed, Aug 12, 2015 at 11:06 AM, Paul Tan <pyokagan@gmail.com> wrote:
> It's not present in this diff context, but this hunk modifies the code
> path where in_progress is true. In other words, we only check for
> SIGNOFF_EXPLICIT if

..we are resuming.

(Ugh, butter fingers)

Thanks,
Paul
