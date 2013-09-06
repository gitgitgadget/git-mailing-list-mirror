From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 0/3] Unconfuse git clone when two branches at are HEAD.
Date: Fri, 6 Sep 2013 18:29:16 +0100
Organization: OPDS
Message-ID: <6649DD0E3B6B4CE59D330217786B6B05@PhilipOakley>
References: <20130906155204.GE12966@inner.h.apk.li>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Andreas Krey" <a.krey@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 19:28:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHzpV-00029Y-8p
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 19:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727Ab3IFR2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 13:28:16 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:59069 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750721Ab3IFR2P (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Sep 2013 13:28:15 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av4LAMoPKlJOl3GZ/2dsb2JhbABbgweJbrhkBAQBgSUXdGgBAYEfAQEUAQQBAQUIAQEuHgEBIQsCAwUCAQMOBwwlFAEEGgYHFwYBEggCAQIDAYU4BwGCEg0DE74PjQ6CboMkgQADiH2GEppMgTqBZzs
X-IPAS-Result: Av4LAMoPKlJOl3GZ/2dsb2JhbABbgweJbrhkBAQBgSUXdGgBAYEfAQEUAQQBAQUIAQEuHgEBIQsCAwUCAQMOBwwlFAEEGgYHFwYBEggCAQIDAYU4BwGCEg0DE74PjQ6CboMkgQADiH2GEppMgTqBZzs
X-IronPort-AV: E=Sophos;i="4.90,855,1371078000"; 
   d="scan'208";a="441276541"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip01ir2.opaltelecom.net with SMTP; 06 Sep 2013 18:28:13 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234066>

From: "Andreas Krey" <a.krey@gmx.de>
> Ok, here are some patches that make git actually
> check out the current remote branch when cloning.
>
> Up to now this failed when there were two branches that pointed to
> the HEAD commit of the remote repo, and git clone would sometimes
> choose the wrong one as the HEAD ref isn't transmitted in all
> transport.
>
> Stuff the HEAD ref into the capability list (assuming refs are clean
> enough to do that w/o escaping), and read them out on the other
> side. All other things were thankfully already in place.
>
> Two of the patches have Junio in the From as they are essentially his.
>
> Andreas
> --

Does this have any impact on the alleged bug in `git bundle --all` 
(which can then be cloned from) where the current HEAD ref wasn't 
included in the bundle? Or am I mis-remembering?

Philip 
