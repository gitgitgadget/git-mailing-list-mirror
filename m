From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Update index with a pickaxed diff
Date: Wed, 29 Dec 2010 14:54:51 +0100
Message-ID: <201012291454.52160.trast@student.ethz.ch>
References: <AANLkTi=BJ-8FaN+rk6_74mgM0PVzVP5uhV3aO1A3jUS3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Jeenu V <jeenuv@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 29 14:55:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXwUY-0004as-Cg
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 14:55:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852Ab0L2Nyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Dec 2010 08:54:55 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:40038 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752539Ab0L2Nyy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Dec 2010 08:54:54 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 29 Dec
 2010 14:54:25 +0100
Received: from pctrast.inf.ethz.ch (217.162.250.31) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 29 Dec
 2010 14:54:53 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc6-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <AANLkTi=BJ-8FaN+rk6_74mgM0PVzVP5uhV3aO1A3jUS3@mail.gmail.com>
X-Originating-IP: [217.162.250.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164310>

Jeenu V wrote:
> I'd like to know if there's a quick way of updating the index with the
> output of 'git diff -S<expr>'.

git diff <whatever> | git apply --cached

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
