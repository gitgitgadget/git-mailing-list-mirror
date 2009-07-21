From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH] configure: use AC_SEARCH_LIBS instead of AC_CHECK_LIB
Date: Tue, 21 Jul 2009 10:12:31 -0500
Message-ID: <ROnxPc_FlcxpQoCOZcOfoalyiRYK1R7qCAowbfiQsNLLI8qrrtJEUw@cipher.nrlssc.navy.mil>
References: <m34ot9c67t.fsf_-_@localhost.localdomain> <a52be8ba36206abc5ff5c91a759036a931e2658c.1248007036.git.nicolas.s.dev@gmx.fr> <6WnEB0at_uuAu9kicWjrHLsBbTv58WtCNOANkKzk-SqTgqjuWyh8WA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Jeff King <peff@peff.net>, David Syzdek <david@syzdek.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Tue Jul 21 17:14:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTH2W-00047r-HE
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 17:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755267AbZGUPNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 11:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755234AbZGUPND
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 11:13:03 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:53019 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755241AbZGUPNC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 11:13:02 -0400
Received: by mail.nrlssc.navy.mil id n6LFCVGa007267; Tue, 21 Jul 2009 10:12:31 -0500
In-Reply-To: <6WnEB0at_uuAu9kicWjrHLsBbTv58WtCNOANkKzk-SqTgqjuWyh8WA@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 21 Jul 2009 15:12:31.0653 (UTC) FILETIME=[AB363D50:01CA0A15]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123662>

Brandon Casey wrote:
> A question about AC_SEARCH_LIBS:
> 
> With AC_SEARCH_LIBS, which of [action-if-found] or [action-if-not-found]
> is executed if the function is found in the standard c library i.e. "calling
> `AC_LINK_IFELSE([AC_LANG_CALL([], [function])])' first with no libraries"?

btw, the "`AC_LINK_IFELSE(..." line is from the autoconf documentation.  It is
the first thing that AC_SEARCH_LIBS does.  It tries to link without any of the
specified libraries first, then it iterates trying to link using each specified
library, stopping when it is successful.

If you didn't recognize that that line was from the documentation, it may be
confusing.

-brandon
