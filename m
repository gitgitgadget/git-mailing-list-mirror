From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Wed, 24 Apr 2013 17:25:25 -0400
Message-ID: <CABURp0qHRQvUSKMth8mZjwcX9sn-vrcf+ZUswQADW5wwzx4MWA@mail.gmail.com>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
 <7va9ong9oa.fsf@alter.siamese.dyndns.org> <CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
 <7v38ufer2x.fsf@alter.siamese.dyndns.org> <CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
 <CALkWK0=5tE0pXj-XTe4g9LdCO78yrPNwyom5fupF1WTToY2TZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 23:26:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV7CQ-0006k4-IX
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 23:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758342Ab3DXVZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 17:25:48 -0400
Received: from mail-vc0-f175.google.com ([209.85.220.175]:46458 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758320Ab3DXVZq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 17:25:46 -0400
Received: by mail-vc0-f175.google.com with SMTP id lf10so2272881vcb.34
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 14:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=bqXcR3FtDaKLqxT8jRuJd9LdybGPqqSDqrPJPTP16qw=;
        b=SXs1v8Lxp6fUTEFPMkt1Kpx7UWf9LaR9idATYlOwbGt1BKQH57vFMvfY/eCnMONbys
         pSPId2RlpaLU6MkF/27f7eVkj7l4AFGYLMp8vFdnQAPFdxztZ4FODL79+94fEbLr1haY
         +JVFFizG6hLtIRIailSc5EWJKYJTvkyjf4i8KUF9dER3KNpuQVgw6x56Y3tUe5u91L9h
         NAK19K50b6oQlxB1Drxk7Cj2qAVq29AArjAo7nxGZbg9euPwsoXcvT25kQIOD0t8sQWr
         s1Aj7p++qG50bC/cBtH/7A1T9l6skhpeBJC8YlBXQoI2rHWgtB6uweSl5Fc5gE9LAJ9k
         t5wA==
X-Received: by 10.58.214.231 with SMTP id od7mr26056507vec.44.1366838745479;
 Wed, 24 Apr 2013 14:25:45 -0700 (PDT)
Received: by 10.58.219.34 with HTTP; Wed, 24 Apr 2013 14:25:25 -0700 (PDT)
In-Reply-To: <CALkWK0=5tE0pXj-XTe4g9LdCO78yrPNwyom5fupF1WTToY2TZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222326>

On Wed, Apr 24, 2013 at 3:00 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Ramkumar Ramachandra wrote:
>> I'm also considering making the first
>> argument optional (just git log ~rebase.autostash), and defaulting to
>> mean [nearest fork point].
>
> Actually both can be optional.  In A~B, A defaults to [nearest fork
> point] and B defaults to HEAD.
>
>     git log ~
>
> Isn't it beautiful?

Sure, but we'll forever be explaining to users that they will need to
quote the tilde to avoid shell expansion.

$ echo "~" ~ "~"
~ /home/hordp ~

P
