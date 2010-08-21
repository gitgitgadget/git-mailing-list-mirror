From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] builtin/checkout: Fix message when switching to an
 existing branch
Date: Sat, 21 Aug 2010 11:28:06 +0800
Message-ID: <AANLkTin3+uAYXYsYG9DHxy9BhAg=CE5B7Oy09X7ze-OL@mail.gmail.com>
References: <1282326107-2139-1-git-send-email-artagnon@gmail.com>
	<AANLkTim4K7LnZOhGQUNwpLR24Hm+V1fWrxY2UE2oPGx7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 21 05:28:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Omeks-0005xp-RL
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 05:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289Ab0HUD2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 23:28:08 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:61972 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236Ab0HUD2H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 23:28:07 -0400
Received: by ewy23 with SMTP id 23so2604809ewy.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 20:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=kJ99Z/j+/M9LTV/RYGNU1TonJk+s0FLKya0OxYk0F8s=;
        b=jCP+xs1wvj3ezl9MuUwbKR6OYdK+L+Ma5YERGZbPR56nYReV2Q1CEZuUFLu/Z97BX1
         yrWejuW+e5T2lmPGd5aC4nojRPQWK7FD9TVFi6nITjAQ0yyOrHqFMKIFOC4DAy/XDFs3
         fzuUGuESeWOwoHDQ55GWAGD9gBWmPpfaj8uZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=i7jRJIzs71r4QKQlmWGZ3ZNIHXQajoMX/feGYXrmW0la6DEl7hCuqIDQSGVQ0CE1Uw
         n5/UW06N9Jy8pDzwt69vqBoZdxABPDCxT3pGn0laA18yjxvw6bM1fbcXQV89DeafvCuE
         1sGBxSHSllWe4Rze6B400ZrwsRL/FWxHSTkkQ=
Received: by 10.213.34.195 with SMTP id m3mr682271ebd.39.1282361286305; Fri,
 20 Aug 2010 20:28:06 -0700 (PDT)
Received: by 10.213.22.134 with HTTP; Fri, 20 Aug 2010 20:28:06 -0700 (PDT)
In-Reply-To: <AANLkTim4K7LnZOhGQUNwpLR24Hm+V1fWrxY2UE2oPGx7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154093>

On Sat, Aug 21, 2010 at 11:15 AM, Tay Ray Chuan <rctay89@gmail.com> wrote:
> On a closer reading, I realise that "reset" isn't mentioned if the
> branch exists.
>
> The terser ternary version doesn't suffer from this defect.

Sorry, please ignore that.

-- 
Cheers,
Ray Chuan
