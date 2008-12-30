From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: many git sites homepages megabytes big
Date: Mon, 29 Dec 2008 17:07:27 -0800 (PST)
Message-ID: <m31vvqcvzp.fsf@localhost.localdomain>
References: <87r63r374j.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Tue Dec 30 02:10:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHT7X-0001X3-8S
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 02:10:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751AbYL3BHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 20:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752699AbYL3BHb
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 20:07:31 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:33540 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680AbYL3BHa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 20:07:30 -0500
Received: by ewy10 with SMTP id 10so5276682ewy.13
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 17:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=LWXGzvuZOU1Z+3Q1MTr97806VrAoBjnyBoB0ZduazLw=;
        b=UC8byPiGr5r22BatgxjTRfvpSshds4Mhs/Lobmf18o37eB6dhW8lKU48gC+yespxs0
         NqjzOLHp6f8GllqIsestPyYv/SQkIIXBSeK01LD6UWwRw/sPAeY+ZcsAx87LhWdwYDR4
         vvUSkR7k5emttleDkFOOAOsIsB5zxTBhZ20wY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=vt6vlV8k8pDbUbg6KNRKmkZqi4o4or039h6FxwQBFQ4WsuNLujvR4BHkkAPOi2galB
         BM/OqzBH1XXVicJV3Z7QBSl7g4hl0brsTyU/mWWuAs+x+wW/C5dUqujXDeR2qWs9NJmC
         DK4Lt0unk4m3ypSX5G6Wn8c8zXZIYTPARM7hk=
Received: by 10.210.22.16 with SMTP id 16mr2884454ebv.68.1230599248156;
        Mon, 29 Dec 2008 17:07:28 -0800 (PST)
Received: from localhost.localdomain (abwi200.neoplus.adsl.tpnet.pl [83.8.232.200])
        by mx.google.com with ESMTPS id i7sm32782677nfh.13.2008.12.29.17.07.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Dec 2008 17:07:27 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBU16e2k021790;
	Tue, 30 Dec 2008 02:06:50 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBU16I5M021780;
	Tue, 30 Dec 2008 02:06:18 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <87r63r374j.fsf@jidanni.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104143>

jidanni@jidanni.org writes:

> I notice the web interfaces to many git sites are very risky to just
> click on. E.g., just clicking http://repo.or.cz/ sends megabytes to
> the users browser. At least the homepage of such sites should be
> something lighter in weight.

That is a bit of historical artifact. Currently the "index" page for
gitweb installation is 'projects_list' page with _all_ the projects
hosted. It is not split into pages, like for example 'log' or 'heads'
views are; there were some patches for that, but would have to be
redone as the area changed a bit since. It could have been replaced by
projects search page...

It is a bit of historical reason.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
