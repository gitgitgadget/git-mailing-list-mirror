From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Using Transifex in git.git
Date: Wed, 15 Jun 2011 22:43:53 +0200
Message-ID: <BANLkTik7Kb6ae0aRNjL3RcMouhw2gkOwPA@mail.gmail.com>
References: <BANLkTikQJYYd4sTJoDrL28Bo35+GpV3HgA@mail.gmail.com>
	<BANLkTin9bhtB_OPMWCVsbtKBpRXp2o=uLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Dimitris Glezos <glezos@indifex.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Jun 15 22:44:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWwwT-0003Pt-Fd
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 22:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901Ab1FOUnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 16:43:55 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33806 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260Ab1FOUny (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 16:43:54 -0400
Received: by fxm17 with SMTP id 17so678090fxm.19
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 13:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=w7RKejA5j+X1I0PgJWEKY1t2imi0BvPRyY0i7LGWCsM=;
        b=fLpPcplKR4kvI1tcT7vtgatSN1NXHofp5oK/nGI12gm4rW3MroB8xz3LsNcYanFtah
         mdpJQ4TVXUhOfqHDZoJGcymotncekjBqysHGh/i9oeda/2KXpzvRKBfz3LMvIJ1pTGDZ
         y1cOxwNXzhDfaKmJBQcfM6sFOoIqhQp0LMiHU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=cnFnnkP4T7boPfiHnaXwdO4Ys4Yz9cntv8YleSEtyQVTSv4jZSC6AO7GJtjgXyOuub
         afZKzEh7/3Nd87FYdsH8C8BlTVfTpRN2FxFgrIb9zY0ujkmO6yXen2WehkzYkQTFOqu6
         HjPeXmYJsba2aHku4jxBL2fAFYzw21hWQaWXk=
Received: by 10.223.16.136 with SMTP id o8mr109007faa.21.1308170633675; Wed,
 15 Jun 2011 13:43:53 -0700 (PDT)
Received: by 10.223.114.208 with HTTP; Wed, 15 Jun 2011 13:43:53 -0700 (PDT)
In-Reply-To: <BANLkTin9bhtB_OPMWCVsbtKBpRXp2o=uLA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175849>

On Wed, Jun 15, 2011 at 15:21, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Tue, Jun 14, 2011 at 7:57 AM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>> I think it's a good idea to use a system like Transifex to manage
>> translations for git.git, so that we can attract a large number of
>> non-technical translators.
>
> Are we sure we want non-technical translators to translate Git, a
> highly technical program with many technical terms?

Well, usually even bad translations (although not horribly bad) are
better than nothing.

Most translated strings will have little or nothing git-specific about
them, but will be something like "We couldn't open file %s due to
XYZ".

And even if someone translates e.g. "branch" incorrectly they usually
do so consistently, so it's easy to search & replace those sort of
issues out of existence.
