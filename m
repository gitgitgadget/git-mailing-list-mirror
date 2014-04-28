From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [PATCH] Sleep 1 millisecond in poll() to avoid busy wait
Date: Mon, 28 Apr 2014 13:38:15 +0200
Organization: <)><
Message-ID: <20140428113815.GA10559@camelia.ucw.cz>
References: <20140428083931.GA10257@camelia.ucw.cz> <CABPQNSaC30p7TEOvc85u=+skjrFj17182vWWSL=QNVuvzVFE=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	theoleblond <theodore.leblond@gmail.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 13:38:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wejt8-00057U-Q8
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 13:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754128AbaD1LiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 07:38:18 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:51973 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754106AbaD1LiR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 07:38:17 -0400
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 07E621C0093;
	Mon, 28 Apr 2014 13:38:16 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s3SBcFDG011172;
	Mon, 28 Apr 2014 13:38:15 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s3SBcFeU011171;
	Mon, 28 Apr 2014 13:38:15 +0200
Content-Disposition: inline
In-Reply-To: <CABPQNSaC30p7TEOvc85u=+skjrFj17182vWWSL=QNVuvzVFE=w@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247301>

Hello,

On Mon, Apr 28, 2014 at 11:07:24AM +0200, Erik Faye-Lund wrote:
> compat/poll/poll.c comes from Gnulib, so it would be better to submit
> the patch there and update.

well, the change is in gnulib since 2012-05-21.
But the two versions has diverged a lot.
Could you please just accept a backport of this one patch?
I would be glad if msysgit could drop this patch.

Updated patch follows.

Stepan
