From: Kalle Olavi Niemitalo <kon@iki.fi>
Subject: Re: How to supply "raw" bytes to git grep?
Date: Fri, 19 Sep 2008 01:07:56 +0300
Message-ID: <871vzhglab.fsf@Astalo.kon.iki.fi>
References: <200809181728.18597.johan@herland.net>
	<8c9a060809180846j25e4eb44h291b017aa01bbe36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 19 00:52:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgSM2-0000K7-Nl
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 00:52:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755234AbYIRWu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 18:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755161AbYIRWu6
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 18:50:58 -0400
Received: from 85-23-32-64-Rajakyla-TR1.suomi.net ([85.23.32.64]:32943 "EHLO
	Astalo.kon.iki.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753368AbYIRWu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 18:50:58 -0400
X-Greylist: delayed 2914 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Sep 2008 18:50:58 EDT
Received: from Kalle by Astalo.kon.iki.fi with local (Exim 4.52)
	id 1KgRfI-0002NW-K9; Fri, 19 Sep 2008 01:07:56 +0300
In-Reply-To: <8c9a060809180846j25e4eb44h291b017aa01bbe36@mail.gmail.com>
	(Jacob Helwig's message of "Thu, 18 Sep 2008 08:46:49 -0700")
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/23.0.51 (gnu/linux)
X-Accept-Language: fi;q=1.0, en;q=0.9, sv;q=0.5, de;q=0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96251>

"Jacob Helwig" <jacob.helwig@gmail.com> writes:

> Inserting a literal carriage return seems to do the trick for me, in bash.
>
> git grep --cached -I -l -e <Ctrl-V><Ctrl-M>

In bash, $'\r' works too, and may be nicer to edit.
Better not use that with #! /bin/sh though.
