From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Draft of Git Rev News edition 5
Date: Sun, 5 Jul 2015 19:12:40 -0400
Message-ID: <CAPig+cRv6g_nAEdGtrESFiE+5+OxEHwjhEPX0Q0WL+eHzkCAGA@mail.gmail.com>
References: <CAP8UFD2fpRiOmgL9GW-1N9ZLAY+p-nOSH-b57vJFO4e_tELrWw@mail.gmail.com>
	<20150705191101.GB9815@flurp.local>
	<CAP8UFD3pD_6_SrrtCWywA8x5XY_SD3bed=QhZBBrTq0zQvqFPw@mail.gmail.com>
	<CAPig+cTpy32c13Sv=m49hzqOBisZ0v07AT0X5BYNB07acrcW8w@mail.gmail.com>
	<CAEcj5uXiGVvLm==s_SB7GnvBfuKi7j4yH+fgNq4JZtkvK7pZwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Nicola Paolucci <npaolucci@atlassian.com>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>,
	Eric Raible <raible@nextest.com>,
	Emma Jane Hogbin Westby <emma@emmajane.net>,
	Max Kirillov <max@max630.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	karthik nayak <karthik.188@gmail.com>,
	Paul Tan <pyokagan@gmai
To: Thomas Ferris Nicolaisen <tfnico@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 01:12:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBt5a-0006dT-MW
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 01:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117AbbGEXMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2015 19:12:43 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:36700 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923AbbGEXMl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2015 19:12:41 -0400
Received: by ykdr198 with SMTP id r198so134073310ykd.3
        for <git@vger.kernel.org>; Sun, 05 Jul 2015 16:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ML7degdX8yWNG6rOhNPcnN5QXjruUsRXlQQorehxVxE=;
        b=NCCl4pMi9RooI9/06C4bagfa50Q8B6a8NUGx1JSBmoaD8wYib2qLqnVBnLdyp8oi7O
         Q6o0tBwMFfdqcU2VLeIoG2Uaxa5f5w+kcCd6dA9efUSg8mqn+oqbKELU/OVJXr/Cxq1I
         39f0Iv2WCik50QKpid5psxhKudQA6rBkCWQr/ul+AVJZGnNkkD74LzxSk4pyBXdvfWnC
         V0tACmFR9bPJoF2JQotFWNz4M7Ekj2hiIVI9riIKp7LGjonpCYhcjpH5ZoxnKGGFiNCF
         Q0mVVBT0yeHidyX5zU743zdJ/UvAVKCh/6GJWa1QrlNA1C165L56qFHzjxWVXgA8sGgg
         8yDA==
X-Received: by 10.170.97.9 with SMTP id o9mr55856699yka.84.1436137960942; Sun,
 05 Jul 2015 16:12:40 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sun, 5 Jul 2015 16:12:40 -0700 (PDT)
In-Reply-To: <CAEcj5uXiGVvLm==s_SB7GnvBfuKi7j4yH+fgNq4JZtkvK7pZwg@mail.gmail.com>
X-Google-Sender-Auth: Mqpoj459z0UfMwc4uQ6QoP89pHU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273375>

On Sun, Jul 5, 2015 at 6:35 PM, Thomas Ferris Nicolaisen
<tfnico@gmail.com> wrote:
> On Mon, Jul 6, 2015 at 12:01 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> Unfortunately, the non-ASCII characters
>> in Duy's name got corrupted, and the botch is present in the patch I
>> sent. Sorry. Not sure how that happened. Can you fix it locally?
>
> Fixed [1].
>
> [1] https://github.com/git/git.github.io/commit/b5f7d6523ca6a634d568fc9017135ff2a9ea6462

Thanks.
