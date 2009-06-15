From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Cast things properly to handle >2G files.
Date: Sun, 14 Jun 2009 21:06:45 -0700
Message-ID: <7vmy8ap2cq.fsf@alter.siamese.dyndns.org>
References: <E1MFvux-0001ix-I7@fencepost.gnu.org>
	<alpine.DEB.1.00.0906142215560.26154@pacific.mpi-cbg.de>
	<E1MG32S-0004C6-8A@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: ams@gnu.org
X-From: git-owner@vger.kernel.org Mon Jun 15 06:07:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MG3Tc-0008Qr-II
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 06:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbZFOEGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 00:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbZFOEGu
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 00:06:50 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:37560 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbZFOEGt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 00:06:49 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090615040650.HFTD17135.fed1rmmtao104.cox.net@fed1rmimpo03.cox.net>;
          Mon, 15 Jun 2009 00:06:50 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 446r1c0054aMwMQ0446rmd; Mon, 15 Jun 2009 00:06:51 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=AYBFenIAru0A:10 a=IC9OQMIA7K4A:10
 a=mDV3o1hIAAAA:8 a=DW9qt3XYXSjpfiPXsTMA:9 a=mQWzNKUlcW_j_3otXn5tF-JlWUQA:4
 a=2fcrIxHVTVsA:10 a=ii61gXl28gQA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121579>

"Alfred M. Szmidt" <ams@gnu.org> writes:

> I cannot agree to the D-C-O in good faith, since it speaks of open
> source licenses, a group of licenses that include non-free software
> licenses, something which I cannot support.

DCO is not something you "agree to".

Are you the original author of the patch, and have the right to submit it
under the license "indicated in the file"?

The overall license of git is GPLv2, and that is what applies to unless
there is an explicit license term indicated in the file otherwise. We do
have some code under different licenses in some parts of the system, but
the files that you are touching are all GPLv2.

Can you certify that your patch is yours and you have rights to make it
part of git under the same terms as the original?  Or can you not?  There
is nothing for you to "agree to"; just a simple "yes or no", and I hope
the answer is yes in this case, judging from your gnu.org address.

>    Oh, and maybe add a test like t/t5705-clone-2gb.sh?
>
> Thank you, that is a very good idea.

Nah, one blob that is over 2gb, deltified against something else?  That's
a bit too much for a test script.
