From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: Recent issues
Date: Mon, 09 Jul 2007 13:03:43 +0200
Organization: eudaptics software gmbh
Message-ID: <4692160F.615EB6F2@eudaptics.com>
References: <7v7ipcbrfd.fsf@assigned-by-dhcp.cox.net>
		<18065.65446.474822.436800@cargo.ozlabs.ibm.com>
		<46920BDA.C1AC9F51@eudaptics.com> <18066.4639.682605.171418@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Jul 09 13:03:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7r1S-00046E-9i
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 13:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbXGILDH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 07:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737AbXGILDG
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 07:03:06 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:46833 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbXGILDE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 07:03:04 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtp (Exim 4.66)
	(envelope-from <J.Sixt@eudaptics.com>)
	id 1I7r19-0007TW-E3; Mon, 09 Jul 2007 13:02:59 +0200
Received: from eudaptics.com (tethys.linz.eudaptics [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 6089154D; Mon,  9 Jul 2007 13:02:59 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 2.0 (++)
X-Spam-Report: AWL=-1.629, BAYES_99=3.5, FORGED_RCVD_HELO=0.135
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51979>

Paul Mackerras wrote:
> 
> Johannes Sixt writes:
> 
> > In general, there is a big down-side, although I don't know if this
> > particular case is affected: --pretty=raw prints the parents noted in
> > the commit object, but not those from .git/info/grafts.
> 
> Are you referring to the parents listed on the "commit" line when you
> have the --parents flag, or the parents listed on "parent" lines in
> the commit?  Gitk uses the former, and I hope that does in fact
> reflect grafts.  It certainly reflects the "logical" topology when
> using path limiting.

It seems that git log --parents --pretty=raw prints the "logical" parent
in the "commit" line, i.e. the grafted parent, but the real parent in
the "parent" lines.

Since gitk uses the "commit" line, all is well. Please ignore my
comment.

-- Hannes
