From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit] StGit documentation on its configuration file usage.
Date: Mon, 4 Aug 2008 11:14:09 +0200
Message-ID: <20080804091409.GB9425@diana.vm.bytemark.co.uk>
References: <g6ku22$mgr$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
To: Jurko Gospodneti? <jurko.gospodnetic@docte.hr>
X-From: git-owner@vger.kernel.org Mon Aug 04 10:53:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPvof-0003LO-HS
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 10:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692AbYHDIwT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Aug 2008 04:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752672AbYHDIwS
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 04:52:18 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4539 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654AbYHDIwR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 04:52:17 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KPw8n-0002aA-00; Mon, 04 Aug 2008 10:14:09 +0100
Content-Disposition: inline
In-Reply-To: <g6ku22$mgr$1@ger.gmane.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91330>

On 2008-07-28 19:01:55 +0200, Jurko Gospodneti? wrote:

> StGIT's project page links to the
> http://wiki.procode.org/cgi-bin/wiki.cgi/StGIT_Tutorial page for its
> tutorial information.
>
> There the 'Configuration file' notes state that StGIT uses
> /etc/stgitrc, ~/.stgitrc and then .git/stgitrc configuration files
> in that order and that there is an example configuration file under
> the examples folder. However, grepping through the StGIT sources I
> found no references to the stgitrc file but only wrappers for using
> the native GIT configuration system. Also, looking at the examples
> folder I found only an example that seems to indicate that StGIT's
> configuration options should be integrated with other regular GIT
> configuration options.
>
> Did I miss something? Or is this wiki information outdated?

It's outdated. We'll have to bug Catalin to change it, since it's
read-only.

> Testing this I see that StGIT does not read the git configuration
> correctly on Windows with msysgit anyway, but that's a story for a
> different thread.

Yes. StGit should be fairly Windows-portable, since it's all Python,
but to my knowledge no one has tried to use it on Windows, so there
are bound to be a few gotchas.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
