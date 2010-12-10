From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 14/14] wt-status.c: Initialise variable to suppress msvc warning
Date: Fri, 10 Dec 2010 16:43:12 +0100
Message-ID: <AANLkTimXVXoY3tENBy1EzTF7Hg00WPpww6pCf-hF6aT9@mail.gmail.com>
References: <4CFA92A2.4030801@ramsay1.demon.co.uk>
	<20101204205206.GB3170@burratino>
	<4D011D30.4070405@ramsay1.demon.co.uk>
	<7vmxoeg3wp.fsf@alter.siamese.dyndns.org>
	<AANLkTi=SzDhoQnLeKUvWe7A6r-7MT-DTLuDGLprqid9X@mail.gmail.com>
	<AANLkTinty08S2vT9ZSVQW03yL5uzrmqW7k_Ozad-q-E2@mail.gmail.com>
	<AANLkTikE34sk_bsAZSmq-9MaV-RE+GCJgNszm2o2qHGD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Dec 10 16:43:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR57v-0005PP-VD
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 16:43:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756001Ab0LJPnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 10:43:14 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:53516 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832Ab0LJPnN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 10:43:13 -0500
Received: by qwa26 with SMTP id 26so3989245qwa.19
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 07:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=uM5+Xkf66ooqAOsAtU03b9eKZtOW8n8ZK8TmFG+jp7s=;
        b=IClDyIug2FLuXKb3XJCmc/Oc6DerkN/YBqZxYDWpLRK1jA+0UJllBvbSwHoSVr2dje
         tfp1nQS5MOmD65GRqKCCXcgV7tOCSXWf58i3PjgGhxHULih6m/1yiaG6dpvBQgNlFJcW
         MZ69tZRlulJCBm2m1j/5bPgB+mViQzZVj1J8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ZjB/beCkIUiY35yNGqrtKfS+4Nk3lLuwkQqVC1E6XGKeRv2uRbOx2b5Zzeb5P31AW3
         aCzkkccUN28KkDCrJ6Be1NAcHsB8YN7l6pv/4y6xB6c2SPd4mrxvCutjYcT/1Qxc6MlS
         WPjI6aAQhtmX5FQ4y00Yw3AUANVCAIKh3atQg=
Received: by 10.229.81.71 with SMTP id w7mr795399qck.158.1291995792156; Fri,
 10 Dec 2010 07:43:12 -0800 (PST)
Received: by 10.229.25.81 with HTTP; Fri, 10 Dec 2010 07:43:12 -0800 (PST)
In-Reply-To: <AANLkTikE34sk_bsAZSmq-9MaV-RE+GCJgNszm2o2qHGD@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163419>

On Fri, Dec 10, 2010 at 16:05, Erik Faye-Lund <kusmabite@gmail.com> wrote:

>> FYI: In contrast to previous versions, Visual Studio 2010 ships with a
>> stdint.h header which defines INTMAX_MAX etc. However, that stdint.h
>> is not included by limits.h (in fact, not by *any* other shipping
>> header file, as it seems), so we should not run into any trouble even
>> with VS2010.
>>
>
> Very interesting, thanks. Did you try to compile Git on VS2010? This
> sounds like a reason for me to install VS2010 on one of my machines...
> :)

I just gave it a quick try by just importing the VS2008 solution, and
there seem to be some CRT related link problems, but these should be
easy to resolve. I don't have the time right now to look any further
into this, sorry.

-- 
Sebastian Schuberth
