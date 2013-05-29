From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [git-users] Highlevel (but simple to implement) commands provided
 by default for git
Date: Thu, 30 May 2013 01:57:54 +0530
Message-ID: <CALkWK0mBOB1RM+MXH+Nvos29M5vqc2yAtC__zPyowf7imfnz9Q@mail.gmail.com>
References: <f611150e-a12a-47f6-97f0-8aaff3045338@googlegroups.com>
 <CAJri6_tm=tk6L1DT=A_BB25jm7b+2Uniw1uSCGtrY5_8X=t_hw@mail.gmail.com> <CAMP44s0Cx-FCZLOFZxcpC86sY+H03HKBi0nKFMgit=B5XCy71g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Br=C3=A1ulio_Bhavamitra?= <brauliobo@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 22:28:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhmzK-0005Hy-36
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 22:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966767Ab3E2U2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 16:28:36 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:56708 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966427Ab3E2U2e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 16:28:34 -0400
Received: by mail-ie0-f175.google.com with SMTP id tp5so9577207ieb.34
        for <git@vger.kernel.org>; Wed, 29 May 2013 13:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kkyIFJowpHtfwrYJj9lt1UvJEuBDnIZi+OD3kmQbfDg=;
        b=vTRlgNjpPZQFBHkqRnaSrlD96tHqbFKZQa13ewf0KOrkduiItDIWTcoJ8ozoAXJg2E
         jxQ16o1/SgbU+C/1wPxHdklbLFc1D/P+QoMibzGrWliWomXco90GiUMN66eDTkT9iaTH
         8b+nFqxk1Fqvp9vJbuWhdBNfucb0OHE+ak7OpxONnL79b2J36Z5RMhNoPbHoPppbiA2f
         ilshHmXQdTqKCv72kRWJ6kqbz+/ZOSCuT+eJ7IyzFxi49kSw7gbuWHjM22g6KXhllyhk
         XEOo8aRq82QIaXHc65GvF/ud3gn3+xppSs42ni2/HUbG4hYUaNLk7dqrFrV9WrjBO5Nx
         4jcw==
X-Received: by 10.42.76.132 with SMTP id e4mr1878903ick.11.1369859314344; Wed,
 29 May 2013 13:28:34 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Wed, 29 May 2013 13:27:54 -0700 (PDT)
In-Reply-To: <CAMP44s0Cx-FCZLOFZxcpC86sY+H03HKBi0nKFMgit=B5XCy71g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225886>

Felipe Contreras wrote:
> We should probably also add typical shortucts:
>
> d = diff
> l = log
> f = fetch
> p = push
> r = reset
> ci = commit
> rb = rebase
> co = checkout
> st = status
> pi = cherry-pick
> mt = mergetool

Terrible idea.  We'll be eating up more subcommands that the user
cannot override.  I'm already unhappy with am not having been called
apply-mailbox, because I want am to mean am -3 -c (too lazy to write
those configuration variables).
