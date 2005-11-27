From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH 7/9] Add the accurate changeset applyer
Date: Sun, 27 Nov 2005 04:24:55 +0000
Message-ID: <46a038f90511262024g4eca7dc2oa42d1f72febf9e27@mail.gmail.com>
References: <20051112092336.GA16218@Muzzle>
	 <46a038f90511170126l5f04f4e0ta578fc2cb375db68@mail.gmail.com>
	 <20051124074605.GA4789@mail.yhbt.net>
	 <20051124074739.GB4789@mail.yhbt.net>
	 <20051124074857.GC4789@mail.yhbt.net>
	 <20051124075027.GD4789@mail.yhbt.net>
	 <20051124075133.GE4789@mail.yhbt.net>
	 <20051124075243.GF4789@mail.yhbt.net>
	 <20051124075355.GG4789@mail.yhbt.net>
	 <20051124075504.GH4789@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git list <git@vger.kernel.org>,
	Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sun Nov 27 05:25:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgE5z-00056Y-RV
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 05:25:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbVK0EY4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Nov 2005 23:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbVK0EY4
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Nov 2005 23:24:56 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:16559 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750847AbVK0EYz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Nov 2005 23:24:55 -0500
Received: by zproxy.gmail.com with SMTP id 40so199975nzk
        for <git@vger.kernel.org>; Sat, 26 Nov 2005 20:24:55 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eBN5aRUIEiCPuENSVSLn9m3qvOgZ9npkUfdFv0AkDWpOlTCGQdeWAOI0E+q9tZhdAI/XxYRB9InIdTNmQDferoBjia9eomKsb/34hKrPbc1NOTXT3xpcjmQ9rcb1hIsO4NiXl7q/j2/yy2OP/esDLeduVthyoWxcCDoH7D6NYdk=
Received: by 10.65.15.10 with SMTP id s10mr1317519qbi;
        Sat, 26 Nov 2005 20:24:55 -0800 (PST)
Received: by 10.64.242.12 with HTTP; Sat, 26 Nov 2005 20:24:55 -0800 (PST)
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20051124075504.GH4789@mail.yhbt.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12797>

On 11/24/05, Eric Wong <normalperson@yhbt.net> wrote:
> And make it the default.

Cheeky, but right ;-)

Would it be a good idea to read the log entry and decide what kind of
smarts do we need to apply the changeset? If the log entry looks
plain, use process_patchset_fast(), else invoke $TLA?

cheers,


martin
