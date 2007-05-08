From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git-clean fails to remove a file whose name contains \\, ",  or  \n, TAB, etc.
Date: Wed, 9 May 2007 01:27:02 +0200
Message-ID: <20070508232702.GB5866@diana.vm.bytemark.co.uk>
References: <87ps5bhx8t.fsf@rho.meyering.net> <86k5vj9gzu.fsf@blue.stonehenge.com> <20070508231115.GA14900@efreet.light.src> <86wszi9a5r.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jan Hudec <bulb@ucw.cz>, Jim Meyering <jim@meyering.net>,
	git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Wed May 09 01:27:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlZ5a-0006zq-Rb
	for gcvg-git@gmane.org; Wed, 09 May 2007 01:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967536AbXEHX1U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 8 May 2007 19:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968845AbXEHX1U
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 19:27:20 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4285 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967536AbXEHX1T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 19:27:19 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HlZ5C-0001aE-00; Wed, 09 May 2007 00:27:02 +0100
Content-Disposition: inline
In-Reply-To: <86wszi9a5r.fsf@blue.stonehenge.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46636>

On 2007-05-08 16:18:40 -0700, Randal L. Schwartz wrote:

> >>>>> "Jan" =3D=3D Jan Hudec <bulb@ucw.cz> writes:
>
> Jan> Than I can't think of anything other than xargs -0.
>
> git-ls-files -z .... |
> perl -0lne '
>    $_ is each name here
> '

Have you seen this?

  http://xkcd.com/c224.html

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
