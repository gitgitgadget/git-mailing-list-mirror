From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git merge successfully however this is still issue from logical perspective
Date: Wed, 26 Oct 2011 14:27:03 +0200
Message-ID: <201110261427.03585.trast@student.ethz.ch>
References: <CAPgpnMSSOss=YxsMUZJ3E5TynDfHJG1i6PKitLBo_Tm7f=_+fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Lynn Lin <lynn.xin.lin@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 26 14:27:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJ2Ze-0007Op-CX
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 14:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932897Ab1JZM1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Oct 2011 08:27:09 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:39938 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932751Ab1JZM1H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2011 08:27:07 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.339.1; Wed, 26 Oct
 2011 14:27:03 +0200
Received: from thomas.inf.ethz.ch (188.155.176.28) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.339.1; Wed, 26 Oct
 2011 14:27:04 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.6-44-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <CAPgpnMSSOss=YxsMUZJ3E5TynDfHJG1i6PKitLBo_Tm7f=_+fQ@mail.gmail.com>
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184257>

Lynn Lin wrote:
> Hi all,
>    Do this case can happen? When I do merge from one branch to master
> branch,merge successfully however from code logical perspective it
> fails and It cause code compile (our project is using C++ language)

Sure.  The easiest example is when one side of a merge renames foo()
to bar(), while the other side introduces another call to foo() in an
unrelated part of the code.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
