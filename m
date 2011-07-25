From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2] tests: print failed test numbers at the end of the
 test run
Date: Mon, 25 Jul 2011 16:31:36 +0200
Message-ID: <CAGdFq_gCQwgk0yN5e-DJWcURx02ETT_8KD3qGw4hBnMg8PbWTw@mail.gmail.com>
References: <4E2B1DF2.4000003@web.de> <7vmxg4w2fm.fsf@alter.siamese.dyndns.org>
 <4E2C1FBA.3010606@web.de> <20110724153950.GB7805@sigill.intra.peff.net> <4E2C70AB.2060306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jul 25 16:32:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlMCk-00004z-P0
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 16:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817Ab1GYOcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 10:32:18 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:45159 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab1GYOcR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 10:32:17 -0400
Received: by pzk37 with SMTP id 37so8599915pzk.1
        for <git@vger.kernel.org>; Mon, 25 Jul 2011 07:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=19r7jyc53mwq0Vj8buoAcLQtGskW/lWcRyjw2if6Tb4=;
        b=nhiB9kuBrFrbUr//BNxx3nKudMl3ujg1GdSge3DL/6jAbNhVy2HLLb+iqVzRLBzBvR
         XhYTlqgGioLZwvymi4gckIpYOUbZEn43U9iC3Y5u9qcizUeZ92rvJmopEDO9KPgXEeYe
         u+PhZAuXsbLHlOformt5OjKbw5Gb4Ez8X+GEI=
Received: by 10.68.54.164 with SMTP id k4mr2059055pbp.310.1311604337101; Mon,
 25 Jul 2011 07:32:17 -0700 (PDT)
Received: by 10.68.71.162 with HTTP; Mon, 25 Jul 2011 07:31:36 -0700 (PDT)
In-Reply-To: <4E2C70AB.2060306@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177796>

Heya,

On Sun, Jul 24, 2011 at 21:21, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Ah, now I understand how I managed to shoot myself in the foot when I tried
> that: I used "-i" instead of "-k" for make, so the test-results directory
> always was deleted after the tests ran.

Regardless, I like your patch. I don't use prove, and I'm always
afraid that when I run the test suite I'll find a test that failed
with no way to find out which :).

-- 
Cheers,

Sverre Rabbelier
