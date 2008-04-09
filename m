From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git bisect on multiple cores
Date: Wed, 9 Apr 2008 09:17:50 +0200
Message-ID: <20080409071750.GA23211@diana.vm.bytemark.co.uk>
References: <dbbf25900804080358o6b1ada20pfb94f68f06a23f83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: A B <gentosaker@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 09 09:19:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjUaC-0001aY-4C
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 09:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753133AbYDIHSF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Apr 2008 03:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753252AbYDIHSE
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 03:18:04 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4900 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753699AbYDIHSD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 03:18:03 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JjUZ4-00065K-00; Wed, 09 Apr 2008 08:17:50 +0100
Content-Disposition: inline
In-Reply-To: <dbbf25900804080358o6b1ada20pfb94f68f06a23f83@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79084>

On 2008-04-08 12:58:47 +0200, A B wrote:

> git bisect is really cool. I use it for the first time. Just a
> thought, if you have a multiple core computer, can't you make git
> build new versions in the background while testing the previuos
> version? Alright, if you build 2 versions, one of them will never be
> tested, but you will perhaps save some time by letting it build in
> the background?

Adding parallelism to a binary search scales very badly -- I'd say
about logarithmically, but I haven't thought hard about it. If it's
possible to use the extra cores to speed up the build+test cycle,
that's vastly preferable.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
