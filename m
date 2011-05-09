From: Ciaran <ciaranj@gmail.com>
Subject: Re: What's cooking in git.git (May 2011, #04; Sun, 8)
Date: Mon, 9 May 2011 09:55:58 +0100
Message-ID: <BANLkTimz5KpSC04gQkYL+oXJu5JfR8t8nw@mail.gmail.com>
References: <7v8vugqvy3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 09 10:56:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJMG7-0002N8-4X
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 10:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989Ab1EII4A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 04:56:00 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:63913 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074Ab1EIIz7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2011 04:55:59 -0400
Received: by yia27 with SMTP id 27so1717744yia.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 01:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ltwxmzt844yC05KnBBhQsuJN+8i0+uyaG0o7s+5YOFo=;
        b=RGgkGdMDq5xfg750SXFnyzYcFTWGzyacUZdkBweFY2AqA/ZegGZLyIT/7CQhmS6vnT
         QcksDcCpsbAp6ELxYclfp6zUNKrDAE8GVNG+bs28dEk/jw7nr52w71m2+yxzgxCnfRys
         E2B1ovvk7OQFgXgKLKa2/ymWAwuqTnDWXsvsg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YSUg1u7oUfVGHeIZQAArihOvct6ih8aorfzRW2V4K1TMecFGRT05Bdc8U5g6RNZETh
         EqvjOdkPHSuOEmR+MkPPCIgfXWQx2S0mLfkc7N6CN2iki18XIi9vYvTIZgyc937U/Wei
         ZqmAo4y26INI/0pzRNxyxIpoP4TSLV8Y3zOQA=
Received: by 10.236.19.171 with SMTP id n31mr7570765yhn.436.1304931358061;
 Mon, 09 May 2011 01:55:58 -0700 (PDT)
Received: by 10.236.42.193 with HTTP; Mon, 9 May 2011 01:55:58 -0700 (PDT)
In-Reply-To: <7v8vugqvy3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173212>

> --------------------------------------------------
> [Stalled]
>
> * kk/maint-prefix-in-config-mak (2011-05-04) 3 commits
> =A0- config.mak.in: allow "configure --sysconfdir=3D/else/where"
> =A0- Makefile: allow sysconfdir to be used from configure
> =A0(merged to 'next' on 2011-05-02 at c747ba3)
> =A0+ Honor $(prefix) set in config.mak* when defining ETC_GIT* and sy=
sconfdir
>
> J6t is unhappy that sysconfdir is ignored in relocatable case. Althou=
gh I
> personally do not think that is a problem, as it has never been an is=
sue,
> let's see what others think.
>
> * jn/gitweb-js (2011-04-28) 13 commits
> =A0- gitweb: Make JavaScript ability to adjust timezones configurable
> =A0- gitweb.js: Add UI for selecting common timezone to display dates
> =A0- gitweb: JavaScript ability to adjust time based on timezone
> =A0- gitweb: Unify the way long timestamp is displayed
> =A0- gitweb: Refactor generating of long dates into format_timestamp_=
html
> =A0- gitweb.js: Provide getElementsByClassName method (if it not exis=
ts)
> =A0- gitweb.js: Introduce code to handle cookies from JavaScript
> =A0- gitweb.js: Extract and improve datetime handling
> =A0- gitweb.js: Provide default values for padding in padLeftStr and =
padLeft
> =A0- gitweb.js: Update and improve comments in JavaScript files
> =A0- gitweb: Split JavaScript for maintability, combining on build
> =A0- Remove gitweb/gitweb.cgi and other legacy targets from main Make=
file
> =A0- git-instaweb: Simplify build dependency on gitweb
>

Sorry if this is dumb, as I'm unsure how Git (the mailing list)
handles regression tracking, but I saw no mention of this thread:
http://marc.info/?l=3Dgit&m=3D130445013906259&w=3D2

Is this something overlooked or something you're aware of just not
worried about at the minute.   What is the process if a merge to
master causes a regression, do you just git revert  the offending
merge,   fix on the branch, then re-merge?

Many thanks
- cj.
