From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Add a birdview-on-the-source-code section to the user manual
Date: Wed, 9 May 2007 01:22:51 +0200
Message-ID: <20070508232251.GA5866@diana.vm.bytemark.co.uk>
References: <Pine.LNX.4.64.0705081709230.4167@racer.site> <20070508210153.GA3969@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0705082306100.4167@racer.site> <20070508213158.GB3969@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0705090105450.4167@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: bfields@citi.umich.edu, junio@cox.net, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 09 01:23:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlZ1J-0006OH-L9
	for gcvg-git@gmane.org; Wed, 09 May 2007 01:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967300AbXEHXW4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 8 May 2007 19:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967364AbXEHXWz
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 19:22:55 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4276 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967300AbXEHXWz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 19:22:55 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HlZ19-0001Z4-00; Wed, 09 May 2007 00:22:51 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705090105450.4167@racer.site>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46635>

On 2007-05-09 01:10:13 +0200, Johannes Schindelin wrote:

> On Tue, 8 May 2007, Karl Hasselstr=F6m wrote:
>
> > I think this is less confusing:
> >
> >   This variable will contain the 160-bit SHA-1.
> >
> > It avoids talking of hex, since it's not really stored in hex
> > format any more than any other binary number with a number of bits
> > divisible by four. And it avoids saying big-endian, which is not
> > relevant anyway since we don't use hashes as integers.
>
> Well, I do not buy into that. First, we _have_ to say that it is
> big-endian. It was utterly confusing to _me_ that the hash was not
> little endian, as I expected on an Intel processor.

If you think of it as a integer and not a byte array, then yes. But
fair enough, if it confused you, it'd probably confuse others as well.

> And I'd rather mention the hex representation (what you see in
> git-log and git-ls-tree). This helps debugging, believe me.

But that byte array doesn't store the hex representation!

There is a trivial transformation that will convert a 20-byte integer
to a 40-character hex string representation of that integer: translate
each nibble to one hex digit. But the code snippet you gave uses the
former representation, and that's the point I thought you were trying
to make in the first place.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
