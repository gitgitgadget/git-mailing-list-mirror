From: Nanako Shiraishi <nanako3@bluebottle.com>
Subject: [BUG] "git clean" does not pay attention to its parameters
Date: Wed, 5 Dec 2007 15:54:06 +0900
Message-ID: <200712050654.lB56scKk000311@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Shawn Bohrer <shawn.bohrer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 07:55:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izo9s-00074G-7O
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 07:55:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbXLEGyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 01:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbXLEGyj
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 01:54:39 -0500
Received: from mi0.bluebottle.com ([206.188.25.15]:46946 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbXLEGyi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 01:54:38 -0500
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id lB56scKk000311
	for <git@vger.kernel.org>; Tue, 4 Dec 2007 22:54:38 -0800
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=Qj39WwB0TEFW/C4cIikT6dbUHDDOVZ72evnnQnY+znQsLfU+rm2m7tSN6RuRz1HPN
	bq0bPT2YSwITOj2+041Ssc0rA3P7+xjogcXRFgdgbqVQk/ilZmADTq9S8PhqCsL
Received: from nanako3.mail.bluebottle.com ([212.62.97.21])
	(authenticated bits=0)
	by fe0.bluebottle.com (8.13.1/8.13.1) with ESMTP id lB56sS89029106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 4 Dec 2007 22:54:36 -0800
X-Trusted-Delivery: <944d549676664f47b8fe428173467bf6>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67109>

In a repository with LaTeX documents, I tried to see what *.aux files are left behind after formatting, by running "git clean -n" with the latest git (1.5.3.7-1005-gdada0c1):

  % git clean -n '*.aux'

This however showed more than just '*.aux' files.  With the released version 1.5.3.6, the output is correctly limited to the files that match the pattern.

----------------------------------------------------------------------
Get a free email account with anti spam protection.
http://www.bluebottle.com/tag/2
