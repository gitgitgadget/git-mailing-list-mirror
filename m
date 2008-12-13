From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 2/2] Add getPatchText functions to obtain the plain-text version of a patch
Date: Sat, 13 Dec 2008 12:02:07 +0100
Message-ID: <200812131202.07717.robin.rosenberg.lists@dewire.com>
References: <1229136146-15359-1-git-send-email-spearce@spearce.org> <1229136146-15359-2-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Dec 13 12:09:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBSN5-0005fR-0j
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 12:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752361AbYLMLCN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Dec 2008 06:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751885AbYLMLCN
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 06:02:13 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:62037 "EHLO
	pne-smtpout2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751760AbYLMLCM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 06:02:12 -0500
Received: from sleipner.localnet (213.67.100.250) by pne-smtpout2-sn2.hy.skanova.net (7.3.129)
        id 4873CA95026D25C6; Sat, 13 Dec 2008 12:02:09 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.27-10-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <1229136146-15359-2-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102995>

l=F6rdag 13 december 2008 03:42:26 skrev Shawn O. Pearce:
> The conversion from byte[] to String is performed one line at a time,
> in case the patch is a character encoding conversion patch for the
> file.  For simplicity we currently assume UTF-8 still as the default
> encoding for any content, but eventually we should support using the
> .gitattributes encoding property when performing this conversion.

=46or usefulness we must be able to pass the encoding from outside,=20
e.g. the encoding Eclipse uses, which often is not UTF-8-

-- robin
