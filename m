From: Sheldon Els <sheldon@easyfundraising.org.uk>
Subject: Re: git feature-branch
Date: Fri, 25 Jul 2014 06:40:47 +0100
Message-ID: <CAJnDmGLaXPFYSVteehdz66C-kiDcBpAkQpW-uX8x-s9Qe_+kNA@mail.gmail.com>
References: <CAJnDmGJ16NRV7kUuwE7Cr6Pc202yq8YuXdUB-5=aXRQWCDfK2g@mail.gmail.com>
 <53D1D90C.5040704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 07:41:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAYG9-0004Cz-NB
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 07:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbaGYFlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 01:41:10 -0400
Received: from mail-vc0-f175.google.com ([209.85.220.175]:55173 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbaGYFlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 01:41:09 -0400
Received: by mail-vc0-f175.google.com with SMTP id hu12so6608618vcb.34
        for <git@vger.kernel.org>; Thu, 24 Jul 2014 22:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=DJsx/C7WLA1Uzy4AzyKA+wA+KT17VrLTL7h2rXBubbs=;
        b=RtRkDY5Yh5tGOKjFiDwcbPYAI9+U5xmbxqBm0GGT1/etoZqHcCKK59T9VX6JS8zqHi
         ZS8cMkqJluTYgRecRaZTcWyyqxXUkLakDYciP+c4dhDi7Iw12lPwwIr9/5NaoIKAAwQg
         IiZGYeddHhvQbsPIuXF7sygf1hHfxlLNiOO6pjPtH8kcPb6eBx/JqN6zJsFQp+muRV9r
         upaZjIe7yrUdJVHnLB216fkn37Ac9UhRCaaZ4bvY4szj8Xs+3nFy4a4nRDbmQCdslk+i
         perAI5+CPjxZX/SZgpm0Ia9SRVKtB2Udx1YJtpm8io+LT02je5xke3YORvYiTTH6x748
         qCtw==
X-Received: by 10.221.9.72 with SMTP id ov8mr18251902vcb.27.1406266868575;
 Thu, 24 Jul 2014 22:41:08 -0700 (PDT)
Received: by 10.58.212.71 with HTTP; Thu, 24 Jul 2014 22:40:47 -0700 (PDT)
In-Reply-To: <53D1D90C.5040704@gmail.com>
X-Google-Sender-Auth: WdnVP5EvHjvFNGQRBAQqfwTF_GI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254196>

It is just a shell script yes, and a man page to make things a bit
more discoverable for "git help feature-branch".

The brew command comes from homebrew, a popular OSX package manager.
My platform of choice.

Perhaps I can get support for an easy install for your platform. Do
you think a Makefile that installs to /usr/local/bin and
/usr/local/share/man would fit, or are you on windows?


On 25 July 2014 05:11, Sitaram Chamarty <sitaramc@gmail.com> wrote:
> On 07/25/2014 03:45 AM, Sheldon Els wrote:
>> Hi
>>
>> A small tool I wrote that is useful for some workflows. I thought it'd
>> be worth sharing. https://github.com/sheldon/git-feature-branch/
>
> As far as I can tell it's just a shell script; does it really need
> installation instructions, and if so can they not be more generic than
> "brew install"?  Speaking for myself I have NO clue what that is.
