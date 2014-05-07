From: John Keeping <john@keeping.me.uk>
Subject: Re: What's cooking in git.git (Apr 2014, #09; Tue, 29)
Date: Wed, 7 May 2014 21:44:20 +0100
Message-ID: <20140507204420.GB9035@serenity.lan>
References: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com>
 <20140505184546.GB23935@serenity.lan>
 <xmqqd2fqcv7s.fsf@gitster.dls.corp.google.com>
 <20140507080558.GH23935@serenity.lan>
 <xmqqvbtha04t.fsf@gitster.dls.corp.google.com>
 <536a96e762dc4_76ff7a52ec44@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 22:44:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi8hj-0008Bv-40
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 22:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbaEGUof (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 16:44:35 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:42670 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbaEGUoe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 16:44:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 029CA866020;
	Wed,  7 May 2014 21:44:34 +0100 (BST)
X-Quarantine-ID: <j92fnYoVX5zO>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j92fnYoVX5zO; Wed,  7 May 2014 21:44:33 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 3BCA786600E;
	Wed,  7 May 2014 21:44:29 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 2B0B5161E399;
	Wed,  7 May 2014 21:44:29 +0100 (BST)
X-Quarantine-ID: <3KCZdNGBEq2n>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3KCZdNGBEq2n; Wed,  7 May 2014 21:44:28 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id E5FD3161E358;
	Wed,  7 May 2014 21:44:22 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <536a96e762dc4_76ff7a52ec44@nysa.notmuch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248365>

On Wed, May 07, 2014 at 03:26:15PM -0500, Felipe Contreras wrote:
> Junio C Hamano wrote:
> > Your git-integrate might turn into something I could augment my
> > workflow with with some additions.
> > 
> >  - specifying a merge strategy per branch being merged;
> 
> git-reintegrate[1] supports this.
> 
> >  - support evil merges or picking a fix-up commit;
> 
> git-reintegrate supports this.
> 
> >  - leaving an empty commit only to leave comment in the history.
> 
> Done[2].
> 
> 
> > and until that happens, I'll keep using the Reintegrate script found
> > in my 'todo' branch.
> 
> My git-reintegrate supports everything John's git-integrate and in
> addition it supports generating the commands from an existing branch,
> like your Reintegrate. IOW; it's superior.

And yet the documentation is unchanged from the version you copied in
from git-integration.  Personally I would much rather use a project
which takes time to document all of the features rather than relying on
reading the code to figure out the options.

More features does not make a project superior.
