From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Ensimag students contributing to git
Date: Tue, 19 May 2015 17:39:13 +0200
Message-ID: <CAP8UFD2WbvHZN4vtRt3o+sYTcoBhPuW=7Dhta1XjHOoEGDxvgw@mail.gmail.com>
References: <722582475.919095.1431991277969.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<388720318.919104.1431991388837.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<CAGZ79kZF2Ne8vLTof_hq+UL3_U2GPeExqk7qjEQ=yFb6eQkyqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Paul Tan <pyokagan@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Alexandre Stuber <stuberl@ensimag.grenoble-inp.fr>,
	galanalr@ensimag.grenoble-inp.fr, lespiner@ensimag.grenoble-inp.fr,
	pagesg@ensimag.grenoble-inp.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 19 17:39:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yujc2-0004le-0m
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 17:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbbESPjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 11:39:17 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:32883 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852AbbESPjO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 11:39:14 -0400
Received: by wgjc11 with SMTP id c11so22747886wgj.0
        for <git@vger.kernel.org>; Tue, 19 May 2015 08:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=uD8uH98ieBrYJljzEcASfZvkiR4prsY9gmmncxJZNHw=;
        b=Csv/pdvh1INQmAWFcdRtA+ELbUdPT/VDtIoHMQXht4GBtrsj4YRsooapXKxxNZ75Ea
         IU9ktlk8dZrz72WTrcXnywifEfHWMhpMoHZXKI7qX28MdPe0/AnnbuoH97kB8kW1JVG9
         9/y2ciTMtbg3Z+5c27o5+D8DMDI4jKuvDdh2tPkI3TRNXrdH3HP0Jblh3vCj8b3M6wuc
         2mMe8uoDQFQl8TR60riv7Qrx+ddiF8nNG+OvrzosStf5G/amIG6cpf5zhzESfTwpETbq
         Fo+O3c35p7CNd1I+qqa3U2MEuhAwY3OscL0tWbk3KIGbpXH3nld3j6njV6KXrR1cNuAu
         40ag==
X-Received: by 10.180.105.38 with SMTP id gj6mr7150483wib.90.1432049953462;
 Tue, 19 May 2015 08:39:13 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Tue, 19 May 2015 08:39:13 -0700 (PDT)
In-Reply-To: <CAGZ79kZF2Ne8vLTof_hq+UL3_U2GPeExqk7qjEQ=yFb6eQkyqA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269362>

On Tue, May 19, 2015 at 2:50 AM, Stefan Beller <sbeller@google.com> wrote:
>
> git bisect fix/unfixed sounds interesting though (just
> today I tried to find a fix and messed up, again). I am
> not aware of the scope you're planning to contribute
> to within the git bisect fix/unfixed topic, though I'd like
> to share a result[2] of a discussion we had some time
> ago, on how git bisect can be improved (nobody did it
> yet though).
>
> [2] https://docs.google.com/document/d/1hzF8fZbsQtKwUPH60dsEwVZM2wmESFq713SeAsg_hkc/edit?usp=sharing

It's interesting, but the document doesn't really explain what is not
optimal with the current algorithm and why the proposed algorithm is
better.

Thanks,
Christian.
