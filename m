From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [BUG] Bad msysgit/egit interaction over dotfiles
Date: Tue, 8 Dec 2009 15:23:55 +0100
Message-ID: <40aa078e0912080623q108b2affk80534ccd5fd7ace3@mail.gmail.com>
References: <20091208132857.GB5425@linagora.com>
	 <40aa078e0912080534x32fe9724xcda47ad46dbdb7c0@mail.gmail.com>
	 <4B1E57BF.1000500@pelagic.nl>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yann Dirson <ydirson@linagora.com>, GIT ml <git@vger.kernel.org>
To: Ferry Huberts <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Tue Dec 08 15:24:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI0yy-00085C-9n
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 15:24:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755429AbZLHOXv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Dec 2009 09:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755226AbZLHOXu
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 09:23:50 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:45462 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755029AbZLHOXu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Dec 2009 09:23:50 -0500
Received: by ewy1 with SMTP id 1so2793614ewy.28
        for <git@vger.kernel.org>; Tue, 08 Dec 2009 06:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FstxWJruQdGjnDjX/rnx6scWeY6H0u35Q1IWaso1drU=;
        b=YEO7fBzhRGfHAjrrY2BxbnY9hV7bXXh5Z/ixDqNPd//bGEjJWyQk8RkUxx9lsfBe9k
         JEkyzcXwBzLY0W9Jb355V0CJ7Oo9rgB34D2iZ3URfeQORrmI+zP4ubqr2kehQ3EoVHOW
         q3/9VSpgs2ejfr3/23WNF5IhTIZ4cVbQleF88=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=xlv8kl4JAvKN+GwPZJBExsI0M8MXWmIz3HK6UZ5unrz8gzCaW330eDnQY7U1ecdaqX
         um5vO+a2qh03qscyGgImcXyPG+WBxt91m7Zd9PZnMwDvUJGs5Wj2Drbd8yPuUiUf73uo
         V3jO71PrrWJl+jjroqVNSDobjuZRySZ78W580=
Received: by 10.216.93.78 with SMTP id k56mr2925830wef.102.1260282235512; Tue, 
	08 Dec 2009 06:23:55 -0800 (PST)
In-Reply-To: <4B1E57BF.1000500@pelagic.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134876>

On Tue, Dec 8, 2009 at 2:42 PM, Ferry Huberts <ferry.huberts@pelagic.nl=
> wrote:
> On 12/08/2009 02:34 PM, Erik Faye-Lund wrote:
>> On Tue, Dec 8, 2009 at 2:28 PM, Yann Dirson <ydirson@linagora.com> w=
rote:
>>> I'm not sure who's at fault here - namely, I can't see any valid
>>> reason for eclipse to refuse such writes, but I am not sure it is a
>>> good reason for msysgit would set the hidden bit either. =A0In eith=
er
>>> case, even if only for the short term, I think msysgit should ensur=
e
>>> that this bit does not get set (possibly circumventing any magic ms=
ys
>>> would do behind its back).
>>
>> Setting the config option "core.hidedotfiles" to "false" should
>> prevent this from happening.
>>
>
> why isn't this the default?
>
> I also experienced this change in behaviour and I thought we would
> strive to keep the experience the same.
>

You can follow the discussion here:
http://code.google.com/p/msysgit/issues/detail?id=3D288

I believe the reason is something like "because someone suggested it,
and no one disagreed". Do you have a good argument why it shouldn't be
the default (other than "it's a change", because changing it back now
would also be a change)?

--=20
Erik "kusma" Faye-Lund
