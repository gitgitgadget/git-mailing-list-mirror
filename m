From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2010, #05; Wed, 15)
Date: Thu, 16 Sep 2010 10:33:17 +0000
Message-ID: <AANLkTinZK2tV81RaF3__LKNbSrY4zuGnB1pinhLHkfUi@mail.gmail.com>
References: <7viq266461.fsf@alter.siamese.dyndns.org>
	<4C91B38D.8010106@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Sep 16 12:33:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwBmP-0000TE-4d
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 12:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753852Ab0IPKdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 06:33:19 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50469 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245Ab0IPKdS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 06:33:18 -0400
Received: by iwn5 with SMTP id 5so955177iwn.19
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 03:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Gjkhly3M2yCehC8Xk/GJplfHS61ecxdTUXUZVkuZVsI=;
        b=h0/S+/T7/EdLSBZ2WHH8/XMiNjS5JuPizpVwV6G8mskROKx5ZGiqiuiL/WhEBxfKap
         vKrryMeXKG2FTKKKNKppKIvzHn7KsKMTVGooNkisVKCyndWk2QqYoMmX6b1QE0OYa8dE
         io7HelTWlWq8wJ5Mc7D/uau4tRhciT7DfILhM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=pXqxhMMl/EKO+1H+Np1mxi6D51ghHjUFVrCLWLN0cnsZPxSjC5Oo8uEAT33ES2RUvt
         kxd5BHBzhpQDYvBh8M1/VcZ9zW71RBTLgEWAqZYEpQBF89vlUFtcMZfeywhRvqLeCn5/
         cyOGx905YGfvJJHa8XrQrtj/f0TJ6sQdIKp94=
Received: by 10.231.193.81 with SMTP id dt17mr2775861ibb.177.1284633197854;
 Thu, 16 Sep 2010 03:33:17 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Thu, 16 Sep 2010 03:33:17 -0700 (PDT)
In-Reply-To: <4C91B38D.8010106@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156314>

On Thu, Sep 16, 2010 at 06:05, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 9/16/2010 0:19, schrieb Junio C Hamano:
>> * ab/i18n (2010-09-14) 140 commits
>
> This topic introduces two tests with number t0201. Please fix it.

Maybe change:

    t0200
    t0200-gettext-basic.sh
    t0201-gettext-fallbacks.sh
    t0201-gettext-poison.sh
    t0202
    t0202-gettext-perl.sh
    t0203-gettext-setlocale-sanity.sh
    t0204-gettext-reencode-sanity.sh

To:

    t0200
    t0200-gettext-basic.sh
    t0201-gettext-fallbacks.sh
    t0202-gettext-poison.sh
    t0210
    t0210-gettext-perl.sh
    t0220-gettext-setlocale-sanity.sh
    t0221-gettext-reencode-sanity.sh

To leave room for more basic/perl tests?
