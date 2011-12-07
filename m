From: Sebastian Morr <sebastian@morr.cc>
Subject: Re: Yo dawg, I heard you like trees...
Date: Wed, 7 Dec 2011 16:54:11 +0100
Message-ID: <20111207155411.GB2003@thinkpad>
References: <20111205235740.GB27318@thinkpad>
 <CABURp0rBkGtGfU=od2XeuhD6otUWUfL2ASqo1XBckra18WKy7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 16:54:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYJp6-0005Qs-6N
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 16:54:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756506Ab1LGPyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 10:54:15 -0500
Received: from static.148.34.47.78.clients.your-server.de ([78.47.34.148]:38802
	"EHLO morr.cc" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756152Ab1LGPyP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 10:54:15 -0500
Received: by morr.cc (Postfix, from userid 1001)
	id 4423D476231F; Wed,  7 Dec 2011 16:54:13 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on morr.cc
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED
	autolearn=unavailable version=3.3.1
Received: from thinkpad (w0772.wlan.rz.tu-bs.de [134.169.203.10])
	by morr.cc (Postfix) with ESMTPSA id D50DE476231C;
	Wed,  7 Dec 2011 16:54:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CABURp0rBkGtGfU=od2XeuhD6otUWUfL2ASqo1XBckra18WKy7w@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186467>

> Git uses a DAG. The A stands for "acyclic". Loops are not allowed.

I'm aware of that. It's acyclic by design, but is this actually enforced
by the code? Or does it simply trust that no loops will ever occur,
because it's so improbable?

After Andrew's response I investigated a bit, and it seems I
overvalued the attempts to "break" SHA-1. Wikipedia quotes a 2008
attack, that can create a collision with 2^51 hash function calls.

Which, of course, is still way to much. Good for you! :-)
