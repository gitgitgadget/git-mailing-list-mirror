From: Heiko Voigt <git-list@hvoigt.net>
Subject: Re: [RFC PATCH] hooks: add some defaults to support sane workflow
 to pre-commit
Date: Sat, 21 Feb 2009 15:30:24 +0100
Message-ID: <49A01000.2000308@hvoigt.net>
References: <499EF2B6.7060103@hvoigt.net>	<C95EAEB9-D520-497F-BA42-0CDCC1348340@wincent.com>	<499FDDC2.90502@hvoigt.net> <200902211216.43964.trast@student.ethz.ch>	<49A00215.9070106@hvoigt.net> <m3k57jsx36.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 15:37:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lasz5-0005sb-UW
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 15:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753062AbZBUOa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 09:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753043AbZBUOa3
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 09:30:29 -0500
Received: from darksea.de ([83.133.111.250]:39250 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753002AbZBUOa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 09:30:28 -0500
Received: (qmail 5920 invoked from network); 21 Feb 2009 15:30:16 +0100
Received: from unknown (HELO macbook.lan) (127.0.0.1)
  by localhost with SMTP; 21 Feb 2009 15:30:16 +0100
User-Agent: Thunderbird 2.0.0.19 (Macintosh/20081209)
In-Reply-To: <m3k57jsx36.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110955>

Jakub Narebski schrieb:
> Heiko Voigt <git-list@hvoigt.net> writes:
>> Implement the possibility to propagate this setting to the server, by
>> using a config variable or similar. This way only secure hooks will
>> automatically be inherited and the user has the benefit of a more
>> specific workflow support.
> 
> Well, for an _installation_ of git you _have_ possibility to provide
> hooks different than default ones, and that is via templates system.
> With "git init" in already existing repository you would be able to
> pick up new version of hooks.

Should this decision really be on an installation basis? Would basing
this decision on a project not be a better reflection of the reality? 

I have read some threads dealing with what a good book about git should
contain. In these threads the keyword workflows was brought up quite
often. So maybe it would also be good to support this topic a little
more from the software side.

cheers Heiko
