From: Peter Vojtek <peter.vojtek@gmail.com>
Subject: Re: Is there way to set git commit --date to be older than 1970 ?
Date: Wed, 29 Oct 2014 20:50:16 +0100
Message-ID: <CAOE_JxJ5fUmSTcb4VF+K=y8gej2GqzQJrimt8fVn=gUL6veyqg@mail.gmail.com>
References: <CAOE_JxJp0nA_p_42yOyk_nMjsyMaovj0Fx6AJ5nywiEQfB5XAQ@mail.gmail.com>
 <20141029191914.GA16599@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 20:50:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjZGU-0007yg-Dk
	for gcvg-git-2@plane.gmane.org; Wed, 29 Oct 2014 20:50:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755465AbaJ2Tui convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Oct 2014 15:50:38 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:54178 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbaJ2Tui convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Oct 2014 15:50:38 -0400
Received: by mail-ie0-f177.google.com with SMTP id tp5so3619310ieb.8
        for <git@vger.kernel.org>; Wed, 29 Oct 2014 12:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=WUISPNq3+rhOVHvY3/72lE3ZRdzWLrmHIJjY3CgIVDc=;
        b=zaUTaS20TU0J+XMNQYMDCknKZWbXPPhifeCK0LEnFBdxdaMxp2zc2bJOKkJCkchMbe
         Bks27kucDPMeHWZ4UHhREhvP5iwAXTSQeNx44+tTlHUOC2PIXKDsczg1vbSGZiUH7rrr
         3nqcRVpVwq3UPu6qJrX9DZa5fx5BptiZH4VsM/bHrq48OCq0f/gfaCT5pmV98gY8Ci7y
         VHq+p/a4Sc6uVppyVKqCPVlO6DSx7BZOaO7f33RPn7Rl4RELyluXQFOLb0UePjXkBLaC
         GzxxdVR+a7v20iRLdWgqS45BtmqGx6WHzSThe/Ruiho2WjwfMBjczu6NqGTfkIvGAZUq
         TnFA==
X-Received: by 10.107.30.136 with SMTP id e130mr7896358ioe.9.1414612237454;
 Wed, 29 Oct 2014 12:50:37 -0700 (PDT)
Received: by 10.50.207.3 with HTTP; Wed, 29 Oct 2014 12:50:16 -0700 (PDT)
In-Reply-To: <20141029191914.GA16599@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

thanks for quick response, Fredrik.

> I'm curious, why did you choose git for this? Maybe this is a use cas=
e
we should consider?

this is a part of "thinking out of the box" mental execise.

With the advent of many tools to visualize and analyze git
repositories, it makes some sense to use the underlying beauty and
power of git for unusual use cases. Similar evolution happened to
javascript (originally a simple language to apply form validations on
browser side).

Here are few other use cases which may be fun to realize with git:

- history of political parties in one country. when a party splits
into two, we create new branch, and when parties join, we merge
branches. branch name =3D party name. commiter name =3D party leader.

- how country populations evolve year by year. country is a file,
bytesize equals to its population.

- track evolution of some political document (e.g., u.s. constitution).



Peter


On Wed, Oct 29, 2014 at 8:19 PM, Fredrik Gustafsson <iveqy@iveqy.com> w=
rote:
> On Wed, Oct 29, 2014 at 07:49:19PM +0100, Peter Vojtek wrote:
>> I am playing with git in slightly unusual manner - e.g., to use git =
to
>> store history of europe:
>
> Actually you're the second person I hear that is trying to use git as=
 a
> timeline of some sort. The previous person had the exact same problem=
=2E
> Unfortunately I couldn't find a mailthread about it in the archives.
>
> I'm curious, why did you choose git for this? Maybe this is a use cas=
e
> we should consider?
>
> --
> Med v=C3=A4nlig h=C3=A4lsning
> Fredrik Gustafsson
>
> tel: 0733-608274
> e-post: iveqy@iveqy.com
