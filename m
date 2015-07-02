From: Lawrence Siebert <lawrencesiebert@gmail.com>
Subject: Re: [PATCH 2/4] log: add --count option to git log
Date: Thu, 2 Jul 2015 16:45:28 -0700
Message-ID: <CAKDoJU7uu3wXszV=Cq115CegRR2QQdGAvMpjXr4+qYU-fmEN4g@mail.gmail.com>
References: <1435815536-30611-1-git-send-email-lawrencesiebert@gmail.com>
	<1435815536-30611-2-git-send-email-lawrencesiebert@gmail.com>
	<167999398.140205.1435828465233.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jul 03 01:45:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAoAh-0002tx-0b
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 01:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754261AbbGBXpa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jul 2015 19:45:30 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:33125 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944AbbGBXp3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jul 2015 19:45:29 -0400
Received: by obpn3 with SMTP id n3so59638333obp.0
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 16:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=PDSTWuZvHF7JjZkFmdi7F5/Hd4d5DaeqHlWK+NQbORE=;
        b=B843+WfoBX598VgBMBFTyLBpTc9a/8T2+9WMdsNCyijZQ32eG1BYGhbRAtUo6cwJEB
         coMZF8ZQfhtS+qWw2PUw+c8EMxuUk7I4amwMuYh0OC5hm1SVLtSs9bQE1ghFYSRvtUzQ
         /kQsQcq2S4VBjrbqEJ9IS8CAay6uMZ3gqX7sf3PdIKqk5Xnw8VfwGdJKIq8Nz0q4bEbO
         OFCXY8CJyBxFVnxms+/1RoHwJqnZlhga1BoxvXNpM8pRAC/fCnaoy7UYzAqn/pDO2jMK
         5qy4OgUFle/sMEXxdG+d1FjLjf7C3N9LJieGvEF71a6WXv7YYh7Pw0bW+vPtPeRfStNu
         xuiQ==
X-Received: by 10.182.87.69 with SMTP id v5mr29494881obz.37.1435880728565;
 Thu, 02 Jul 2015 16:45:28 -0700 (PDT)
Received: by 10.76.153.101 with HTTP; Thu, 2 Jul 2015 16:45:28 -0700 (PDT)
In-Reply-To: <167999398.140205.1435828465233.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273273>

Thanks.  I've modified my vim config to avoid this happening again,
and i'll submit a fixed version of these patches.

I'd love if there was a precommit hook to test for this.

Lawrence

On Thu, Jul 2, 2015 at 2:14 AM, Remi Galan Alfonso
<remi.galan-alfonso@ensimag.grenoble-inp.fr> wrote:
> Lawrence Siebert <lawrencesiebert@gmail.com> writes:
>> +                prepare_revision_walk(rev);
>
> There's trailing whitespace here.
> (See my message in 3/4)
>
> R=C3=A9mi



--=20
About Me: http://about.me/lawrencesiebert
Constantly Coding: http://constantcoding.blogspot.com
