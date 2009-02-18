From: Abhijit Bhopatkar <bain@devslashzero.com>
Subject: Re: [RFC] Common library for Git GUIs
Date: Wed, 18 Feb 2009 11:26:14 +0530
Message-ID: <1234936574.20168.11.camel@bain-laptop>
References: <20090216212459.GA25046@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Jonas Fonseca <fonseca@diku.dk>,
	Marco Costalba <mcostalba@gmail.com>,
	David Aguilar <davvid@gmail.com>,
	Henk <henk_westhuis@hotmail.com>, Frank Li <lznuaa@gmail.com>
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Feb 18 06:58:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZfRt-0008Ck-GL
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 06:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755069AbZBRF42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 00:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755060AbZBRF42
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 00:56:28 -0500
Received: from ti-out-0910.google.com ([209.85.142.188]:7804 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755063AbZBRF41 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 00:56:27 -0500
Received: by ti-out-0910.google.com with SMTP id d10so2285940tib.23
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 21:56:25 -0800 (PST)
Received: by 10.110.73.19 with SMTP id v19mr2841988tia.40.1234936585062;
        Tue, 17 Feb 2009 21:56:25 -0800 (PST)
Received: from ?192.168.1.208? ([59.95.17.232])
        by mx.google.com with ESMTPS id w12sm2594481tib.20.2009.02.17.21.56.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Feb 2009 21:56:24 -0800 (PST)
In-Reply-To: <20090216212459.GA25046@efreet.light.src>
X-Mailer: Evolution 2.24.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Looking at the current situation with Git GUIs, I thought it might be useful
> to create a generic library that would make it easier to develop git guis
> (especially plugins to various tools) and to add a new features to many of
> them with less effort. What do you people think about such idea?
> 
I don't think lack of library is holding this back, all the
functionality is exposed through cli and i find it perfectly fine
interface. ( on teamgit side its lack of devtime :( thats holding it
back) On the other hand a generic Qt/Gtk lib to interface with cli's
would be nice.
In any event i do not plan to switch to a library. Mainly because there
is no value add (barring performance). And of-course, i already worked
so hard to interface with the cli :D.

> Unfortunately in current situation no gui really supports all I would need to
> get my colleagues at work to accept git (they are somewhat obsessed with
> plugin to Visual Studio and explorer and generally avoiding command line).
> I started working on VS plugin some time ago, but I feel like a bit more
> reuse would be in order.
BTW take a look at git extensions for windows, it should provide both,
win ui and VS plugin based on msysgit

> 
> The proposed library should contain:
> 
I think an effort to convert git into libgit+cli is already underway,
unless i missed something very obvious and you are talking about/for the
same effort.

Anyway,
Sorry folks no interest here.

BAIN
