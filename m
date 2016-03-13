From: Christian Couder <christian.couder@gmail.com>
Subject: Draft of Git Rev News edition 13
Date: Sun, 13 Mar 2016 13:38:23 +0100
Message-ID: <CAP8UFD0VKM+D2v1duQoxFczD1BYG1kwW=bFbNuL1wyz=r0aiJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicola Paolucci <npaolucci@atlassian.com>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Shawn Pearce <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Kevin Wern <kevin.m.wern@gmail.com>,
	Sarah Sharp <sarah@thesharps.us>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Stefan Beller <sbeller@google.com>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Bhavik Bavishi <bhavikdbavishi@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Blake Burkhart <bburky@bburky.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	=?UTF-8?B?c2hpcmlzaCDgpLbgpL/gpLDgpYD
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 13 13:38:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1af5I1-0007GN-Rh
	for gcvg-git-2@plane.gmane.org; Sun, 13 Mar 2016 13:38:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753956AbcCMMi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Mar 2016 08:38:27 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:34370 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247AbcCMMi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Mar 2016 08:38:26 -0400
Received: by mail-lb0-f181.google.com with SMTP id xr8so202097529lbb.1
        for <git@vger.kernel.org>; Sun, 13 Mar 2016 05:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=clT+2Z8Fpvr8wBUSmC7fVlyB3gBh+1NJaBaVbWi4jsk=;
        b=hqPoRJVU41zcfT4H4Y1plh8MmJEcdAS1V81ZNyal8l62DT6gtGT6r1vWnK+9tE4CsT
         osjH1P6CJxQmIQnOEJQ4FvHxhO5mCxQ29tIm0zM9WtzzqrfLX3jZ4xianyP+K8H9gamf
         n55D9hrOBXjcn+ay242326cdpGnl/lvVTY+2yHRGG1tQaOKio29xOx2FEmpk5cOkp5Qi
         8F2wz1A+th872GroHhSu6NA4yMNwfXFJo7T4j9APHaWuhkJt8FJCjpVFeLr2NlwROdMm
         Pc7G+itFNKRpUs1xMrpYBF4SZW+rYmAYtQF6NWDcfuPdSjNCx7yiSVOgncGo3xT2WvR8
         2hJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=clT+2Z8Fpvr8wBUSmC7fVlyB3gBh+1NJaBaVbWi4jsk=;
        b=jhDnYYfguFh+CNBiixp4vVlZefzAFlK4Y1CA13gGFDaVYbQ7US8d1vU/z+Me2i6N2O
         S1Dk7XKY8MgsgYgip22usIGv9CmJ0MnxwR9CpGMB9+CGPDa9k034iSneuwGSgCmgMMRd
         lr9/WkQDGPRJbDA9aHr15SnAHwRBgzlnlk0WhWjjeMGMHzCNKgeB7sCdDTwrEshqXwmS
         G6m20Pj+1i+nXphi5ScXjiBVJtLrAMYTZOvQRKl+TgK4dDBGVte3M11vlxOqPYiEw3YJ
         WiKKJ/LJ7rkJFVsiw/FmLHKJjq9STLvSWaHbNc9T6dUESGKC9/MNpgm5Oj02A8KK475z
         /rsQ==
X-Gm-Message-State: AD7BkJJtDDa7KAcQYcFHfvGvNjIFvPxnfhOoID2MrRCjtKnUr6BodiOKpSr4dg0mEC5u9FJ8Yn+j87COYtIccA==
X-Received: by 10.25.168.138 with SMTP id r132mr4807158lfe.77.1457872704029;
 Sun, 13 Mar 2016 05:38:24 -0700 (PDT)
Received: by 10.25.137.130 with HTTP; Sun, 13 Mar 2016 05:38:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288751>

Hi,

A draft of Git Rev News edition 13 is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-13.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/121

You can also reply to this email.

I tried to cc everyone who appears in this edition but maybe I missed
some people, sorry about that.

Thomas, Nicola and myself plan to publish this edition on Wednesday
the 16th of March.

Thanks,
Christian.
