From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Commit signing
Date: Mon, 15 Jan 2007 15:52:35 +0100
Message-ID: <20070115145235.GA1830@diana.vm.bytemark.co.uk>
References: <200701151000.58609.andyparkins@gmail.com> <20070115101529.GB12257@spearce.org> <Pine.LNX.4.63.0701151126540.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070115104336.GD12257@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 19:50:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6VVg-0000K7-Di
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:20:40 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6VAX-0003eK-Jv
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbXAOOw6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 15 Jan 2007 09:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbXAOOw6
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 09:52:58 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4846 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbXAOOw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 09:52:57 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1H6TCO-0000Xf-00; Mon, 15 Jan 2007 14:52:36 +0000
To: "Shawn O. Pearce" <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <20070115104336.GD12257@spearce.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36851>

On 2007-01-15 05:43:36 -0500, Shawn O. Pearce wrote:

> If you don't trust the owner, but you trust the pusher, than using 1
> annotated tag per push is reasonable and gives you something to
> verify the repository owner isn't playing games. If you don't trust
> the pusher than you should be reviewing the changes before deciding
> to keep them in your project.
>
> But even then annotated tags are overkill. You could just receive
> the commit SHA1 out-of-band from the pusher (e.g. email, like
> Junio's hidden X-master-at header) and verify that by hand. 8 digits
> is probably more than enough to hand-verify the entire commit chain
> you are receiving.

No. You've just constructed a system whose security depends on a
32-bit hash. This is one of those situations where you really do need
all the digits.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
