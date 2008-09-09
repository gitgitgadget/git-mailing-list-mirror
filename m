From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: [ANNOUNCE] Guilt v0.31
Date: Tue, 09 Sep 2008 15:02:07 +0200
Message-ID: <48C673CF.2000107@fastmail.fm>
References: <20080908135244.GB27550@josefsipek.net> <36ca99e90809081133s58e3d32h8b85804f5bb76902@mail.gmail.com> <20080908184322.GE27550@josefsipek.net> <36ca99e90809081150v4ad6e7a0n72b5cca39e02b1bc@mail.gmail.com> <7vmyiifnwa.fsf@gitster.siamese.dyndns.org> <48C64B8B.5000606@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Josef 'Jeff' Sipek <jeffpc@josefsipek.net>,
	Git Mailing List <git@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	guilt@lists.josefsipek.net, Brandon Philips <brandon@ifup.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue Sep 09 15:03:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd2sK-0006d6-H8
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 15:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbYIINCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 09:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbYIINCM
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 09:02:12 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:53489 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751176AbYIINCM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Sep 2008 09:02:12 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id C3F5615D472;
	Tue,  9 Sep 2008 09:02:10 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 09 Sep 2008 09:02:10 -0400
X-Sasl-enc: Wyq1G4d6rzPqSoShiuIF1a5ZsLj5rX/NP8bI9/Y+nD7O 1220965330
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 94FA6142FB;
	Tue,  9 Sep 2008 09:02:09 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <48C64B8B.5000606@fastmail.fm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95379>

Michael J Gruber venit, vidit, dixit 09.09.2008 12:10:
> Junio C Hamano venit, vidit, dixit 08.09.2008 21:17:
...
>> Either be thankful for the availability of tarballs, or ignore them and
>> generate them yourself --- it's your choice.
> 
> He might want an install target which installs doc from the doc-tarball
> or from the man- and html-branches. Be it a Makefile in those
> convenience branches. I know it's just a tar or cpio away, of course. I
> might look at a Makefile for the doc branches.
> 
> Michael

Following up on my own mumble: There are some lesser known make targets for git which almost do that already.

make install-html uses only asciidoc and xsltproc, but not xmlto, for generating (and installing) html doc, which makes some people happier already.

make quick-install-doc installs the man pages (and only the man pages, not the html version) by using the "man" branch provided by "the man" (JC).

I would go about renaming quick-install-doc to quick-install-man, introducing quick-install-html doing the analogous using the "html" branch and quick-install-doc doing both, which would be more in line with the install-doc target.

Are there any objections to renaming quick-install-doc to quick-install-man?

Michael
