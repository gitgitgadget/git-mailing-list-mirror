From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: tracking submodules out of main directory.
Date: Wed, 3 Aug 2011 08:25:39 +0200
Message-ID: <20110803062536.GB33203@book.hvoigt.net>
References: <4E0A08AE.8090407@web.de> <1311792580.2413.82.camel@Naugrim.eriador.com> <1311843465.3734.40.camel@Naugrim.eriador.com> <4E3192D4.5000504@web.de> <1311932377.3734.182.camel@Naugrim.eriador.com> <4E34122B.5020509@web.de> <1312062927.3261.334.camel@Naugrim.eriador.com> <4E370107.3050002@web.de> <1312287584.3261.798.camel@Naugrim.eriador.com> <4E384510.1070803@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: henri GEIST <henri.geist@flying-robots.com>,
	Alexei Sholik <alcosholik@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Aug 03 08:25:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoUtq-0007ia-9Z
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 08:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575Ab1HCGZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 02:25:46 -0400
Received: from darksea.de ([83.133.111.250]:48035 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750811Ab1HCGZo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 02:25:44 -0400
Received: (qmail 28483 invoked from network); 3 Aug 2011 08:25:39 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 3 Aug 2011 08:25:39 +0200
Content-Disposition: inline
In-Reply-To: <4E384510.1070803@web.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178546>

Hi Henri,

On Tue, Aug 02, 2011 at 08:42:24PM +0200, Jens Lehmann wrote:
> Am 02.08.2011 14:19, schrieb henri GEIST:
> > Le lundi 01 ao??t 2011 ?? 21:39 +0200, Jens Lehmann a ??crit :
> >> Am 30.07.2011 23:55, schrieb henri GEIST:
> >>> I can not see the difference with a gitlink.
> >>
> >> Then you can just use a config file for that, no? ;-)
> > 
> > Off corse, I immediately start to work on it.
> 
> I'm looking forward to that!

Before hacking away please share some design information about this.

Another thing:

It sounds like the workflow you want to achieve is similar to the one
the android developers are using. They have a lot of submodules which
need automatic updating.

The last time I checked they used repo (similar tool to submodules)
together with gerrit.

AFAIR they wanted to switch to submodules and have gerrit automatically
make the superproject commits for single submodule changes. Additionally
if a change involves multiple submodules the developer should be able to
tie them together using a superproject commit.

Have a look over there whether that workflow might help you?

Cheers Heiko
