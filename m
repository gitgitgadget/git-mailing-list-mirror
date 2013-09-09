From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] reset: add --stage and --work options
Date: Sun, 8 Sep 2013 19:39:22 -0500
Message-ID: <CAMP44s3rc9nTCbez-jcvfV18g1ded5pfUjb_uCyJpYD86vZBvg@mail.gmail.com>
References: <20130829180129.GA4880@nysa>
	<1377800397-5434-1-git-send-email-felipe.contreras@gmail.com>
	<1377800397-5434-2-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0=P0xZAk95Jmw9mRUCwPQP7NmVHsuPaWNg+D2v3wP9=-w@mail.gmail.com>
	<CAMP44s01CqJoDupmiD4K85Y1p9jF0PrT3v5owrS5WQkKQ-kkXA@mail.gmail.com>
	<CALkWK0kSBXCmCcDJ0p+CJMF4V1+RC2s_toRY_wNnZJOA164HNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 02:39:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIpVo-0006TI-K9
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 02:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424Ab3IIAjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 20:39:25 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:52652 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab3IIAjY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 20:39:24 -0400
Received: by mail-lb0-f171.google.com with SMTP id u14so4459220lbd.16
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 17:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PtRdvG0EWt4ZJNKoOMRyOZRcukNx0IOX8yAYU40B+GU=;
        b=pdSuMtFRYFhfrq7qTxDSrrr1FgDgORRJ+96E4ILYvY8LMBqT8dFiSDBeqNokKix60Q
         UKpjcxnjbrc41XSUa+50Qpw3+Kj0XSePtRmYNPZK9bOtTvAYEHkbXEBeE/+iths/9ezB
         87DZaXywWVOGrU5f+b7AC0eX2oIvcRCAcLSdGIhgIOPTFocqUSjUpUsACh8f+p4EMiNQ
         nI4rROAKDkLDG6a7U5D2Kn4CgQEUxiZEiBRkEOBo/qP98VFhkpHpJFRhKi9QDPvPkBJe
         Uy78mM/C5r2URKLrGJFuu/MQ0wBhGv0/6Ea+Pg1l17BZCP9M/PEkDkLw4sWRJuX9iO33
         aijQ==
X-Received: by 10.152.120.5 with SMTP id ky5mr13979558lab.18.1378687163032;
 Sun, 08 Sep 2013 17:39:23 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sun, 8 Sep 2013 17:39:22 -0700 (PDT)
In-Reply-To: <CALkWK0kSBXCmCcDJ0p+CJMF4V1+RC2s_toRY_wNnZJOA164HNA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234293>

On Sun, Sep 8, 2013 at 7:15 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> Either way it doesn't matter because Junio is determined to stand
>> alone versus the rest of the world in this issue.
>
> Which is why he's the maintainer. Send in incremental updates, and he
> should be fine.

I mean he is against the whole "index" -> "staging area" concept
against everybody else, so adding --stage options is out of the
question for him. So he is ignoring the whole patch series.

-- 
Felipe Contreras
