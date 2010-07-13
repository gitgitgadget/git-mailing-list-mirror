From: Daniel F <nanotube@gmail.com>
Subject: Re: git am mangles commit author name.
Date: Tue, 13 Jul 2010 10:54:52 -0400
Message-ID: <AANLkTinPCZ79vwZ9eVeHChgTuFGBrz3ACi_grM28Q5Y-@mail.gmail.com>
References: <AANLkTinqTL7gH4CHEfy8UrhK13xcO_3UzgIyQka00MAh@mail.gmail.com>
	<20100713054949.GB2425@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 16:55:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYgsu-0000V9-Ai
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 16:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756703Ab0GMOyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 10:54:54 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51211 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756313Ab0GMOyy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 10:54:54 -0400
Received: by vws5 with SMTP id 5so5894693vws.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 07:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=ttxbZIq+N3a1lE/tEswXvUb0JrYKwwzVGeEJ7yW8/l8=;
        b=HqHJwbnD+ePU6v2aTD91nQnqbOedB/gHtLkRyK5XHerWJ8x0fTcj0syh+St+51gBOD
         ZjHPTK2VeWXpHkuE6NAhfbfW94Rv46LIHG2DIF44kGW9Q4zZ2YtG2uAPBb1lBsMC5bNj
         4AqTgZD2OlnOQxWG9JBoezb6AQLPpzehu88BU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=b8KYWZMaQGsmTqHsiSBqGE5bbj8eLAnDQbwFHCmYS6wakRlI8MUV4WTN/CAWyGoAfd
         LVuIM4pNaMbqE9dkD5DRf9DNi6tCfePEwdA4r5lUCG+Yw7+i1F2V5ZDJh86AkNsE27wN
         sgFB7gJ0hHPcOVk2zbxauMCTvgNd4TvsMhXYM=
Received: by 10.220.171.211 with SMTP id i19mr7858306vcz.252.1279032893047; 
	Tue, 13 Jul 2010 07:54:53 -0700 (PDT)
Received: by 10.220.186.132 with HTTP; Tue, 13 Jul 2010 07:54:52 -0700 (PDT)
In-Reply-To: <20100713054949.GB2425@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150901>

Hi Jonathan,

Thanks for your response!

On 7/13/10, Jonathan Nieder <jrnieder@gmail.com> wrote:
> The commit author showed up with name and email address as I expected.
> What did I do wrong?
>
> Alternatively: could you send the first few lines of your .patch file?

I figured it out :) This was the from line:
From: bc <email@somedomain.net>

Apparently, git-am fails when the username is just one word.
if i put a space between the b and the c, it works just fine.

However... do you not think that it is still a bug? Is it not quite reasonable
for a person to want to identify with just a nick, rather than a full
first and last name?

And more to the immediate point... is there any way i can get git am
to do what i want? :)

Thanks,
Daniel
