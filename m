From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Git checkout preserve timestamp?
Date: Mon, 5 Mar 2007 13:28:28 +0100
Message-ID: <20070305122828.GA3481@diana.vm.bytemark.co.uk>
References: <17895.18265.710811.536526@lisa.zopyra.com> <20070302091426.GA2605@diana.vm.bytemark.co.uk> <17896.9631.316001.869157@lisa.zopyra.com> <Pine.LNX.4.63.0703021618000.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070302162136.GA9593@diana.vm.bytemark.co.uk> <Pine.LNX.4.63.0703022018190.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070305072323.GA31169@diana.vm.bytemark.co.uk> <Pine.LNX.4.63.0703051230390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 05 13:29:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOCJa-0003Gl-Mi
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 13:29:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933405AbXCEM2f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 5 Mar 2007 07:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933408AbXCEM2e
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 07:28:34 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4548 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933405AbXCEM2d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 07:28:33 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HOCIm-0000vS-00; Mon, 05 Mar 2007 12:28:28 +0000
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0703051230390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41440>

On 2007-03-05 12:32:07 +0100, Johannes Schindelin wrote:

> On Mon, 5 Mar 2007, Karl Hasselstr=F6m wrote:
>
> > Since the content is exactly the same as before, I'd be of the
> > strong opinion that nothing has changed as far as the make system
> > should be concerned.
>
> You are missing an important point here: there _was_ a change.

But I don't want my make tool to care! I want it to rebuild if and
only if the file contents now are different from the file contents as
of the last rebuild.

Just like if I change a git-tracked file, then change it back, git
will _not_ claim that the file has changed; it will compute its sha1,
see that it is identical to what's in HEAD, and from there on consider
that file not changed even thogh its timestamp was changed.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
