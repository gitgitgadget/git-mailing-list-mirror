From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Git checkout preserve timestamp?
Date: Mon, 5 Mar 2007 15:53:47 +0100
Message-ID: <20070305145347.GC3481@diana.vm.bytemark.co.uk>
References: <17895.18265.710811.536526@lisa.zopyra.com> <200703051213.52513.andyparkins@gmail.com> <20070305123348.GB3481@diana.vm.bytemark.co.uk> <200703051319.17046.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bill Lear <rael@zopyra.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 15:54:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOEZc-0005A8-QX
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 15:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933496AbXCEOx5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 5 Mar 2007 09:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933500AbXCEOx5
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 09:53:57 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4908 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933496AbXCEOx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 09:53:56 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HOEZQ-0001Zo-00; Mon, 05 Mar 2007 14:53:48 +0000
Content-Disposition: inline
In-Reply-To: <200703051319.17046.andyparkins@gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41446>

On 2007-03-05 13:19:15 +0000, Andy Parkins wrote:

> On Monday 2007 March 05 12:33, Karl Hasselstr=F6m wrote:
>
> > Now, obviously "make" isn't such a make tool, since it goes only
> > by timestamps.
>
> Perhaps this will help you:
>
> http://kolpackov.net/pipermail/notes/2004-September/000011.html

Thanks for the pointer; I hadn't seen that technique before. But it
isn't really worth it. The make tool going by hash rather than
timestamp is a nice-to-have, not a must-have (for those projects I've
been involved in anyway), so the cost of the solution proposed in that
message is too high.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
