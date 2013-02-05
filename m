From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Feature request: Allow extracting revisions into directories
Date: Tue, 5 Feb 2013 14:25:55 +0530
Message-ID: <CAMK1S_j_7MjuLoER8CGXhnEasu2XANcB9zkV7k=G_TUYXaw+Tg@mail.gmail.com>
References: <1359901085.24730.11.camel@t520>
	<510F9907.7010107@drmicha.warpmail.net>
	<1359980045.24730.32.camel@t520>
	<1359982065-ner-9588@calvin>
	<7v7gmo3tte.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tomas Carnecky <tomas.carnecky@gmail.com>,
	Robert Clausecker <fuzxxl@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 09:56:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2eKH-0007RS-CK
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 09:56:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756682Ab3BEIz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 03:55:59 -0500
Received: from mail-wg0-f48.google.com ([74.125.82.48]:42576 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756603Ab3BEIz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 03:55:57 -0500
Received: by mail-wg0-f48.google.com with SMTP id 16so5434965wgi.27
        for <git@vger.kernel.org>; Tue, 05 Feb 2013 00:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=rE4zzqP7yZw3nCiSuNhWjkYhWdJ54HIYsT4030bVhu0=;
        b=Um/2hdMDGUkmrWiT0TF/q61DwWo5pIsoGQ+/alwvgwehkOZLhbrtGAAtUNg9/+96PG
         2FNVSaN0LLCy+xaFRAa58GRAzmk2mIelOh3dV1Ec3jOs4JUUKQvJrTtmbHlaqoEi2C/W
         Moe7D1QBoTDzk34KGWKmYDlLxbJZLD0b0UijtY7pL9c+LkZC7yXTsQwVEhKhkwqkOTCx
         V6Xyhpb/RWvBVn7UXtzNT/7p6e5RwIh/k+0TE+HL39mvxNXqzPy+eC+oU/HZszx+F3bz
         5R/8pMKOiot5ayHcDT/C5nzeMNj7L6pk1274S7KqYhSPePFt6ckSSfj63e9p0bgmE0xL
         ALMA==
X-Received: by 10.180.105.67 with SMTP id gk3mr8376637wib.31.1360054555867;
 Tue, 05 Feb 2013 00:55:55 -0800 (PST)
Received: by 10.194.94.71 with HTTP; Tue, 5 Feb 2013 00:55:55 -0800 (PST)
In-Reply-To: <7v7gmo3tte.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215469>

On Mon, Feb 4, 2013 at 10:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Tomas Carnecky <tomas.carnecky@gmail.com> writes:
>
>> That's what `git checkout` is for. And I would even argue that it's the better
>> choice in your situation because it would delete files from /var/www/foo which
>> you have deleted in your repo. git archive|tar wouldn't do that.
>
> The point about removal is an interesting one.  From that /var/www
> location I guess that you are discussing some webapp, but if you let
> it _write_ into it, you may also have to worry about how to handle
> the case where an update from the source end that comes from the
> checkout and an update by the webapp collide with each other.
>
> You also need to maintain the .git/index file that corresponds to
> what should be in /var/www/foo/ if you go that route.
>
> Just to be sure, I am not saying "checkout" is an inappropriate
> solution to whatever problem you are trying to solve. I am just
> pointing out things you need to be aware of if you take that
> approach.

http://sitaramc.github.com/the-list-and-irc/deploy.html is a fairly
popular URL on #git, where the bot responds to "!deploy" with some
text and this URL.

Just sayin'... :)
