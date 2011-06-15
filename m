From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Using Transifex in git.git
Date: Wed, 15 Jun 2011 22:40:03 +0200
Message-ID: <BANLkTin6SPDb8r1fjwWHVmh215esRo5+0Q@mail.gmail.com>
References: <BANLkTikQJYYd4sTJoDrL28Bo35+GpV3HgA@mail.gmail.com>
	<BANLkTikLJJwfGJp_nshRXGSb-yGOshwzTg@mail.gmail.com>
	<4DF74EEC.1050506@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Dimitris Glezos <glezos@indifex.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Jun 15 22:40:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWwsl-0001Fz-Jp
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 22:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753178Ab1FOUkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 16:40:06 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51595 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752750Ab1FOUkF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 16:40:05 -0400
Received: by fxm17 with SMTP id 17so676091fxm.19
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 13:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=W/h6xteXIBpG75jHLqHBUn73WjhqAQ8jJXBRkc2iI28=;
        b=b9XKW10YXJnHc5mLlRVbS9EYbKTtiAg/7Jn5IL/r6ydnyKsIb6nrOH0qxJYSJGfmTO
         MuJmA6g/u+kuzXcodIltwIBrARpwbiCDCtpjWNTCLhD9bdZz9kC+POQUdnR1n3xjCYLv
         fpNsA5l4lLRXfMTUuprAVY9WfXzRUFJUulxzU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=o+MMmqeGZ7hSOcpCHNXD2kNsnc+DYuxkAhgz6JljALH11uTpyvH4Fg8ljmO6pG1JJb
         ZD7IhWE2h4A9WPTm+72lS8mlgm2PVYZMVHed3ZjZogmYdyfajMYWIykMNqx7yWm0m7Sp
         5NVdg4ZgyXwQP9jDxHzrdOHaU+9BCDuv9Kdlc=
Received: by 10.223.65.3 with SMTP id g3mr72044fai.78.1308170404012; Wed, 15
 Jun 2011 13:40:04 -0700 (PDT)
Received: by 10.223.114.208 with HTTP; Wed, 15 Jun 2011 13:40:03 -0700 (PDT)
In-Reply-To: <4DF74EEC.1050506@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175848>

On Tue, Jun 14, 2011 at 14:07, Andreas Ericsson <ae@op5.se> wrote:

> Historically, a translation for one language has been considered "one
> logical change" in that respect. I think it's safe to assume that if
> we want translators to stick around they shouldn't need to divide their
> changes on a per-message or per-command basis. Especially since such
> divisions wouldn't be very easy to do if all you've got to go on is
> a pot-file.

Then again, our policy with patches to the C code is that you should
make make changes in small logical chunks with good commit messages,
so that the people that come after you can make sense of what you did.

Translations are similar, why you chose to translate certain terms in
certain ways could (and IMO should) be explained in commit messages.

I don't think it should be a per-command or per-message basis, just
something like:

 * commit 1: start a XX.po file
 * commit 2: translate the word "branch", and explain why you picked
   that particular translation.
 * Translate similar messages etc.

Or do the whole thing in one big commit, but have a commit message
that explains the choice of translations.
