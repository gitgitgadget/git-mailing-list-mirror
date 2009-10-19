From: Norbert Preining <preining@logic.at>
Subject: Re: Creating something like increasing revision numbers
Date: Mon, 19 Oct 2009 02:48:29 +0200
Message-ID: <20091019004829.GD11739@gamma.logic.tuwien.ac.at>
References: <20091018144158.GA9789@gandalf.dynalias.org> <200910181703.20607.johan@herland.net> <20091018152054.GA3956@gamma.logic.tuwien.ac.at> <7vfx9gnwtw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 02:48:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzgQQ-0000xC-Kx
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 02:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbZJSAs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 20:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbZJSAs2
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 20:48:28 -0400
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:40341 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbZJSAs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 20:48:28 -0400
Received: from gamma.logic.tuwien.ac.at ([128.130.175.3] ident=Debian-exim)
	by mx.logic.tuwien.ac.at with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <preining@logic.at>)
	id 1MzgQH-0000oh-LB; Mon, 19 Oct 2009 02:48:29 +0200
Received: from preining by gamma.logic.tuwien.ac.at with local (Exim 4.69)
	(envelope-from <preining@logic.at>)
	id 1MzgQH-0003fa-HR; Mon, 19 Oct 2009 02:48:29 +0200
Content-Disposition: inline
In-Reply-To: <7vfx9gnwtw.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130632>

On So, 18 Okt 2009, Junio C Hamano wrote:
>  #2 Do not give such sequential number locally; the central repository is
>     the _only_ place that assigns such a number.  '?' stands for
>     'unnumbered'

[...]

> Scheme #2 is a way to get some stablility; give the authority of numbering
> to the central repository and commits that haven't hit the central
> repository are left unnumbered.  But that is generally not very useful
> for your purpose of giving incrementing version number for building (the
> developers would want to build for testing before finally committing to
> publish the result to the central place).

That problem we have anyway with subversion, too, because as long as you
do not commit your changes nothing will happen on package rebuild.
So that is not a problem here.

Yes, we want server-sided linear numbers and anything *not* pushed to
the server is unnumbered.

And that is also fine, because packages are built only from the server.

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining                                        Associate Professor
JAIST Japan Advanced Institute of Science and Technology   preining@jaist.ac.jp
Vienna University of Technology                               preining@logic.at
Debian Developer (Debian TeX Task Force)                    preining@debian.org
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
PUDSEY (n.)
The curious-shaped flat wads of dough left on a kitchen table after
someone has been cutting scones out of it.
			--- Douglas Adams, The Meaning of Liff
