From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: git-diff-tree rename detection bug
Date: Thu, 15 Sep 2005 16:49:46 +0200
Message-ID: <200509151649.47159.Josef.Weidendorfer@gmx.de>
References: <59a6e583050914094777c4fe96@mail.gmail.com> <Pine.LNX.4.58.0509142032300.26803@g5.osdl.org> <17192.65054.520959.454610@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: valgrind-developers@lists.sourceforge.net
X-From: git-owner@vger.kernel.org Thu Sep 15 16:54:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFv4i-0005UF-H7
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 16:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030471AbVIOOuW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 10:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030474AbVIOOuW
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 10:50:22 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:31468 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1030471AbVIOOuU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2005 10:50:20 -0400
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <17192.65054.520959.454610@cargo.ozlabs.ibm.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8608>

On Thursday 15 September 2005 06:52, Paul Mackerras wrote:
> Valgrind sets LD_PRELOAD so that you get a simple Valgrind-supplied
> set of string functions, including strlen, from vgpreload_memcheck.so
> rather than the fancy glibc ones.  However, that doesn't seem to catch
> the calls to strlen from inside glibc - the call from vfprintf is a
> direct branch rather than going through the PLT, for instance.

Just curious: Why is it using LD_PRELOAD and not the VGs symbol redirection 
mechanism, which should catch strlen even if used inside of glibc?

Josef
