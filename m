From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCHv1 0/3] git p4: tag import/export bug fixes
Date: Fri, 11 May 2012 06:21:43 -0400
Message-ID: <20120511102143.GA2468@padd.com>
References: <1336717518-4214-1-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Fri May 11 12:20:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSmxl-0005l1-Fr
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 12:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757787Ab2EKKUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 06:20:34 -0400
Received: from honk.padd.com ([74.3.171.149]:55560 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752301Ab2EKKUd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 06:20:33 -0400
Received: from tic.padd.com (unknown [50.55.155.59])
	by honk.padd.com (Postfix) with ESMTPSA id AC8B3CF0;
	Fri, 11 May 2012 03:20:32 -0700 (PDT)
Received: by tic.padd.com (Postfix, from userid 1000)
	id 3B68C100891; Fri, 11 May 2012 06:21:43 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1336717518-4214-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197662>

luke@diamand.org wrote on Fri, 11 May 2012 07:25 +0100:
> This patch series fixes two bugs in my git p4 import/export code, and
> adds a test case for them.
> 
> Luke Diamand (3):
>   git p4: add test for tag import/export enabled via config
>   git p4: fix bug when verbose enabled with tag export
>   git p4: fix bug when enabling tag import/export via config variables
> 
>  git-p4.py                      |    6 +++---
>  t/t9811-git-p4-label-import.sh |   20 ++++++++++++++++++++
>  2 files changed, 23 insertions(+), 3 deletions(-)

These fixes look obviously good, and maint-worthy.  Ack.

		-- Pete
