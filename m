From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: timestamps not git-cloned
Date: Mon, 01 Dec 2008 03:44:37 -0800 (PST)
Message-ID: <m3tz9oi0im.fsf@localhost.localdomain>
References: <200811291117.01655.trast@student.ethz.ch>
	<87k5am3uom.fsf@jidanni.org> <4933A9B1.3070904@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jidanni@jidanni.org, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Dec 01 12:46:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L77Dx-0001Ov-UT
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 12:45:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbYLALol (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 06:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752132AbYLALol
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 06:44:41 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:38157 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666AbYLALok (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 06:44:40 -0500
Received: by ey-out-2122.google.com with SMTP id 6so1021721eyi.37
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 03:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=FFWvqFiKtJwIUyrENzrNmLC4ST23exrj8Fp0ln5tbjk=;
        b=aZ7Cj1i0ppnZfiUzSI9D9/vFnlk6ZAC2xUC93EkCe5H+mwE8C+FKjxboJCbZlfCU7Z
         LK4esrHgcWFil2Qe8QmklQT4FiSvoD1GvRpwJ33E08Z7pD6VxpMLaPTGQMC1t/VlJnYv
         FVANQVKT4oEHXjosThZGazsY669gCTMHdHk5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=nN41WlEkiBtUE7EUPT659E5CwM6hYjubM8koTFVxmz05XY6RvRyxxA1cAp83uMS8zh
         Jje0vbQvMyrxxts1BZB82bB2HsFWjXmu+b7b1FoFG4I1n4xeLSDYxtOhdurO8fP2lo9N
         GqzBaCMmiZmIItTZ8vrct7tDFWnUJj+57Bvjo=
Received: by 10.210.70.14 with SMTP id s14mr7145096eba.94.1228131878535;
        Mon, 01 Dec 2008 03:44:38 -0800 (PST)
Received: from localhost.localdomain (abwt156.neoplus.adsl.tpnet.pl [83.8.243.156])
        by mx.google.com with ESMTPS id 20sm1512061eyk.29.2008.12.01.03.44.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Dec 2008 03:44:37 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mB1Bhk0w008693;
	Mon, 1 Dec 2008 12:43:57 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mB1BhTi2008689;
	Mon, 1 Dec 2008 12:43:29 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4933A9B1.3070904@op5.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102022>

Andreas Ericsson <ae@op5.se> writes:

> I see a lot of ranting but no patches from you. Since you're the one
> with the itch, why not just submit a patch and see if distro packagers
> start using it?
> 
> Some words of advice though; Make it optional, or it'll be dropped on
> the floor. For bonus points, make it calculate timestamps only for a
> path-spec delimited set of files. That'll cut down expected runtime
> by a *huge* amount for something like the linux kernel.

I think the old idea of 'tree blame' (search archives) would be a good
interface for this feature... if you decide to write it.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
