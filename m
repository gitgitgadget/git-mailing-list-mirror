From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Tue, 4 Dec 2012 08:19:18 -0600
Message-ID: <CAMP44s0rcy6OfMPM+8BhQy0DbxRLBHEsraHw0u4oAZzh5euTzg@mail.gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
	<CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
	<50B1F684.5020805@alum.mit.edu>
	<CAMP44s0WYiV3hTE7u28_Wd59FkGfu3o_psS0gocpnibzN4--Fg@mail.gmail.com>
	<20121127143510.GA15831@google.com>
	<20121127183530.GB11845@thyrsus.com>
	<CAMP44s27gdDJGNx-UTe1rdQZFpn3M60L=nMyd69gAFo15VnMAA@mail.gmail.com>
	<CAGK7Mr4HkCkbw-SV-d=JAmQieV0ZQOE7YqR-g7rTWzHGPYqzHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: esr@thyrsus.com, =?UTF-8?B?TWFnbnVzIELDpGNr?= <baeck@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 15:19:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TftLT-0001iC-Lx
	for gcvg-git-2@plane.gmane.org; Tue, 04 Dec 2012 15:19:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028Ab2LDOTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2012 09:19:19 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:56959 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982Ab2LDOTT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2012 09:19:19 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so3920042oag.19
        for <git@vger.kernel.org>; Tue, 04 Dec 2012 06:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=f8IFNzKNjqa+74qpz+MJLmcyeYPXbnR3cLIU1DWF9Iw=;
        b=kSCkg/Q1Y9rmIuNff9PwjiBtOU/l4VI42YuH0zHipizVm+iC6jYAaSExyWK1+Oijg/
         WM2PPMlTTDmJf0DuYZMoTZy4FMCIkKMLPmlDn7XyC3twAi/jhqI8XCqWVeE3CsSGK9G2
         G3ObR1Uhipw/XPeb4yR9Hy/ond62RIVjhEdEk54U7BysbAloFvV6UUflA7ruqiJ5EOne
         8YonMHUj7l8hl8HORRvOnYnFQQtGff9NiPq1VtBcNqpLEiqx/UetVV57yO/CHF0IEBku
         +fzX85XgHsHGto8CayI//LrwPaN/80Ks0L+w+x4mATCVEkxMOtiUq7NeXLJWG1IMGk3R
         BtoQ==
Received: by 10.60.172.229 with SMTP id bf5mr11334700oec.81.1354630758590;
 Tue, 04 Dec 2012 06:19:18 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Tue, 4 Dec 2012 06:19:18 -0800 (PST)
In-Reply-To: <CAGK7Mr4HkCkbw-SV-d=JAmQieV0ZQOE7YqR-g7rTWzHGPYqzHA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211084>

On Mon, Dec 3, 2012 at 3:45 PM, Philippe Vaucher
<philippe.vaucher@gmail.com> wrote:
>> Also, you are ignoring all the advantages that shell has and python does not.
>
> Out of curiosity, can you list the advantages? From what I gathered:
>
> - no need to install bash

Unless you are in Windows or OS X. OS X has a shell, but not bash.

> - git contributors are more used to bash

I don't see this as a big advantage.

> - there's only one "version" of bash (no real need to handle different
> versions compared to py26, py27, etc)

This one is.

The language doesn't change much from different versions of bash either way.

- the language is part of POSIX

Which means you don't need bash, you can use dash, or zsh, or many other shells.

- the language is simple

It's so simple it's used in shells.

- no need for extensions

All you need is the shell binary, that's it.

Cheers.

-- 
Felipe Contreras
