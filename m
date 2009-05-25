From: Thomas Spura <tomspur@fedoraproject.org>
Subject: Re: [PATCH] speed: reuse char instead of recreation in loop
Date: Mon, 25 May 2009 20:44:20 +0000 (UTC)
Message-ID: <pan.2009.05.25.20.44.20@fedoraproject.org>
References: <pan.2009.05.25.19.44.10@fedoraproject.org>
	<4A1B01E9.30601@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 22:45:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8h2p-0005yH-J2
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 22:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338AbZEYUpH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 May 2009 16:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751975AbZEYUpH
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 16:45:07 -0400
Received: from main.gmane.org ([80.91.229.2]:37250 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751729AbZEYUpG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 16:45:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1M8h2d-0002Xz-45
	for git@vger.kernel.org; Mon, 25 May 2009 20:45:03 +0000
Received: from p5b20e9ac.dip.t-dialin.net ([91.32.233.172])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 May 2009 20:45:03 +0000
Received: from tomspur by p5b20e9ac.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 May 2009 20:45:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p5b20e9ac.dip.t-dialin.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119964>

Am Mon, 25 May 2009 22:39:05 +0200 schrieb Ren=C3=A9 Scharfe:
> This introduces a memory leak.  The string pointed to by ref is
> allocated by dwim_ref() and needs to be free()'d after use, and -- mo=
re
> importantly -- before ref is assigned its next value by dwim_ref().

Thanks, sorry for the noise...

	Thomas
