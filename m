From: Werner LEMBERG <wl@gnu.org>
Subject: Re: serious problem with `git format-patch' & `git am'
Date: Fri, 27 Feb 2009 10:16:49 +0100 (CET)
Message-ID: <20090227.101649.156177765.wl@gnu.org>
References: <20090225.230352.177616203.wl@gnu.org>
	<6HVVE8kW9V0CsNfW21a_Tqpt2s-IrJbt2_qdAvQ8r1tetEhb6jr18g@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, keithp@keithp.com
To: casey@nrlssc.navy.mil
X-From: git-owner@vger.kernel.org Fri Feb 27 10:18:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lcyri-0007Yu-5u
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 10:18:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754347AbZB0JRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 04:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754233AbZB0JRN
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 04:17:13 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:64143 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753953AbZB0JRM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 04:17:12 -0500
Received: from localhost (pns-202-069.demo.tuwien.ac.at [128.131.202.69])
	by mrelayeu.kundenserver.de (node=mrelayeu8) with ESMTP (Nemesis)
	id 0ML31I-1Lcyq51JiD-0006UW; Fri, 27 Feb 2009 10:17:04 +0100
In-Reply-To: <6HVVE8kW9V0CsNfW21a_Tqpt2s-IrJbt2_qdAvQ8r1tetEhb6jr18g@cipher.nrlssc.navy.mil>
X-Mailer: Mew version 6.2.50 on Emacs 22.3.1 / Mule 5.0 (SAKAKI)
X-Provags-ID: V01U2FsdGVkX1/BoKlg35sU3ZJnazfkPsxun9zTabit24HiDpU
 P4UvdrdGlYVIMXjyQsS7MoKCTgyaGbQZaG3elVxGtbMc6Ro9BC
 mSgFebxOKUf3TPu/NOL4g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111651>


> I was not aware of this behavior, but it looks like the '-k' option
> for both format-patch and git-am is what you want to use.  It will
> prevent mailinfo from munging the commit message.

Tried it already.  It doesn't help.


    Werner
