From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 0/4] git-p4 test cleanup, commit time change
Date: Sun, 31 Jul 2011 09:44:16 -0400
Message-ID: <20110731134416.GB6564@arf.padd.com>
References: <20110731003557.GA4867@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sun Jul 31 15:44:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnWJd-0005BJ-Vf
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 15:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470Ab1GaNoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 09:44:21 -0400
Received: from honk.padd.com ([74.3.171.149]:41009 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746Ab1GaNoT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 09:44:19 -0400
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id 78382330B;
	Sun, 31 Jul 2011 06:44:19 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 45C943149A; Sun, 31 Jul 2011 09:44:16 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20110731003557.GA4867@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178251>

Re-spun, removing all of the original patch 2 now that Luke
pointed out that a new p4d is available.

Original intro:

    Here's a small patch series to clean up the git-p4 tests a bit,
    make them work on a 2-user eval p4d, and to fix a problem with
    the timestamp on the import commit.
