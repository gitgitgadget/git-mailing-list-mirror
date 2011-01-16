From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: panic recovery
Date: Sun, 16 Jan 2011 14:11:22 +0100
Message-ID: <201101161411.22422.trast@student.ethz.ch>
References: <AANLkTikBjWU_dm1a+2AQyP-bhdO_WtYJ8OdE7Zs3E=kV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Eda Ercan <edaercan@gmail.com>
To: Levend Sayar <levendsayar@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 16 14:11:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PeSON-0000IA-Vj
	for gcvg-git-2@lo.gmane.org; Sun, 16 Jan 2011 14:11:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830Ab1APNL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jan 2011 08:11:26 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:41118 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752359Ab1APNLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jan 2011 08:11:25 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sun, 16 Jan
 2011 14:11:09 +0100
Received: from pctrast.inf.ethz.ch (217.162.250.31) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sun, 16 Jan
 2011 14:11:23 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <AANLkTikBjWU_dm1a+2AQyP-bhdO_WtYJ8OdE7Zs3E=kV@mail.gmail.com>
X-Originating-IP: [217.162.250.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165165>

By the way:

Levend Sayar wrote:
> Yesterday one of my colleague tried to commit her two weeks of work.

If you really mean she wanted to make the first commit in two weeks,
that is just wrong.  Usually you should commit at least every few
hours, and changes should be small and self-contained.  Even in the
case of starting a new project or self-contained module, you should
commit a lot so you can go back to an older state if required.  You
can use rebase -i later to clean up the work-in-progress commits.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
