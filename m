From: Michael Olson <mwolson@gnu.org>
Subject: Re: [PATCH/RFC] git-svn: Allow multiple branch and tag patterns
Date: Tue, 23 Feb 2010 06:41:23 -0800
Message-ID: <c8b3bef91002230641u3f831470m2b887e9479ca6cb2@mail.gmail.com>
References: <c8b3bef91002221429l3b277429l56f4e4cac4fdeb43@mail.gmail.com> 
	<4B83B303.50408@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Feb 23 15:42:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njvxa-0007B6-Eg
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 15:42:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977Ab0BWOlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 09:41:47 -0500
Received: from mail-pz0-f174.google.com ([209.85.222.174]:56447 "EHLO
	mail-pz0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524Ab0BWOlq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 09:41:46 -0500
X-Greylist: delayed 58311 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Feb 2010 09:41:46 EST
Received: by pzk4 with SMTP id 4so597978pzk.21
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 06:41:46 -0800 (PST)
Received: by 10.142.65.22 with SMTP id n22mr10063614wfa.113.1266936105040; 
	Tue, 23 Feb 2010 06:41:45 -0800 (PST)
X-Originating-IP: [99.66.24.246]
In-Reply-To: <4B83B303.50408@drmicha.warpmail.net>
X-Google-Sender-Auth: b37b0b9c6e833a5d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140802>

> I'm sorry, but we have this (multiple branch/tag lines) since 1.6.4, see
>
> 6224406 (git svn: Support multiple branch and tag paths in the svn
> repository., 2009-06-23)

Neat, that definitely does what I want.

> The skip directive may be obsoleted by
>
> 0757620 (git-svn: allow subset of branches/tags to be specified in glob
> spec, 2010-01-23)

This, not as much, since I want to be able to exclude a specific
pattern rather than include specific patterns.  I'll have to try out a
newer git version to see if that workaround is still needed for my
(admittedly bizarre) setup.

-- 
Michael Olson  |  http://mwolson.org/
