From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: bisect / history preserving on rename + update
Date: Tue, 14 Aug 2007 13:18:28 +0200
Message-ID: <20070814111828.GA15399@diana.vm.bytemark.co.uk>
References: <1187080681.12828.174.camel@chaos> <20070814093357.GA14010@diana.vm.bytemark.co.uk> <1187086600.12828.177.camel@chaos> <20070814105056.GA14536@diana.vm.bytemark.co.uk> <1187089619.12828.183.camel@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
X-From: git-owner@vger.kernel.org Tue Aug 14 13:19:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKuQZ-0001JQ-B2
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 13:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503AbXHNLTG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 14 Aug 2007 07:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757100AbXHNLTD
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 07:19:03 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2418 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755699AbXHNLTB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 07:19:01 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IKuPs-00045d-00; Tue, 14 Aug 2007 12:18:28 +0100
Content-Disposition: inline
In-Reply-To: <1187089619.12828.183.camel@chaos>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55827>

On 2007-08-14 13:06:59 +0200, Thomas Gleixner wrote:

> On Tue, 2007-08-14 at 12:50 +0200, Karl Hasselstr=F6m wrote:
>
> > The result is exactly the same. git-mv is just a convenience.
>
> Fair enough, but it still does not solve my initial problem of
> keeping the history of B (former A) intact, while creating a new A
> which is necessary to compile the tree, simply because I can not
> change #include <A> to #include <B> for various reasons.

Have you tried running blame with -C, or -C -C? That will make it try
harder to identify lines originating from other files.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
