From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 1/2] Update the bash prompt from 'applied' instead of the obsolete 'current'
Date: Mon, 21 May 2007 09:48:38 +0200
Message-ID: <20070521074838.GA32510@diana.vm.bytemark.co.uk>
References: <20070520204627.GR19253@nan92-1-81-57-214-146.fbx.proxad.net> <20070520211103.17468.21373.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: catalin.marinas@gmail.com, ydirson@altern.org, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon May 21 09:50:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq2fB-0002vG-DR
	for gcvg-git@gmane.org; Mon, 21 May 2007 09:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755095AbXEUHuQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 21 May 2007 03:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754921AbXEUHuQ
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 03:50:16 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3945 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754916AbXEUHuP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 03:50:15 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Hq2dC-0008WT-00; Mon, 21 May 2007 08:48:38 +0100
Content-Disposition: inline
In-Reply-To: <20070520211103.17468.21373.stgit@lathund.dewire.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47986>

On 2007-05-20 23:22:00 +0200, Robin Rosenberg wrote:

> s=F6ndag 20 maj 2007 skrev Yann Dirson:
>
> > Also I'm not sure it is a good way to look at "applied" file,
> > since Karl IIRC has plans to change this. Better call "stg top"
> > and not touch that again :)
>
> Calling stg is too slow to be be used here. I that command in my
> first draft for this function and people complained (see the thread
> named "Bash snippet to show branch and patch in bash prompt"). It
> takes ~ 0.15s on here which is very noticable, barely below my pain
> threshold.
>
> We'll update the prompt when and if Karl breaks this.

Yes, I can confirm that I'm hard at work breaking this. :-) I'm trying
out a way to get around the performance bug Catalin found, but I
didn't have time to finish it yesterday.

If that work is included, you could simply find the top patch by doing
git-show-ref and figuring out which patch has the same sha1 as HEAD.

But it sucks that stg starts so slowly. It has gotten better, I
believe (I think Catalin did some work here?), but 150 ms doesn't
really qualify as "instantaneous".

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
