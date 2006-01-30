From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: git vs git
Date: Mon, 30 Jan 2006 16:37:15 +0100
Organization: Harddisk-recovery.com
Message-ID: <20060130153715.GE30671@harddisk-recovery.com>
References: <d93f04c70601300714i4b7b3b58qa5aa151e3e42a413@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: david@dgreaves.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 16:38:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3b62-0005Vv-U1
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 16:37:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWA3Ph0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jan 2006 10:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWA3Ph0
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jan 2006 10:37:26 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:38238 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932340AbWA3PhT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jan 2006 10:37:19 -0500
Received: (qmail 17310 invoked by uid 501); 30 Jan 2006 16:37:15 +0100
To: Hendrik Visage <hvjunk@gmail.com>
Content-Disposition: inline
In-Reply-To: <d93f04c70601300714i4b7b3b58qa5aa151e3e42a413@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15278>

On Mon, Jan 30, 2006 at 05:14:28PM +0200, Hendrik Visage wrote:
> as few of you might know, there existed a very nice mc/norton commander
> orientated tool called git
>       Homepage:    http://www.gnu.org/software/git/
>       Description: GNU Interactive Tools - increase speed and
> efficiency of most daily task

Yes, this has been discussed in the past.

> This package have been in existence since many summers, but the name choice for
> git - the stupid content tracker, seems to cause several weird problems when
> you don't want/expect it :(

GNU git development is dead. The last release is from March 13, 2000.

> Could the name git perhaps be reconsideredto something like SCT? or GnuSCT?

I don't think that will happen. The number of source control git users
outnumbers the number of GNU git users, so consider it a lost case.

> Just asking, as it do cause hassles when an environment is using git
> and suddenly
> need to load git to download newer drivers etc. and then git isn't
> working because the wrong git is in the right place :(

I think we found the only GNU git user in the world! ;-)

A simple workaround would be to install git in a directory not in your
path and put a shell script "sct" in your path that just calls git.
Something like (untested):

  #! /bin/sh
  # sct: call git
  gitpath=/path/to/git
  export PATH=$gitpath:$PATH
  exec $gitpath/git $*


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
