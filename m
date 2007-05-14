From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 01/10] Add a birdview-on-the-source-code section to the user manual
Date: Mon, 14 May 2007 20:58:52 +0200
Message-ID: <20070514185852.GA32331@diana.vm.bytemark.co.uk>
References: <20070514181943.GA31749@diana.vm.bytemark.co.uk> <20070514183931.GC23090@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Mon May 14 20:59:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnflD-0000WW-5n
	for gcvg-git@gmane.org; Mon, 14 May 2007 20:59:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbXENS7B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 14 May 2007 14:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752573AbXENS7B
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 14:59:01 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2445 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbXENS7A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 14:59:00 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Hnfky-0008Rp-00; Mon, 14 May 2007 19:58:52 +0100
Content-Disposition: inline
In-Reply-To: <20070514183931.GC23090@fieldses.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47286>

On 2007-05-14 14:39:31 -0400, J. Bruce Fields wrote:

> No, I appreciate the complaint, I just don't know what to do about
> it--as far as I can tell, I've chosen utf-8 everywhere I can: my
> commits are in utf-8, and "locale" run from the shell reports
> everything as "en_US.UTF-8". But I suspect the problem is on my end
> somewhere--do I need to do something to make sure mail I send gets a
> header identifying it as utf-8 and not iso-8859-1? I'll investigate
> some more tonight if I get the chance; any advice welcomed.

Your mail headers include this:

  Content-Transfer-Encoding: QUOTED-PRINTABLE
  Content-Type: TEXT/PLAIN; charset=3DISO-8859-1

but the mail body has this:

  It includes modifications as suggested by J. Bruce Fields, Karl
  Hasselstr=3DC3=3DB6m and Daniel Barkalow.

(That's a two-byte sequence for a single character, which indicates
utf8 and rules out latin1.)

I guess the program that generates the e-mail (git-format-patch?)
thinks it's getting latin1 input, when it's in fact getting utf8
input. This is the exact same error (or rather, the exact same
symptom) that's happened once or twice the last week or so.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
