From: "Luke-Jr" <luke@dashjr.org>
Subject: Re: [PATCH 1/5] port --ignore-unmatch to "git add"
Date: Fri, 14 Aug 2009 15:47:08 -0500
Message-ID: <200908141547.09814.luke@dashjr.org>
References: <200908121726.52121.luke-jr@utopios.org> <7vws56i35q.fsf@alter.siamese.dyndns.org> <200908141539.18087.luke@dashjr.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	Luke Dashjr <luke-jr+git@utopios.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 22:47:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc3gI-00079B-Hd
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 22:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505AbZHNUrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 16:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752173AbZHNUrM
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 16:47:12 -0400
Received: from unused ([66.216.20.21]:53689 "EHLO zinan.dashjr.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753158AbZHNUrL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 16:47:11 -0400
Received: from tsuruki.localnet (ip70-187-26-118.om.om.cox.net [70.187.26.118])
	(Authenticated sender: luke-jr)
	by zinan.dashjr.org (Postfix) with ESMTPSA id 7403CB9C252;
	Fri, 14 Aug 2009 20:47:12 +0000 (UTC)
User-Agent: KMail/1.12.0 (Linux/2.6.27-gentoo-r7; KDE/4.3.0; x86_64; ; )
In-Reply-To: <200908141539.18087.luke@dashjr.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125952>

Specific use-case of "git add --ignore-unmatched":
	http://gitorious.org/gitbackup

Without this functionality, daily race conditions will break the 
synchronisation.
