From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH 0/1] Re-roll of the test fix for sed on solaris
Date: Mon,  9 Jan 2012 21:47:32 -0500
Message-ID: <1326163653-26565-1-git-send-email-bwalton@artsci.utoronto.ca>
References: <7vd3b0vc6h.fsf@alter.siamese.dyndns.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jan 10 03:47:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkRkX-0008NB-Gt
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 03:47:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755991Ab2AJCrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 21:47:39 -0500
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:54303 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755968Ab2AJCri (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 21:47:38 -0500
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:59772 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1RkRkP-0000Ss-04; Mon, 09 Jan 2012 21:47:37 -0500
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1RkRkO-0006v3-VO; Mon, 09 Jan 2012 21:47:36 -0500
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <7vd3b0vc6h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188209>

Hi Junio,

It seems that you were correct in that it's the exit status from sed
that ultimately causes the breakage.  I've updated the commit message
to reflect this.

Thanks
-Ben
