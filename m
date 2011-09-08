From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: How to specify a default <start-point> for git branch
Date: Thu, 8 Sep 2011 12:11:34 +0200
Message-ID: <201109081211.34314.trast@student.ethz.ch>
References: <D3AA6127B29A3048B2939A08CC561AF55EDD6CDD0E@DEWDFECCR01.wdf.sap.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"jgit-dev@eclipse.org" <jgit-dev@eclipse.org>,
	"manuel.doniger@googlemail.com" <manuel.doniger@googlemail.com>
To: "Lay, Stefan" <stefan.lay@sap.com>
X-From: git-owner@vger.kernel.org Thu Sep 08 12:11:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1baC-0000FK-4Q
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 12:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758152Ab1IHKLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 06:11:38 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:38996 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754769Ab1IHKLh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 06:11:37 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.289.1; Thu, 8 Sep
 2011 12:11:33 +0200
Received: from thomas.inf.ethz.ch (129.132.153.219) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.289.1; Thu, 8 Sep
 2011 12:11:34 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.3-41-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <D3AA6127B29A3048B2939A08CC561AF55EDD6CDD0E@DEWDFECCR01.wdf.sap.corp>
X-Originating-IP: [129.132.153.219]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180961>

Lay, Stefan wrote:
> Is it possible in git to configure a default <start-point> for the git-branch command?

Literally as you propose it's probably not going to happen.  It would
break every script ever written that uses "git branch <foo>" to start
a new branch at the current commit.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
