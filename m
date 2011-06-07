From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 3/8] t5800: factor out some ref tests
Date: Tue, 7 Jun 2011 19:22:43 +0200
Message-ID: <BANLkTikg_dNv+_4ZUK=L+ONuq5sqpzghKQ@mail.gmail.com>
References: <20110607171838.GA21685@sigill.intra.peff.net> <20110607172012.GB22111@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 07 19:23:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU001-0002IH-Ep
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 19:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754862Ab1FGRXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 13:23:24 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:43534 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753661Ab1FGRXX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 13:23:23 -0400
Received: by qwk3 with SMTP id 3so2250283qwk.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 10:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=4rrl3fZrUzFaAczrI8NY+RuWsfF/tzAVLwOpQ7HIfsc=;
        b=cYSdD+1jFnT8V3nVeOXEzcyJ2sgQ5UKkB78unpIrdnG1HVZGnHd/pwLKCxHKOzdbzd
         YpM2O87wUElzyOzOfNI8UgbTkoCxAUDfgFfAPyeoCLpV+5lq1hpgq3Hunm029WwQ6R+y
         SYmQsor8NphZQu4yjH3ZAVQBmN7FpkHot1rBg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=FhBvD+omu3kcvTedjTlehHl0nHANRA1J8tc8wgDzTrJEiFiLoyvX8oyunvj3vunGSQ
         BrZ1NqllXnnPUOpeENTjJ4XGJsHsq0sPBwejd9/mH04pmzTt4m39m8/ZW2tEdnFSO0ff
         1njVJ3aXW2djqt6TXnYpMdCyqiVUxPCWkaLc4=
Received: by 10.229.100.20 with SMTP id w20mr4748476qcn.129.1307467403116;
 Tue, 07 Jun 2011 10:23:23 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Tue, 7 Jun 2011 10:22:43 -0700 (PDT)
In-Reply-To: <20110607172012.GB22111@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175228>

Heya,

On Tue, Jun 7, 2011 at 19:20, Jeff King <peff@peff.net> wrote:
> These are a little hard to read, and I'm about to add more
> just like them. Plus the failure output is nicer if we use
> test_cmp than a comparison with "test".

Ah, nice :)

-- 
Cheers,

Sverre Rabbelier
