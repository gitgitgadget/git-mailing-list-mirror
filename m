From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] Re: git svn clone not work. It's stop with no error
 message.
Date: Mon, 17 Feb 2014 16:51:47 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1402171649490.14982@s15462909.onlinehome-server.info>
References: <1392623113974-7603785.post@n2.nabble.com> <CALUzUxp=h-5mK-=YjvFRzyGGLp_-HxT661-P2yaqT9_6jPGnwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "msysgit@googlegroups.com" <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>,
	youngseonkim <1.youngsun.kim@gmail.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 17 16:51:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFQU6-0001WM-45
	for gcvg-git-2@plane.gmane.org; Mon, 17 Feb 2014 16:51:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753116AbaBQPvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Feb 2014 10:51:50 -0500
Received: from mout.gmx.net ([212.227.15.18]:64730 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750838AbaBQPvt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Feb 2014 10:51:49 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0Lugbo-1XFC9T3HBA-00zqzB
 for <git@vger.kernel.org>; Mon, 17 Feb 2014 16:51:47 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CALUzUxp=h-5mK-=YjvFRzyGGLp_-HxT661-P2yaqT9_6jPGnwA@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:IaFno/t1hfGvnaOB3SRrG0zJYK8Sw/dqO/cUQGO8rxSbY1GsICl
 BE3cHIqMTIp8uY0boQ02Avabe/yc84DHYx4X4+ycv+T8YfatAw4c9I+K4NSIkdSCLmKlAle
 eLPSC1+xA1uNhAl5W9hcFxsl7NlgcfeRCR/cTTLX/8/FgsUZ4tNoOBg+hQ+7zJv3bGX9ZTt
 Qur+N8i7MWLiiFXgsWL4w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242262>

Hi Tay,

On Mon, 17 Feb 2014, Tay Ray Chuan wrote:

> Posting to msysgit since this was on Windows.

Thanks.

> On Mon, Feb 17, 2014 at 3:45 PM, youngseonkim <1.youngsun.kim@gmail.com> wrote:
> > git svn clone https://my.svn.repo/url --stdlayout
> >
> > When I test a small svn repository and 'real working repository 1' with same
> > this command, it's complete successfully.
> > But it's not work in a 'real working repository 2', it just stop suddenly.

The git-svn we have on Windows is really old. As an easy way out, you can
use Vagrant (https://github.com/msysgit/msysgit/wiki/Vagrant) to run a
Linux Git on your machine. That should fix your issue.

Ciao,
Johannes
