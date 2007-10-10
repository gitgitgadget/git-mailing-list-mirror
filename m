From: Jan Wielemaker <wielemak@science.uva.nl>
Subject: Re: [PATCH] git-cvsserver: added support for update -p
Date: Wed, 10 Oct 2007 19:27:38 +0200
Message-ID: <200710101927.38949.wielemak@science.uva.nl>
References: <200710101316.03633.jan@swi-prolog.org> <200710101626.53303.jan@swi-prolog.org> <Pine.LNX.4.64.0710101740400.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jan Wielemaker <jan@swi-prolog.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 10 19:28:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IffLk-0006nO-Ps
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 19:28:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753874AbXJJR1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 13:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754164AbXJJR1v
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 13:27:51 -0400
Received: from smtp-vbr5.xs4all.nl ([194.109.24.25]:3692 "EHLO
	smtp-vbr5.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753746AbXJJR1u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 13:27:50 -0400
Received: from ct.xs4all.nl (ct.xs4all.nl [82.92.39.12])
	by smtp-vbr5.xs4all.nl (8.13.8/8.13.8) with ESMTP id l9AHRdr0036826;
	Wed, 10 Oct 2007 19:27:39 +0200 (CEST)
	(envelope-from wielemak@science.uva.nl)
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0710101740400.4174@racer.site>
Content-Disposition: inline
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60522>

> On Wed, 10 Oct 2007, Jan Wielemaker wrote:
> > Is there a test suite for git-cvsserver?
>
> Yes: t/t9400-git-cvsserver-server.sh

Thanks.  B.t.w. from the main directory:

gollem (git) 21_> make check
for i in *.c; do 
sparse -g -O2 -Wall  -DSHA1_HEADER='<openssl/sha.h>' -DETC_GITCONFIG='"/home/jan/etc/gitconfig"' -DNO_STRLCPY -D__BIG_ENDIAN__ -D__powerpc__ 
$i || exit; done
/bin/sh: sparse: command not found
make: *** [check] Error 127

Dunno, but maybe something like this is more appropriate:

	echo "See t/README for testing GIT"

	Cheers --- Jan

P.s.	My modified version passes all tests.
