From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v13 6/6] commit: add a commit.verbose config variable
Date: Wed, 13 Apr 2016 02:58:40 +0530
Message-ID: <CAFZEwPO5uYxh=9FetsNqsDxfGw6HcBWYZg76BcFL4J_2fKAXEw@mail.gmail.com>
References: <01020153faf9fc14-e6ad18fa-c892-4601-bab7-e2cc4cd9e100-000000@eu-west-1.amazonses.com>
	<01020153faf9fcd0-879c8263-6143-4ad2-a3b3-deb78c93246a-000000@eu-west-1.amazonses.com>
	<xmqqa8kyplkp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 23:28:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq5rc-0005er-Fw
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 23:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757930AbcDLV2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 17:28:43 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34811 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757882AbcDLV2l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 17:28:41 -0400
Received: by mail-yw0-f193.google.com with SMTP id h6so4071782ywc.1
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 14:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=spOiECoW1VXGImNuPrRia4RL0hjEMkqtowWJFR3sHAc=;
        b=iD6WCHNBmG7JorabjuKaR60pH9fJvRES4ebLu+SP3yiyt05rfyGqEL3Mxj1R90bd/A
         A6Z5iuxjKFgGIBZ8oRXMfYyHw7b3LA64OkmD5huUj4ONcAHWriXQgqydWJ+LgxDRu7vV
         bqZ6LNX2Q8Are3hkM69R41zIGgUv31lGKZeI7T6tqSk3CbgbYkZcaEJ6ENUTt7fssrNa
         06GL4QwcII5Ptg115mk2V5kspfJwV5ADuEwbaBKsneeE0uuZM+X1fl0JK+hMnuAyiYzp
         dkuXpUhIpzLSoCu3rEo+ufVIoWz8xpun7+CG96QE3CeXuaMUqTcSxleLPmFkh2/Jn12E
         fdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=spOiECoW1VXGImNuPrRia4RL0hjEMkqtowWJFR3sHAc=;
        b=BjG37Kh2g/8JOUqbPcChxq3n1vn/4AWbP2A7LoaAv9U4uuuCeBrEUX7z7GdDSzMCCn
         oqRySdlsdSBxj540k7NfNOS+a3s2SG/8nV9trSHfwfMRWYhfBlU2m9v/HFLgqPrMYSYs
         0T2R4HQC9wKd9Cm/yilFZWCVItyYoL500kS9WgiKF6JuRKUqXAUKG4jpXpHoPzsnNBI7
         mKWWn1gl0yQia1LICDaugNgFhOE9N3/yAOA2XR7JaE66Us6tkIo+oMdWGl2Dp4gr4MPI
         BaD6xohvcdY0Ajo5PHa8qiJkglOZUX/CHylEIcQqQqotY7VvAoVHEhEqLRL952/AkeL5
         Rx7A==
X-Gm-Message-State: AOPr4FU3H2bwKi5v0fg4xvQoJRUwRc/nrYvktXr3+YO1M7qCOZWFlUc0mMuwNhaTT0DK7sIDCVAX6yX+yZ41QA==
X-Received: by 10.13.235.209 with SMTP id u200mr3326762ywe.20.1460496521030;
 Tue, 12 Apr 2016 14:28:41 -0700 (PDT)
Received: by 10.13.219.81 with HTTP; Tue, 12 Apr 2016 14:28:40 -0700 (PDT)
In-Reply-To: <xmqqa8kyplkp.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291298>

On Wed, Apr 13, 2016 at 2:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Hmph, isn't this already in 'next', hence we cannot accept a
> replacement patch?

Yes, this is already in 'next'. This was going to be merged in the
third cycle after 2.8 but on my request, you delayed it. So this is an
update on the patch. Is it that once a patch is in 'next', it cannot
be replaced with a new updated one? There are 5 other patches along
with this which are a requirement for this patch.
