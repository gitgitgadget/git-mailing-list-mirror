From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 4/8] git_remote_helpers: use 2to3 if building with
 Python 3
Date: Fri, 18 Jan 2013 10:32:41 +0000
Message-ID: <20130118103241.GM4574@serenity.lan>
References: <cover.1358018078.git.john@keeping.me.uk>
 <cover.1358448207.git.john@keeping.me.uk>
 <bcef80fb913ca829bd2d08284e364ebd55b7297e.1358448207.git.john@keeping.me.uk>
 <CAGdFq_gew1-YmeUh=brWREHSYQvaV7vRBmEo0KFzi-ViqzOnaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git List <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 11:33:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tw9G6-00084n-FM
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 11:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234Ab3ARKcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 05:32:54 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:53130 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111Ab3ARKcx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 05:32:53 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 62E6B198027;
	Fri, 18 Jan 2013 10:32:52 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rfHmwQEwqfki; Fri, 18 Jan 2013 10:32:51 +0000 (GMT)
Received: from aardwolf.aluminati.org (aardwolf.aluminati.org [10.0.7.189])
	by coyote.aluminati.org (Postfix) with ESMTP id 98153198032;
	Fri, 18 Jan 2013 10:32:51 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by aardwolf.aluminati.org (Postfix) with ESMTP id 6C8E8330E46;
	Fri, 18 Jan 2013 10:32:51 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from aardwolf.aluminati.org ([127.0.0.1])
	by localhost (aardwolf.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W7gl91tOQT8L; Fri, 18 Jan 2013 10:32:51 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by aardwolf.aluminati.org (Postfix) with ESMTPSA id C1AA8330E44;
	Fri, 18 Jan 2013 10:32:43 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAGdFq_gew1-YmeUh=brWREHSYQvaV7vRBmEo0KFzi-ViqzOnaw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213910>

On Thu, Jan 17, 2013 at 09:15:08PM -0800, Sverre Rabbelier wrote:
> On Thu, Jan 17, 2013 at 10:53 AM, John Keeping <john@keeping.me.uk> wrote:
> > [1] http://wiki.python.org/moin/PortingPythonToPy3k
> 
> This link seems dead.

Looks like the Python wiki is down [1].

I'll replace it with [2] since the content is similar and it should be
easier to find a mirror of the Python documentation than of the wiki.

[1] http://pyfound.blogspot.co.uk/2013/01/wikipythonorg-compromised.html
[2] http://docs.python.org/3.3/howto/pyporting.html#during-installation


John
