Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78B4E1FF40
	for <e@80x24.org>; Mon, 20 Jun 2016 19:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496AbcFTTpR (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 15:45:17 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:33561 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753495AbcFTTpP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 15:45:15 -0400
Received: by mail-io0-f174.google.com with SMTP id t74so132424815ioi.0
        for <git@vger.kernel.org>; Mon, 20 Jun 2016 12:45:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dS3zgqaHS0gI6GQXAEZQ6ur9v8dSVNLN5kFxWAjee5I=;
        b=rmXN2m60VR0e5B5Qy0dzzys6dZMahJ9IoeoC7pjGutZ9e+r3oSg1dVGZqctf05ok7L
         18Pcnw88iJOhwXPosuVwbEL5G7x1d7rwnlnyP5hTgnpaG5yoeEAjHm8kxwP4qFK04V1F
         yocoaJQliEFXXMpA3QWpv1BjYs5gbPMgXIydCs7NU46UXV4mlZw4cf4NYgB6HV5+ZX7g
         ZPy7imIAJU3EPFvVE0amWy4MYBVlLot+Ewh4+nJyS0TwLWE1KZ796NDtO72QGI5HW4H5
         jxSowT3reakQSlGgLacczoiAwHXwrWfzaoAMBas1FTFCuXi6eZDN5XFDg80wkh/tZlgM
         Hs9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dS3zgqaHS0gI6GQXAEZQ6ur9v8dSVNLN5kFxWAjee5I=;
        b=KI1CPbQY8CnCxCSwTkY0I8z3W4loidrXZ+ZCnIguRW9t6aIDsDEYTVKerHxZa7UtEe
         nNutfluvAunjZuT562qUsAAGsA5p+FoQXcbtqlXukND/WOxzDSoFQ/+H1+HBsqv5iSwL
         PrJ949Ed7WlNyiSJaF3AEDO8YIbXEIlsT/U4GHR6+Yi4SEmp3ZiYwpmZOdCgsPcAhujD
         5ry2MNiQL94bcnH9TthrrT2Rz1by7dCr3iDnVAucaXEongdEfv/2CudlWPySRQ7xX0dK
         SkHDfUVtKFXRdbIdK2+VXhdKaQ+fzOAcOrwTCfM5HaeI4sQgehZ6YdTZmsF89J5rJJq0
         FWiQ==
X-Gm-Message-State: ALyK8tJ8+Ys/bmGbbh4CYnI/Uxzr9rUnCYCSJNDzze2V0FQhN5+f0m2IAcGB2++3VQ9lalXRQY/8lyvklpUK8A==
X-Received: by 10.107.47.214 with SMTP id v83mr25525873iov.154.1466451914096;
 Mon, 20 Jun 2016 12:45:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.175.104 with HTTP; Mon, 20 Jun 2016 12:45:13 -0700 (PDT)
In-Reply-To: <20160620193928.GA3631@sigill.intra.peff.net>
References: <CAM+g_NswH8fd8aFPEHfSLYnZWptNU2GX=xTWpehzjTJfJM_GfQ@mail.gmail.com>
 <CAGZ79kZL-ZY_0hZx9uA-ObPvMiD+EWvJYQa+OfCeQe2RLOPECA@mail.gmail.com>
 <CAM+g_NtNAWpLkbErL5-BUyH_3X4rYGfZwO0o-Hfu8zyam8pw7Q@mail.gmail.com> <20160620193928.GA3631@sigill.intra.peff.net>
From:	Norbert Kiesel <nkiesel@gmail.com>
Date:	Mon, 20 Jun 2016 12:45:13 -0700
Message-ID: <CAM+g_NsxQrHedp0BNTjMP9H8XfaK7XaYcGdSSkc=BW4QigVixw@mail.gmail.com>
Subject: Re: unable to pull from remote if commit date is in the future
To:	Jeff King <peff@peff.net>
Cc:	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 20, 2016 at 12:39 PM, Jeff King <peff@peff.net> wrote:
> git cat-file commit 23c07cc | egrep '^author|committer'

author Sean D'Epagnier <seandepagnier@gmail.com> 5758122296 -40643156
committer Sean D'Epagnier <seandepagnier@gmail.com> 5758122296 -40643156

date --date='@5758122296' returns "Mon Jun 19 15:24:56 PDT 2152" which
is what is shown by github.
