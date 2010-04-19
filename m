From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Compilation pb of git-1.7.0.5
Date: Mon, 19 Apr 2010 10:37:18 +0200
Message-ID: <4BCC163E.3050808@drmicha.warpmail.net>
References: <201004190759.15032.yves.caniou@ens-lyon.fr> <i2kfabb9a1e1004182326w32b1ce9ak2ada640ce30cc945@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: yves.caniou@ens-lyon.fr, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 19 10:40:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3mWr-0001wW-Jr
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 10:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281Ab0DSIkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 04:40:22 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:45483 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751382Ab0DSIkV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Apr 2010 04:40:21 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6032BEB78C;
	Mon, 19 Apr 2010 04:40:21 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 19 Apr 2010 04:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=ER97bz/DOHiUSZc8zOkjaYS9HHk=; b=MjxI1XHITff0lxSJfO5Vgh0K1n+XudTp8TIq/Ad0d0KBHTobAWM6KLY7d4/IRbwuToxzRjz+LF4YkbWdygRvIvLjjEn8MEPsCq8VE0h/K+2tGgxFaWw3lj7bwNuRb3kLZkrny2TfsBxjzRb/VU/X83jUQpVcBEV7YtjH/Fyr1Qs=
X-Sasl-enc: GEWvTFnrDiJeVhhAYhxRTh/i/86XA8SKtgEXhxv5x3ly 1271666421
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B1C0E4CF7E1;
	Mon, 19 Apr 2010 04:40:20 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100414 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <i2kfabb9a1e1004182326w32b1ce9ak2ada640ce30cc945@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145280>

Sverre Rabbelier venit, vidit, dixit 19.04.2010 08:26:
> Heya,
> 
> On Mon, Apr 19, 2010 at 07:59, Yves Caniou <yves.caniou@ens-lyon.fr> wrote:
>> After the ./configure --prefix=$HOME/git, the make all gives me
> 
> Which revision are you trying to compile? Also, it's probably more
> helpful to just post the result of 'make all' verbatim, rather than
> snippets.

...and try to use make directly rather than configure, which isn't
maintained that well.

I wonder whether we should hide configure somehow. If you see a Makefile
and configure and don't know the project, the natural impulse is to use
configure before make.

Michael
