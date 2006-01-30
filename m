From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: git vs git
Date: Mon, 30 Jan 2006 18:23:45 +0100
Organization: Harddisk-recovery.com
Message-ID: <20060130172344.GA20867@harddisk-recovery.com>
References: <d93f04c70601300714i4b7b3b58qa5aa151e3e42a413@mail.gmail.com> <20060130153715.GE30671@harddisk-recovery.com> <86acddirjr.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hendrik Visage <hvjunk@gmail.com>, david@dgreaves.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 18:24:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3cko-0000aJ-6H
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 18:23:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWA3RXr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jan 2006 12:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbWA3RXr
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jan 2006 12:23:47 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:64117 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S964821AbWA3RXq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jan 2006 12:23:46 -0500
Received: (qmail 3429 invoked by uid 501); 30 Jan 2006 18:23:45 +0100
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Content-Disposition: inline
In-Reply-To: <86acddirjr.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15284>

On Mon, Jan 30, 2006 at 08:55:36AM -0800, Randal L. Schwartz wrote:
> >>>>> "Erik" == Erik Mouw <erik@harddisk-recovery.com> writes:
> 
> Erik>   #! /bin/sh
> Erik>   # sct: call git
> Erik>   gitpath=/path/to/git
> Erik>   export PATH=$gitpath:$PATH
> Erik>   exec $gitpath/git $*
> 
> You must not get a lot of spaces in your pathnames.

That usually doesn't happen in the kernel tree (which is what the OP
wants to follow).

> I think you want
> those last two lines to be:
> 
>         export PATH="$gitpath:$PATH"
>         exec "$gitpath/git" "$@"
> 
> Typical lazy shell programmer. :) :)

Hey, I said "untested" :) But yeah, you're right. Your syntax is
correct, every time I write such a wrapper I try to remember it...


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
