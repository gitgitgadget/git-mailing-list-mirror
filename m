From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 9/9] t3703, t4208: add test cases for magic pathspec
Date: Sun, 29 May 2011 22:36:31 +0200
Message-ID: <BANLkTi=1rjt4ezy+4A3nn4Xt44K5ifFo5Q@mail.gmail.com>
References: <1304852906-29272-1-git-send-email-pclouds@gmail.com>
	<1305006678-4051-1-git-send-email-gitster@pobox.com>
	<1305006678-4051-10-git-send-email-gitster@pobox.com>
	<BANLkTimQ7H7SLbA=mREOSK_bQVN5Yo1oiQ@mail.gmail.com>
	<7v1uzhp7tj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 29 22:36:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQmiz-0000yq-Us
	for gcvg-git-2@lo.gmane.org; Sun, 29 May 2011 22:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881Ab1E2Ugd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2011 16:36:33 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57201 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920Ab1E2Ugc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2011 16:36:32 -0400
Received: by fxm17 with SMTP id 17so2139986fxm.19
        for <git@vger.kernel.org>; Sun, 29 May 2011 13:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=rJvwKRRz+PDrykKR5S+A/DnVfA+7+9jM3gtElCpRPfU=;
        b=Dg6MLY1ekL6rktUldveJHXiAygOsN1uR1bPcuYY9RtnwJ3X1g/OVsLBBEzhB9SEUpD
         yd8fIS1+NQYi0TtkaOlDNyG2RIgpA2DTyJdH7IvdJ9kcKdPrOy5HybkwhwAJse+jfI/C
         0LBngnX+BnwA/mMr1rpUbq6eqwKwCG9xh/I78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=M637F4SKk7ZH9RK5nDaZFZxG+t7NNNM8zsOjyVEg2gzxCVQLaLtbcNvzZDLNuZA1ci
         0qW7xhSEyhv4OeGaItpGcD4aa3qHchvBXPkl1qQdJH/3SvhsiI7Az135fAROnKuxqQzv
         31p7QAoX5OMOcFHRR2/XMWpdoNnMu46dCJocI=
Received: by 10.223.145.78 with SMTP id c14mr4724760fav.75.1306701391459; Sun,
 29 May 2011 13:36:31 -0700 (PDT)
Received: by 10.223.117.72 with HTTP; Sun, 29 May 2011 13:36:31 -0700 (PDT)
In-Reply-To: <7v1uzhp7tj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174706>

On Sun, May 29, 2011 at 22:31, Junio C Hamano <gitster@pobox.com> wrote:

>> This needs to use test_i18ncmp.
>
> I don't think so (at least not yet).
>
> Doesn't it come from read-cache.c::add_to_index()?

Doh, this was because I had a local patch by Jonathan in my tree that
I forgot was there. Sorry about the noise.
