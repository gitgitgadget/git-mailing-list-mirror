From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] docs: convert "concept" manpages to git-*
Date: Fri, 1 Feb 2013 11:25:59 -0800
Message-ID: <20130201192559.GB12368@google.com>
References: <20130201082538.GA25674@sigill.intra.peff.net>
 <20130201082744.GB25783@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Max Horn <max@quendi.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 01 20:26:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1MFo-0008PK-LX
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 20:26:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756914Ab3BAT0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 14:26:06 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:56793 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921Ab3BAT0E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 14:26:04 -0500
Received: by mail-pa0-f53.google.com with SMTP id bg4so2391810pad.40
        for <git@vger.kernel.org>; Fri, 01 Feb 2013 11:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ZV/LhCnFrmrDyVKoJzJA5Z6xS9GKeHav49SsJiOxzqE=;
        b=CzrULvxn2LOUXJFEy148Hmoh7RUN7JhWP1XToLKIiz1cdSe5gYy0mkHnJj2z+rVNBc
         1qYNbHiiPyeiu+NKhvaMV1vVucpXqS/P6cEC0MUa1cxJeMzfpjZgzpMJMg5VAS3QO4Bo
         sk7AruI+oqLfdngIOfoxwsK5jH6QWoBU0sAJAdnxV0qpuVzrrmZxjouKj/9TBz3o/Kw0
         Iq8YznJ0TbCmHO8OUIgc25QD9Ev5vkzuwNAaRR0LdGp74VaDRnPAkn9wzIIetk2BP5Qr
         D6INEYf4CtHgVjf1IBD9dWc7K3+NfvQMGJYF4v+WpCDKwrpJtt9uXX83AvMEBnYWO0eV
         riXg==
X-Received: by 10.68.217.98 with SMTP id ox2mr35115903pbc.96.1359746763679;
        Fri, 01 Feb 2013 11:26:03 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id ux4sm9259293pbc.25.2013.02.01.11.26.01
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 01 Feb 2013 11:26:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130201082744.GB25783@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215255>

Jeff King wrote:

> Let's just call everything git-*, which is simpler. This
> patch renames the documentation files, updates the Makefile
> to find them, and updates internal linkgit references to the
> pages. It updates builtin/help.c so that users of "git help
> foo" will not even notice the difference.
>
> Users of external html links, or users who have trained
> their fingers to type "man gitfoo" will notice the missing
> pages. This patch does not install a "this page has moved"
> placeholder, but that can easily be done on top.

Thanks for writing this.

I think this one should wait until someone (perhaps me) takes care of
the redirects.  Ideally in addition to simple "this place has moved"
HTML placeholders and manpages using the .so macro, a makefile target
to generate redirect directives for your apache configuration might
make sense.

In the meantime, having "man gitrepository-layout" is not the worst
wart in the world.

Cheers,
Jonathan
