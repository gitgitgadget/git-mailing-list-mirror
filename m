From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: merge time
Date: Mon, 30 Jul 2007 09:44:03 +0200
Message-ID: <E49A2B0B-DAA3-4A03-925D-D3D113F907F1@zib.de>
References: <241612.78983.qm@web51007.mail.re2.yahoo.com> <alpine.LFD.0.999.0707291914451.3442@woody.linux-foundation.org> <6FE9FFD6-B5D7-4E1D-A4E8-B6D0E9517503@zib.de> <7vbqdumlo1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew L Foster <mfoster167@yahoo.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 09:43:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFPuj-00026c-Ve
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 09:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226AbXG3Hne (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 03:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754362AbXG3Hne
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 03:43:34 -0400
Received: from mailer.zib.de ([130.73.108.11]:50114 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754221AbXG3Hnd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 03:43:33 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l6U7hQ7k005722;
	Mon, 30 Jul 2007 09:43:27 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l6U7h9bO027931
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 30 Jul 2007 09:43:26 +0200 (MEST)
In-Reply-To: <7vbqdumlo1.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54198>


On Jul 30, 2007, at 8:48 AM, Junio C Hamano wrote:

> I tend to agree that it would make sense to allow something like:
>
>     $ git merge --no-fast-forward -m 'Merge topic XYZ' xyz

Another option could be to force a commit before the merge, even
if there are no changes to commit, something like

     $ git commit --force -m 'MARK'

[to my knowledge, --force or similar is not yet available]

	Steffen
