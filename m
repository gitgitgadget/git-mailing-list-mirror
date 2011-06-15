From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Using Transifex in git.git
Date: Wed, 15 Jun 2011 15:21:49 +0200
Message-ID: <BANLkTin9bhtB_OPMWCVsbtKBpRXp2o=uLA@mail.gmail.com>
References: <BANLkTikQJYYd4sTJoDrL28Bo35+GpV3HgA@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Dimitris Glezos <glezos@indifex.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 15:22:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWq3H-0000jX-7x
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 15:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595Ab1FONWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 09:22:30 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55887 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337Ab1FONW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 09:22:29 -0400
Received: by pzk9 with SMTP id 9so222744pzk.19
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 06:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=AFP2ru+86cdkxEYHgC/qPhDwjUZcwac9DXZW3e3HRpg=;
        b=AensFSBjkQOC3NLl+xcey9KzCVBNOkGKkb1t21GKZ+8N2sVOZDx8Sg/6UtLs1TWpA4
         judn5Ia8w47Hx+qpgYFbUGIc37tXBTn76SVLXvARemuhPuuUCUQ7DpokyNEmTyPV+hT1
         /Y8iiGttL8iIhDnu4Gt4nJCs12MJpeb7QAkW0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=AU2h4qFUuYp9DLz41z4d9uDMLNB/fZcKOqBZKpDsij4Y3H0lkFrCR1HAufFqP1e6Ne
         jJL2EUU6OSL7K6ilKD68oqmBKXevA2dIlqgbZzBuHTI5GG3dGj056ZSb5UL5PJpChL5E
         YC5aPqJFhOrNNTzhn0CeHK5sWLblUACGRo2GI=
Received: by 10.68.71.165 with SMTP id w5mr220300pbu.101.1308144149124; Wed,
 15 Jun 2011 06:22:29 -0700 (PDT)
Received: by 10.68.50.197 with HTTP; Wed, 15 Jun 2011 06:21:49 -0700 (PDT)
In-Reply-To: <BANLkTikQJYYd4sTJoDrL28Bo35+GpV3HgA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175829>

On Tue, Jun 14, 2011 at 7:57 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> I think it's a good idea to use a system like Transifex to manage
> translations for git.git, so that we can attract a large number of
> non-technical translators.

Are we sure we want non-technical translators to translate Git, a
highly technical program with many technical terms?

I'm guessing that Git probably should be translated by it's users,
because we have a lot of Git-jargon that is difficult for people who
doesn't know Git to translate. But perhaps an initial translation for
each language is enough to establish a language-specific translation
of all Git-jargon, and then afterwards we can get help from
non-technical people to improve the language? I'm just asking, I don't
know how Transifex works at all...
