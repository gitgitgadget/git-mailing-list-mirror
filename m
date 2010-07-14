From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: git am mangles commit author name.
Date: Wed, 14 Jul 2010 14:31:43 +0000
Message-ID: <AANLkTilZJ0g-XbkOsMh3Q1Jo7XQ2dbT1cY-YP_BdXvuh@mail.gmail.com>
References: <AANLkTinqTL7gH4CHEfy8UrhK13xcO_3UzgIyQka00MAh@mail.gmail.com>
	<20100713054949.GB2425@burratino>
	<AANLkTinPCZ79vwZ9eVeHChgTuFGBrz3ACi_grM28Q5Y-@mail.gmail.com>
	<AANLkTikAcZa5J8XhKKJuDCHY3VMhSRzETv0ZQ34EcjMx@mail.gmail.com>
	<AANLkTim6Ax-4SVJU_LvR86SyD5q3VhCfGBlGOkSPTocL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jay Soffian <jaysoffian@gmail.com>, Daniel F <nanotube@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Wed Jul 14 16:31:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ301-0004Ri-NY
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 16:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756525Ab0GNObo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 10:31:44 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:62935 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084Ab0GNObo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 10:31:44 -0400
Received: by pwi5 with SMTP id 5so2769102pwi.19
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 07:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=gn/+03aoqYiVk1JiPz5uUYZaRetXQKejtXBh6nU3AcA=;
        b=f6N5hE5QSyfF4nA+Jbnt9c3NAMmiED0Gn253ckFG1GM7qaFMyFbPvqV5xAA9SHX8CO
         ANhzqFFnMvzQvnxcKcDPhVOX8SUnFs8bUxdverAIERBUdNBoBU6Qq8xc54ErXgd7L729
         yEULgc+Zjaghf+yXj4hRIKDRQ4tjjRRx2BgfE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=pbIiHBc2zs3ws8lyRHccXyIrEl11A2NBWPoaoV7f6ZGaAdLC49a22RJqS0anfeIYmN
         KbRPmXyaK0hY2m4poDwxTZ7b4SsbHpQ28IjJJLdVZiEFOgxN/nqr/VxgX5Urnlts6pCo
         xrZFH7+wV9Wm1cxwxmksI7bEdKKp0ud4wuBo0=
Received: by 10.115.93.7 with SMTP id v7mr1519949wal.9.1279117903516; Wed, 14 
	Jul 2010 07:31:43 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Wed, 14 Jul 2010 07:31:43 -0700 (PDT)
In-Reply-To: <AANLkTim6Ax-4SVJU_LvR86SyD5q3VhCfGBlGOkSPTocL@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150991>

On Wed, Jul 14, 2010 at 14:16, Tor Arntsen <tor@spacetec.no> wrote:
> On Tue, Jul 13, 2010 at 17:11, Jay Soffian <jaysoffian@gmail.com> wrote:
>> On Tue, Jul 13, 2010 at 10:54 AM, Daniel F <nanotube@gmail.com> wrote:
>>> Apparently, git-am fails when the username is just one word.
>>
>> And is less than 3 characters.
> [..]
>
> When I was a student a long time ago there was another (European)
> student there with a single-letter name.
> His legal name was 'Z'. It was printed like that in all official
> documents I ever saw, including bank accounts and loan papers, so it
> wasn't just some nickname he was using.

A lot of people also use their nicknames for their real name in Git,
and plenty of people have 1-3 letter nicks.
