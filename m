From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: bisect / history preserving on rename + update
Date: Tue, 14 Aug 2007 12:50:56 +0200
Message-ID: <20070814105056.GA14536@diana.vm.bytemark.co.uk>
References: <1187080681.12828.174.camel@chaos> <20070814093357.GA14010@diana.vm.bytemark.co.uk> <1187086600.12828.177.camel@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
X-From: git-owner@vger.kernel.org Tue Aug 14 12:51:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKtzp-0002Dd-Fq
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 12:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756665AbXHNKv3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 14 Aug 2007 06:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755787AbXHNKv2
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 06:51:28 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2349 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754534AbXHNKv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 06:51:28 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IKtzE-0003xx-00; Tue, 14 Aug 2007 11:50:56 +0100
Content-Disposition: inline
In-Reply-To: <1187086600.12828.177.camel@chaos>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55824>

On 2007-08-14 12:16:40 +0200, Thomas Gleixner wrote:

> On Tue, 2007-08-14 at 11:33 +0200, Karl Hasselstr=F6m wrote:
>
> > What exactly do you mean by "lost history of B"? You do know that
> > git doesn't record renames? So you could just as well do
>
> Err.
>
> git-mv A B
> git commit
> edit B
> git commit
> git blame B <- shows the full history of A & B
>
> IMHO that's why we have git-mv

Try replacing

  $ git-mv A B

with

  $ mv A B
  $ git rm A
  $ git add B

The result is exactly the same. git-mv is just a convenience.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
