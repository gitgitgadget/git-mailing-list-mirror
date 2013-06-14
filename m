From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] format-patch: remove existing output-directory
Date: Fri, 14 Jun 2013 14:21:02 +0100
Message-ID: <20130614132102.GG23890@serenity.lan>
References: <1371213813-7925-1-git-send-email-artagnon@gmail.com>
 <20130614130910.GF23890@serenity.lan>
 <CALkWK0=dN4oqgvu9FL+EpqyekoQ385tTGbd3Gnf4mee-eTBeOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 15:21:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnTwT-0005v7-0n
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 15:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837Ab3FNNVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 09:21:20 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:47700 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643Ab3FNNVT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 09:21:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id DC3BBCDA5E8;
	Fri, 14 Jun 2013 14:21:18 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zH27k2dE4GCI; Fri, 14 Jun 2013 14:21:18 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 3D6B7CDA5A9;
	Fri, 14 Jun 2013 14:21:17 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 319D1161E418;
	Fri, 14 Jun 2013 14:21:17 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id isBuX+NtmDDy; Fri, 14 Jun 2013 14:21:16 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id A10C3161E477;
	Fri, 14 Jun 2013 14:21:09 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CALkWK0=dN4oqgvu9FL+EpqyekoQ385tTGbd3Gnf4mee-eTBeOA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227830>

On Fri, Jun 14, 2013 at 06:45:19PM +0530, Ramkumar Ramachandra wrote:
> John Keeping wrote:
> > I don't think this is the correct behaviour.  I can think of cases where
> > I would want to output multiple things into the same directory.
> 
> format.cleanOutputDirectory = true|false?

Maybe, but I was thinking of something more like:

    Output directory is not empty, use "--allow-non-empty-dir" if you
    really want to proceed.

Using that configuration variable lets someone shoot themselves in the
foot quite badly if they forget that they have set it and set the output
directory to somewhere containing important data.
