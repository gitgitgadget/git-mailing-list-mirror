From: Matt Di Pasquale <liveloveprosper@gmail.com>
Subject: Re: git multisite setup
Date: Mon, 16 Nov 2009 19:17:03 -0500
Message-ID: <13f0168a0911161617o56757488n45328714fb1d3bea@mail.gmail.com>
References: <13f0168a0911161018r6fc67d29n781cca670a66815b@mail.gmail.com> 
	<20091117001320.GA13074@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Tue Nov 17 01:17:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NABlD-0002gG-4o
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 01:17:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754916AbZKQART (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 19:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754823AbZKQART
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 19:17:19 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:42207 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754629AbZKQARS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 19:17:18 -0500
Received: by bwz27 with SMTP id 27so6298996bwz.21
        for <git@vger.kernel.org>; Mon, 16 Nov 2009 16:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=wiD42ovLWed7zBy5F039zlSYz+KSQDPouMy37R2i3mM=;
        b=jES3LaUVwyK7bJ5/7V1+chLGhqDowJ1d+DTVzH1Ug8G4kjJsqFXw5r+2s9Zoz4vgRT
         6hZ0M+J4ZYi95xf3aCc2VYR8ISAlqF9hKEXEejWtEWJAdNuFYlDLFSMnOo2VvhzxKgEP
         bBqaAS7QV76v+uUqqRuH846WsdwcC7MFVyMig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=W48VqM+FnnA43ceZHeibyxQBrKnYloaKZ68eYQ0xQcJ18fvsOiZCyVmJQeuFipQPN8
         dZVTo7DMysf8pUYelAXaC9O8WNRzuvf6MB6Ucb+yfYl5kc8qLMCY056HTtZGBz257Jua
         4qX900AdAskkNoZQCpYRYRIxJM0Pjjmdh3Nzo=
Received: by 10.216.90.70 with SMTP id d48mr535262wef.159.1258417043139; Mon, 
	16 Nov 2009 16:17:23 -0800 (PST)
In-Reply-To: <20091117001320.GA13074@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133045>

yeah. i guess it's fine. :) just that the specific git repos aren't
coordinated to the generic one. but that's fine so far since i haven't
had to jump around to different commits and the generic has stayed
pretty much the same.

On Mon, Nov 16, 2009 at 7:13 PM, Nicolas Sebrecht <nicolas.s.dev@gmx.fr> wrote:
> The 16/11/09, Matt Di Pasquale wrote:
>
>> In my sites folder i have folders for different sites of mine:
>> example.com example2.com, and i also have generic files like an
>> includes dir and a .htaccess file that all sites use. what is the best
>> way to track the generic files and the different sites?
>>
>> i was thinking each site has its own .git repo. and then make a .git
>> repo for my sites folder but ignore the individual sites dirs.
>> actually that's what i'm doing now.
>
> This looks good to me. Why would you like to change?
>
> --
> Nicolas Sebrecht
>
