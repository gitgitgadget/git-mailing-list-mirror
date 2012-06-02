From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Re: git version statistics
Date: Sat, 02 Jun 2012 16:59:34 +0000
Message-ID: <1338656374-ner-2980@calvin>
References: <20120531114801.GA21367@sigill.intra.peff.net>
	<20120531120018.GA24986@sigill.intra.peff.net>
	<7v396g6t53.fsf@alter.siamese.dyndns.org>
	<20120601090337.GC32340@sigill.intra.peff.net>
	<7vzk8n3x5e.fsf@alter.siamese.dyndns.org>
	<20120602163248.GD15017@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 19:00:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sarge-0001EG-M2
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jun 2012 19:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932737Ab2FBRAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jun 2012 13:00:15 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:62726 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932654Ab2FBRAO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2012 13:00:14 -0400
Received: by wgbdr13 with SMTP id dr13so2831783wgb.1
        for <git@vger.kernel.org>; Sat, 02 Jun 2012 10:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:cc:references:in-reply-to:mime-version:date
         :message-id:content-type;
        bh=OhUGdnGpEfxjwHU2IpzwUBK4Lr1GTuoofuZXPhEoERw=;
        b=swuEiChoKOAiNCW7rVH1SxELvc1/pgf4wtrHMdPAgYxpyUQYumEghKtaKAPlDlcJ+y
         e1qXzVLDDZJB23kfkL66b/49fiNNdrAUZGi3XAYsbd4ErhTdcNmhwJk0lZ/OOeoYYtOL
         fyFaZvkJJDoT5NNbbhkEWM5k0tMtojBr+TD1uM4U7GAD6xVD9BmnGk91VYKsdYy9gtuj
         IHBZ/2A+x6/CWGmtuTYC7HiD+FQO6B17so7UzPda/lnhefDyBzRFUN3p3sXkhIJgj8bp
         KUNExA5u8YyaukFnWh6HJ6pj4MOykrNa5M55tUZQA17QTWpwnPCEVvyYfDFDeQn2qVt8
         Bang==
Received: by 10.216.213.219 with SMTP id a69mr5753799wep.16.1338656411941;
        Sat, 02 Jun 2012 10:00:11 -0700 (PDT)
Received: from calvin.caurea.org (cust.static.46-14-151-191.swisscomdata.ch. [46.14.151.191])
        by mx.google.com with ESMTPS id dg2sm9644116wib.4.2012.06.02.10.00.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 02 Jun 2012 10:00:11 -0700 (PDT)
Received: by calvin.caurea.org (Postfix, from userid 3301)
	id 5767E3E31F1; Sat,  2 Jun 2012 16:59:34 +0000 (UTC)
In-Reply-To: <20120602163248.GD15017@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199051>

On Sat, 02 Jun 2012 12:32:48 -0400, Jeff King <peff@peff.net> wrote:
> On Fri, Jun 01, 2012 at 07:49:17AM -0700, Junio C Hamano wrote:
> 
> > My initial reaction to the patch was a bit of trouble with the word
> > "agent", as we do not call Git acting on behalf of the end user "an
> > agent" in general.

Wikipedia defines User agent as 'a software [...] that is acting on behalf of
a user'. That fits this situation quite well, don't you think?
