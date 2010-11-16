From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Git roadmap (How read What's cooking in git.git)
Date: Tue, 16 Nov 2010 14:38:30 +0100
Message-ID: <AANLkTim4FOixgxUjv24o9gTNqK3DWafmpNtDVMA+PS9d@mail.gmail.com>
References: <AANLkTimtUz3L0F_iOpH7YuYpyoutPqtevPj-Tjo6MRcs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Sebastien Douche <sdouche@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 14:38:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PILk5-0007ZZ-6H
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 14:38:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757328Ab0KPNic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 08:38:32 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49959 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756320Ab0KPNib (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 08:38:31 -0500
Received: by fxm6 with SMTP id 6so454337fxm.19
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 05:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=6Gc9wNKQ1WlmcUGphZ69KluBUUte0daXT41cdpj4rlc=;
        b=NiJ6LfayafBt9yrBU+Cs7Och2XoUsRBfZKzYhHPl5iGR/s7/Pyzwm0+7CwKPHfKUCX
         bieN2PxP4WhAh9oDhakG/fW3kR1Tx9glMTnAUs8OS4+K6lopaioI/EDIfVYujT9ddXxV
         8t3lVPOFEA4YfinHo6guxSADkqb4FXBhU4aJo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=awZIrNwrNxFuKRF1DVm7eRVXyDVO+OexHqYzCES2JPdDn8QGKyoX3kZCQT+zUZCf6H
         1tqHgmYqNpvydjbYASkgsrOb27wgqC8fZGCkX3Uclulp5lKa1/wantzrTF656PEtygC1
         KahDdN+U+Iwls1rYBBacdcMl/V7aTIehhWt0Y=
Received: by 10.223.108.147 with SMTP id f19mr5906068fap.68.1289914710028;
 Tue, 16 Nov 2010 05:38:30 -0800 (PST)
Received: by 10.223.86.134 with HTTP; Tue, 16 Nov 2010 05:38:30 -0800 (PST)
In-Reply-To: <AANLkTimtUz3L0F_iOpH7YuYpyoutPqtevPj-Tjo6MRcs@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161561>

On Tue, Nov 16, 2010 at 13:53, Sebastien Douche <sdouche@gmail.com> wrote:
> I'm starting a french blog[1] on git to support workshops[2]. The goal
> is to explain deeply the philosophy, the commands and subcommands,
> workflows, etc. And also to aggregate headlines of the git world,
> follow events and announce git releases. For the latter, it's a bit
> hard (for a non core developer) to follow the development. From your
> point of view, how we could set up a roadmap and a "what's new"?

Projects that have a "Roadmap" are usually the ones that have paid
developers, where someone will centrally plan what things get worked
on. Then assign developers to those tasks.

Git is a free software project. So it can't have a "Roadmap" in the
same sense.

What we'll end up implementing is a function of what patches people
send, and which of those patches end up passing review and get into
git.git.

You can get something like a roadmap just by following what people are
working on, and asking them what they want to do next.
