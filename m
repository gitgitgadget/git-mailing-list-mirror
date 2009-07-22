From: Greg Price <price@ksplice.com>
Subject: [PATCH v2 0/1] Fix rebase -p --onto
Date: Wed, 22 Jul 2009 12:37:38 -0400
Message-ID: <20090722163738.GO7503@vinegar-pot.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jul 22 18:37:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTepG-0000e4-5o
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 18:37:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443AbZGVQhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 12:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753416AbZGVQhq
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 12:37:46 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:37292 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751848AbZGVQhp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jul 2009 12:37:45 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n6MGbeXq026285;
	Wed, 22 Jul 2009 12:37:40 -0400 (EDT)
Received: from localhost (VINEGAR-POT.MIT.EDU [18.181.0.51])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n6MGbcLJ018705;
	Wed, 22 Jul 2009 12:37:38 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123754>

I sent a version of the following patch last week to fix the behavior
of rebase -p to respect --onto.  Some questions were raised and I
believe I've addressed all of them.

The code already distinguishes the cases Junio described in a natural
way, as demonstrated by a test case in the revised patch.  The use
case Hannes described has never worked, as Dscho explained, and in any
case concerns a different part of the code from this patch -- when the
great day comes that rebase -i -p can reorder commits, this patch will
work smoothly with that.

Are there further comments?  If not, I believe this is ready for merge.

Greg
