From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Add a birdview-on-the-source-code section to the user manual
Date: Tue, 8 May 2007 23:31:58 +0200
Message-ID: <20070508213158.GB3969@diana.vm.bytemark.co.uk>
References: <Pine.LNX.4.64.0705081709230.4167@racer.site> <20070508210153.GA3969@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0705082306100.4167@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: bfields@citi.umich.edu, junio@cox.net, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 08 23:32:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlXI4-0001tn-DN
	for gcvg-git@gmane.org; Tue, 08 May 2007 23:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968104AbXEHVcH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 8 May 2007 17:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968132AbXEHVcG
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 17:32:06 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4090 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968104AbXEHVcF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 17:32:05 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HlXHq-0001D2-00; Tue, 08 May 2007 22:31:58 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705082306100.4167@racer.site>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46629>

On 2007-05-08 23:07:04 +0200, Johannes Schindelin wrote:

> On Tue, 8 May 2007, Karl Hasselstr=F6m wrote:
>
> > On 2007-05-08 17:10:47 +0200, Johannes Schindelin wrote:
> >
> > > +  char *`, but is actually expected to be a pointer to `unsigned
> > > +  char[20]`.  This variable will contain the big endian version =
of the
> > > +  40-character hex string representation of the SHA-1.
> >
> > Either it should be "unsigned char[40]" (or possibly 41 with a
> > terminating \0), or else you shouldn't be talking about
> > hexadecimal since it's just a 20-byte big-endian unsigned integer.
> > (A third possibility is that I'm totally confused.)
>
> It is 40 hex-character, but 20 _byte_. If you have any ideas how to
> formulate that better than I did...

I think this is less confusing:

  This variable will contain the 160-bit SHA-1.

It avoids talking of hex, since it's not really stored in hex format
any more than any other binary number with a number of bits divisible
by four. And it avoids saying big-endian, which is not relevant anyway
since we don't use hashes as integers.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
