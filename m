From: "Govind Salinas" <govind@sophiasuchtig.com>
Subject: Re: thread-safe libgit.a as a GSoC project, was Re: [SoC RFC] libsvn-fs-git: A git backend for the subversion filesystem
Date: Sat, 22 Mar 2008 20:34:38 -0500
Message-ID: <5d46db230803221834n7c230447r2afffdaae79e4068@mail.gmail.com>
References: <3e8340490803182108y40a9aec2q8e5bcb78b907bbb5@mail.gmail.com>
	 <3e8340490803212202r6dbaa9eel544ba2b4b8e8d0c7@mail.gmail.com>
	 <alpine.LSU.1.00.0803221229410.4124@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Bryan Donlan" <bdonlan@gmail.com>, git@vger.kernel.org,
	"Sam Vilain" <sam@vilain.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Harvey Harrison" <harvey.harrison@gmail.com>,
	"Julian Phillips" <julian@quantumfyre.co.uk>,
	"Jakub Narebski" <jnareb@gmail.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 23 02:35:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdF7T-0004Zz-Qa
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 02:35:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754992AbYCWBek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 21:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755187AbYCWBek
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 21:34:40 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:62918 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754357AbYCWBej (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 21:34:39 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2350049wxd.4
        for <git@vger.kernel.org>; Sat, 22 Mar 2008 18:34:38 -0700 (PDT)
Received: by 10.151.106.4 with SMTP id i4mr2412249ybm.189.1206236078468;
        Sat, 22 Mar 2008 18:34:38 -0700 (PDT)
Received: by 10.150.156.18 with HTTP; Sat, 22 Mar 2008 18:34:38 -0700 (PDT)
In-Reply-To: <alpine.LSU.1.00.0803221229410.4124@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77862>

On Sat, Mar 22, 2008 at 6:35 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>  On Sat, 22 Mar 2008, Bryan Donlan wrote:
>  > Also, after looking at libgit in a bit more detail, I think it might be
>  > necessary to not use it after all, as subversion requires support for
>  > multiple open repositories, as well as thread safety (at least when
>  > accessing different open repo from different threads). Perhaps a
>  > thread-safe git library would be a nice SoC project as well?
>
>  As I said on IRC yesterday, I think that such a libgit.a would be nice,
>  _but_
>
>  - a lot of git programs expect to be one-shot, and libgit.a shows that,
>
>  - not many people will help you with your effort, but just ignore it and
>   actively introduce things that do not help libification (at least that's
>   my experience),
>
>  - unless you have a proper need for such a library, I do not think there
>   is enough motivation to actually get it to completion.
>

I would use it for my pyrite work, although it will be some time before I
could contribute to such an effort.  I expect it would be useful for
anyone who wants to make a language binding that uses native
git underneath.

Just so you know *someone* will use it.

Thanks,
Govind.
