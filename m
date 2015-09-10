From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: storing cover letter of a patch series?
Date: Thu, 10 Sep 2015 14:00:02 -0700
Message-ID: <CA+P7+xrH6v7AVaH_su2X3xx7qs_uws-r-DozzYELm_O8g+oN9A@mail.gmail.com>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
 <74514591d4cd502eee06cde3e099e656@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 10 23:00:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za8xI-0000nT-Qm
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 23:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbbIJVAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 17:00:24 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:33899 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbbIJVAX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 17:00:23 -0400
Received: by iofb144 with SMTP id b144so76535517iof.1
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 14:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3k/G0jvnvyj/WwasT1VCCCabTcqiVYAPMvD8i5DKvj0=;
        b=c0iSnnLrhq57QyqI1CtYO5NAommH7z3f2GfqJ9dDJwv8V8ec24dGCtDbvrJ0e8YhJ6
         eg6OgFbsW3UY/eWWT8JcyWkXQEfaPiJMu12GdxwSasc5jtqZbjrY1CHiDFnuBoHIgrPK
         BONOU5TiIhp1RhhqoYHFjowhlLs0au3NpORAumeB2gpVxLHE0IzETzDrY2OfAJberXpV
         COCiGJIHU8Pkf47tqLdh1AOi94R7lNK90phT5wsDZc4LD0JL61qVAgjQQWp62lsvtVtq
         oBxId40s1J92nkK5w4uQds9rZxM3Z+SJm5UwVxoU0Pb2+BcwMtodBN1qAl6Rbezvinn3
         ADcw==
X-Received: by 10.107.14.202 with SMTP id 193mr64723267ioo.146.1441918821929;
 Thu, 10 Sep 2015 14:00:21 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Thu, 10 Sep 2015 14:00:02 -0700 (PDT)
In-Reply-To: <74514591d4cd502eee06cde3e099e656@dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277636>

On Thu, Sep 10, 2015 at 11:58 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Hi Jake,
>
> On 2015-09-10 18:28, Jacob Keller wrote:
>
>> does anyone know of any tricks for storing a cover letter for a patch
>> series inside of git somehow?
>
> It is not stored as a blob, but I use `git branch --edit-description` to write the cover letter for patch series when I expect a couple of iterations.
>
> Ciao,
> Dscho

Does this (or can it?) get used by send-email or format-patch's
--cover-letter? This sounds like exactly what I want.

Regards,
Jake
