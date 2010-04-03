From: Martin Mares <mj@ucw.cz>
Subject: Re: [PATCH 2/6] whitespace: add tab-in-indent error class
Date: Sat, 3 Apr 2010 12:02:26 +0200
Message-ID: <mj+md-20100403.100104.14382.nikam@ucw.cz>
References: <cover.1270250437.git.chris@arachsys.com> <c2612b53dc7105805a2455a4188667552b1ee606.1270250437.git.chris@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Sat Apr 03 12:12:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ny0Ks-0002lO-HT
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 12:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955Ab0DCKMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Apr 2010 06:12:10 -0400
Received: from nikam-dmz.ms.mff.cuni.cz ([195.113.20.16]:50960 "EHLO
	nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752694Ab0DCKMI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Apr 2010 06:12:08 -0400
X-Greylist: delayed 579 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Apr 2010 06:12:07 EDT
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id D64F19AC90E; Sat,  3 Apr 2010 12:02:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <c2612b53dc7105805a2455a4188667552b1ee606.1270250437.git.chris@arachsys.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143885>

Hello!

> +	if (rule & WS_TAB_IN_INDENT && rule & WS_INDENT_WITH_NON_TAB)
> +		die("cannot enforce both tab-in-indent and indent-with-non-tab");

Well, it would forbid any indented lines, which could possible make
sense for some file formats.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"This is an object-oriented system. If we change anything, the users object."
