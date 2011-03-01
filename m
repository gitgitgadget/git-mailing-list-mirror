From: Miles Bader <miles@gnu.org>
Subject: Re: [1.8.0] fix branch.autosetupmerge and branch.autosetuprebase
Date: Tue, 01 Mar 2011 10:39:41 +0900
Message-ID: <871v2rd3fm.fsf@catnip.gol.com>
References: <AANLkTi=Ei-Gr3=O0_dfaCekQ0+nB8v1kZYT7sTw-Ydm+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>, Dustin Sallings <dustin@spy.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 02:39:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuEZ8-0008Hy-Oo
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 02:39:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755403Ab1CABju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 20:39:50 -0500
Received: from smtp12.dentaku.gol.com ([203.216.5.74]:38530 "EHLO
	smtp12.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754056Ab1CABjt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 20:39:49 -0500
Received: from 218.231.234.87.eo.eaccess.ne.jp ([218.231.234.87] helo=catnip.gol.com)
	by smtp12.dentaku.gol.com with esmtpa (Dentaku)
	(envelope-from <miles@gnu.org>)
	id 1PuEYw-0006Af-N2; Tue, 01 Mar 2011 10:39:42 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id DB4D4DFA0; Tue,  1 Mar 2011 10:39:41 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <AANLkTi=Ei-Gr3=O0_dfaCekQ0+nB8v1kZYT7sTw-Ydm+@mail.gmail.com>
	(Jay Soffian's message of "Mon, 28 Feb 2011 17:37:49 -0500")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168178>

Jay Soffian <jaysoffian@gmail.com> writes:
> So, my proposal wrt to branch.autosetupmerge is that we deprecate it
> and always do the following:
>
> - When creating a local branch L from remote-tracking branch R, set R
> as upstream of L.
> - When creating a local branch L1 from other local branch L2, whose
> upstream is remote-tracking branch R, set R as upstream of L1.

That would certainly match my usage better...

-miles

-- 
Everywhere is walking distance if you have the time.  -- Steven Wright
