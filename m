From: hvoigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH] git_getpass: fix ssh-askpass behaviour
Date: Mon, 13 Dec 2010 23:00:04 +0100
Message-ID: <20101213220003.GB2497@sandbox>
References: <AANLkTinES5dqt+JAMOrp7gAYJ4UgK9ipfEN9ag5qSCLp@mail.gmail.com>
 <1292157174-4033-2-git-send-email-alexander@sulfrian.net>
 <7voc8q7bdv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Sulfrian <alexander@sulfrian.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 23:00:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSGRL-0004uE-CA
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 23:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755202Ab0LMWAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 17:00:07 -0500
Received: from darksea.de ([83.133.111.250]:46385 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752069Ab0LMWAG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 17:00:06 -0500
Received: (qmail 17984 invoked from network); 13 Dec 2010 23:00:04 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 13 Dec 2010 23:00:04 +0100
Content-Disposition: inline
In-Reply-To: <7voc8q7bdv.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163599>

Hi,

On Sun, Dec 12, 2010 at 04:41:00PM -0800, Junio C Hamano wrote:
> Alexander Sulfrian <alexander@sulfrian.net> writes:
> 
> > call ssh-askpass only if the display environment variable is also set
> > ---
> 
> I do not use it at all so I don't know for sure, but doesn't this break
> OSX?
> 
>   20f3490 (web--browse: fix Mac OS X GUI detection for 10.6, 2009-09-14)
> 
> is an example that you can be fully graphical without having DISPLAY set
> in some environment.  MinGW folks may want to chime in as well.

I am not sure about OSX because I just checked and there seems to be a
DISPLAY variable set which seems to be used to start a X session on
demand. But MinGW definitely has no DISPLAY variable set by default.

Additionally GIT_ASKPASS/SSH_ASKPASS does not have to be a graphical
tool does it? It could also be some program that looks up the password
from some secure database.

Cheers Heiko
