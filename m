From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFH] git-difftool fails to export GIT_DIFF_TOOL when running t7800 with valgrind over ssh
Date: Mon, 14 Jun 2010 17:03:28 +0200
Message-ID: <201006141703.28488.trast@student.ethz.ch>
References: <201006131251.11229.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 14 17:03:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOBCg-0005kq-Is
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 17:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754266Ab0FNPDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 11:03:52 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:11639 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753314Ab0FNPDw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 11:03:52 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 14 Jun
 2010 17:03:51 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 14 Jun
 2010 17:03:28 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <201006131251.11229.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149099>

Thomas Rast wrote:
>   0x7fffc45381fb GIT_DIFF_TOOM=bad-tool
>   0x7fffc4538212 LD_PRELOAD=
>   0x7fffc453821e 
>   0x7fffc453821f MORE=-sl
>   0x7fffc4538228 GIT_DIFF_TOOK=bad-tool

If you considered looking into it, don't; it is a subtle string
overrun bug in valgrind's environment mangling.

(Thanks anyway if you tried...  I really lost hope for a while there)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
