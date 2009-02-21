From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [tig PATCH] Predefined external command: git commit
Date: Sat, 21 Feb 2009 19:52:00 +0100
Message-ID: <cb7bb73a0902211052s554e20d7pa412613f56cbf86d@mail.gmail.com>
References: <1235176121-17483-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <2c6b72b30902210819q43cbf184x77d7587a6aa1630a@mail.gmail.com>
	 <cb7bb73a0902210919n45ffb74fp6d4fa0dc9cb7ac1@mail.gmail.com>
	 <2c6b72b30902210951m619c7cf9qa505883f43128e44@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 19:55:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lax0L-0003V2-DH
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 19:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753431AbZBUSwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 13:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753166AbZBUSwE
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 13:52:04 -0500
Received: from mail-ew0-f164.google.com ([209.85.219.164]:51738 "EHLO
	mail-ew0-f164.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890AbZBUSwC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 13:52:02 -0500
Received: by ewy8 with SMTP id 8so13394ewy.13
        for <git@vger.kernel.org>; Sat, 21 Feb 2009 10:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fngVKJSpuGfwjEJkCmWQtlPjOJ+U4FdRzJ0ggSp/6xk=;
        b=FcDrHtWuZsmoYU3wFgJgNRwIirVQ9YcykJiTPp/6Mhc8J7BhstfbmCgULo+U45YlWO
         GgR/45+8OygVKJOuK70wlL1h8s8RQLPHiRh2c5sl5WIztKzIocW/lqDoPf/obm2z5jrr
         t9EPerhoqnIJz9eAqC0jH6HmTJxkMrM3ze1xg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tveyI4DszaBmUU4wWKCXg7JTTnSRqcV/UEG88tBiY/oieMFJE1cvqpoxGL/7Jq8jPn
         4NnyWHE8l6de0giiQ9VItUPFYWMNy5Z67oOvERfxyNY++sL+jPYUnXbbHzs2TYU7wfxD
         tkibCvxacCdeweJYf43IPawiEHQ1pRGiHhHtY=
Received: by 10.210.105.20 with SMTP id d20mr1800844ebc.99.1235242320250; Sat, 
	21 Feb 2009 10:52:00 -0800 (PST)
In-Reply-To: <2c6b72b30902210951m619c7cf9qa505883f43128e44@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110972>

On Sat, Feb 21, 2009 at 6:51 PM, Jonas Fonseca <jonas.fonseca@gmail.com> wrote:
> On Sat, Feb 21, 2009 at 18:19, Giuseppe Bilotta
> <giuseppe.bilotta@gmail.com> wrote:
>> Thank you for this excellent piece of software. I have some more minor
>> patches up at git://git.oblomov.eu/tig (gitweb at same address with
>> http) which I'm going to submit soon.
>
> Don't bother sending the `tig log` patch. ;)
>
> I deprecated this subcommand a long time ago, and would prefer if it
> wasn't added again. Having a lot of subcommands makes it more likely
> that doing `tig $BRANCH` will not do the expected thing. Also, I don't
> find it particularly useful myself and might actually remove it in the
> future, if I ever get to implementing support for defining "custom
> views".

You actually plan on removing the log view altogether?

The problem of conflicting with tig $BRANCH could maybe be solved by
prefixing commands with something (a dot or something easy to type, if
not the traditional - or --)

>> I honestly wish I could contribute with some more important feature
>> such as bundle support or automatic color inversion on light
>> backgrounds.
>
> /me too. :)

I'll do my best 8-)

-- 
Giuseppe "Oblomov" Bilotta
