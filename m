From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC PATCH 0/2] Add an update=none option for 'loose' submodules
Date: Thu, 09 Jun 2011 20:06:42 +0200
Message-ID: <4DF10BB2.9050500@web.de>
References: <cover.1307374519.git.hvoigt@hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Jun 09 20:07:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUjdF-0002My-MN
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 20:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752247Ab1FISG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 14:06:56 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:54381 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab1FISG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 14:06:56 -0400
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 314AA1920CA09;
	Thu,  9 Jun 2011 20:06:47 +0200 (CEST)
Received: from [217.249.63.251] (helo=[192.168.178.43])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QUjd1-0008PH-00; Thu, 09 Jun 2011 20:06:47 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <cover.1307374519.git.hvoigt@hvoigt.net>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+tHnmeOjrZZt/j89qtSbzs5uto6o6pDgEWGUKc
	Y/cpfoK5TadqfZHvpSgm9ogEyFBMW1GjHlgYHmSNrBGLcJrwpZ
	efiiCsdbDo5bSNvw47mA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175564>

Am 06.06.2011 22:57, schrieb Heiko Voigt:
> If a submodule is used to seperate some bigger parts of a project into
> an optional directory it is helpful to not clone/update them by default.

I think this is a good idea as some people are running "git submodule
update --init --recursive" when they have to update their submodules.
It would be nice to have an option to skip certain submodules then.

> This series implements a new value 'none' for submodule.<name>.update.
> If this option is set a submodule will not be updated or cloned by
> default. If the user wants to work with the submodule he either needs
> to explicitely configure the update option to 'checkout' or pass
> --checkout as an option to the submodules. I chose this name to be
> consistent with the existing --merge/--rebase options.
> 
> What do you think about this approach?

It fits in nicely with my long term plan: Let the "update" flag
control what happens on submodule checkout in the work tree. Another
flag ("init"?) can be added later to control if a submodule should be
initialized on clone or update, but that is outside the scope of this
change.

> If we agree that this is the correct way to approach this use case I
> would proceed to implement tests and documentation.

+1 from me.
