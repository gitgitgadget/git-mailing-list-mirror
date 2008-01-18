From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] Fix random fast-import errors when compiled with NO_MMAP
Date: Fri, 18 Jan 2008 09:26:52 +0000
Message-ID: <20080118092652.GA22052@hashpling.org>
References: <20080118032222.GX24004@spearce.org> <20080118035700.GA3458@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 10:27:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFnVq-00040Y-Nw
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 10:27:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754655AbYARJ1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 04:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753142AbYARJ1J
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 04:27:09 -0500
Received: from pih-relay05.plus.net ([212.159.14.132]:40887 "EHLO
	pih-relay05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752946AbYARJ1H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 04:27:07 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay05.plus.net with esmtp (Exim) id 1JFnV6-0007kn-4q; Fri, 18 Jan 2008 09:27:00 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m0I9QsG6000596;
	Fri, 18 Jan 2008 09:26:54 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m0I9QrPr000595;
	Fri, 18 Jan 2008 09:26:53 GMT
Content-Disposition: inline
In-Reply-To: <20080118035700.GA3458@spearce.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70981>

I can ACK this as fixing the test suite failures on Mac OS X 10.4.11
both with and without NO_MMAP=Yes on top of 1.5.4.rc3.24.gb53139 and
also on my oldish Fedora install with NO_MMAP=Yes.

Acked-by: Charles Bailey <charles@hashpling.org>
