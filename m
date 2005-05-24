From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: [PATCH] diff-raw format update take #2.
Date: Tue, 24 May 2005 03:39:33 +0200
Message-ID: <20050524013933.GD12141@cip.informatik.uni-erlangen.de>
References: <Pine.LNX.4.58.0505231758350.2307@ppc970.osdl.org> <Pine.LNX.4.62.0505231827430.4200@qynat.qvtvafvgr.pbz> <211e617258d9d993810f3c88bace255e.IBX@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Lang <david.lang@digitalinsight.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 03:39:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaONF-0006Iz-RO
	for gcvg-git@gmane.org; Tue, 24 May 2005 03:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVEXBjx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 21:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVEXBjx
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 21:39:53 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:50599 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261271AbVEXBjw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2005 21:39:52 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4O1dYS8006027
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 May 2005 01:39:34 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4O1dXuk006026;
	Tue, 24 May 2005 03:39:33 +0200 (CEST)
To: Chris Wedgwood <cw@f00f.org>
Mail-Followup-To: Chris Wedgwood <cw@f00f.org>,
	David Lang <david.lang@digitalinsight.com>,
	Linus Torvalds <torvalds@osdl.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <211e617258d9d993810f3c88bace255e.IBX@taniwha.stupidest.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,
for me the diff/patch works for *spaces*, but screw up on tabs in
filenames. Why? Because the field sep for filenames is *tab*. So patch
believes that everything before the first tab is the filename.

	Thomas
