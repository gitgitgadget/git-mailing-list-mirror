From: Karl =?ISO-8859-1?Q?=20Hasselstr=F6m?= <kha@treskal.com>
Subject: [PATCH 0/2] stg uncommit
Date: Fri, 17 Feb 2006 05:27:28 +0100
Message-ID: <20060217042728.14175.39928.stgit@backpacker.hemma.treskal.com>
References: <b0943d9e0602150925v6f01accfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 05:31:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9xHE-0000IJ-Gl
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 05:31:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWBQEb0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 23:31:26 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWBQEb0
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 23:31:26 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:30389 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S932119AbWBQEbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2006 23:31:25 -0500
Received: from backpacker.hemma.treskal.com ([83.227.180.148] [83.227.180.148])
          by mxfep01.bredband.com with ESMTP
          id <20060217043124.KDCN12400.mxfep01.bredband.com@backpacker.hemma.treskal.com>;
          Fri, 17 Feb 2006 05:31:24 +0100
Received: from backpacker.hemma.treskal.com (localhost.localdomain [127.0.0.1])
	by backpacker.hemma.treskal.com (Postfix) with ESMTP id DDD8E16BE;
	Fri, 17 Feb 2006 05:31:23 +0100 (CET)
To: Catalin Marinas <catalin.marinas@arm.com>
In-Reply-To: <b0943d9e0602150925v6f01accfw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16327>

Here is that uncommit command I was going on and on and on about.
There's also some stricter checking that refs/heads/bases is reset to
HEAD whenever we reach zero applied patches, since otherwise you can't
uncommit patches on an empty stomach.

Note the extremely cool feature that you can uncommit regardless of
how dirty your working tree is!

--=20
Karl Hasselstr=F6m
