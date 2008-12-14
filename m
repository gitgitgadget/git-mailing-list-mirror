From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] bash completion: remove deprecated --prune from git-gc
Date: Sun, 14 Dec 2008 03:23:39 -0800 (PST)
Message-ID: <m3hc57dmrl.fsf@localhost.localdomain>
References: <200812132008.08543.markus.heidelberg@web.de>
	<alpine.DEB.1.00.0812141137350.2014@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Heidelberg <markus.heidelberg@web.de>, gitster@pobox.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 14 12:25:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBp5o-0005Y7-La
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 12:25:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272AbYLNLXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 06:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753015AbYLNLXn
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 06:23:43 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:49747 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447AbYLNLXm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 06:23:42 -0500
Received: by ewy10 with SMTP id 10so2517959ewy.13
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 03:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=4jzOCvjA80WzZRGyY7HExhSQWs6iIm4QtCX5ICmEQgM=;
        b=R4ZoDbsqrR8V/2STZnogF5sgbpi5ezk4hN/AFcBeb3vQLLB5cLeAeb2+lY44fGTJmi
         oEUmHdsnzh8TFpjIBXBHEih9NU3uKB+kZFb4ECNFCZysmhaQCYFSmYhKw1sDqA7fWpAT
         wBUSAZw7MUPNbZdmynKkPaO36O6z9rFM0yyZc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=TkiU7kUs5k8lnuQcsbl8AxvIiKL9wH5JIXbAgpDaMSpTTl55HXityUc0bDu/1gIdhl
         9mgHs4e+w+asKONW5XqNOHPZN8kZBx6DbamJv5NrGzqkChfEk+daFNqIXXu0OSxAi5Cb
         2tz8X/CtdwiIGkuFLRNf9Xrtz9b11//L3EFRE=
Received: by 10.210.67.4 with SMTP id p4mr6487897eba.33.1229253820582;
        Sun, 14 Dec 2008 03:23:40 -0800 (PST)
Received: from localhost.localdomain (abxb72.neoplus.adsl.tpnet.pl [83.8.251.72])
        by mx.google.com with ESMTPS id 20sm790155eyk.4.2008.12.14.03.23.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Dec 2008 03:23:39 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBEBN02f015939;
	Sun, 14 Dec 2008 12:23:10 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBEBMcl1015929;
	Sun, 14 Dec 2008 12:22:38 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.DEB.1.00.0812141137350.2014@eeepc-johanness>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103072>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 13 Dec 2008, Markus Heidelberg wrote:
> 
> > -		__gitcomp "--prune --aggressive"
> > +		__gitcomp "--aggressive"
> 
> git gc --prune is deprecated?  That's news to me.

More like "git gc --prune" is no-op now.
 
> How would you suggest, then, to remove the loose objects you always get 
> with conflicts in a merge?

"git gc" does pruning of loose objects, but protected by grace period
for loose objects with gc.pruneexpire

You always have (admittedly lowe level) git-prune.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
