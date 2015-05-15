From: Ed Avis <eda@waniasset.com>
Subject: Re: [PATCH] Documentation/log: clarify what --raw means
Date: Fri, 15 May 2015 15:47:24 +0000 (UTC)
Message-ID: <loom.20150515T174530-547@post.gmane.org>
References: <297757279.1883703.1431704571028.JavaMail.zimbra@imag.fr> <1431704674-18595-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 15 17:47:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtHpq-0006XK-BQ
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 17:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934709AbbEOPrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 11:47:33 -0400
Received: from plane.gmane.org ([80.91.229.3]:40440 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934690AbbEOPrd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 11:47:33 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YtHpi-0006Sd-GY
	for git@vger.kernel.org; Fri, 15 May 2015 17:47:30 +0200
Received: from 80.169.169.174 ([80.169.169.174])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 May 2015 17:47:30 +0200
Received: from eda by 80.169.169.174 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 May 2015 17:47:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.169.169.174 (Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:38.0) Gecko/20100101 Firefox/38.0 Cyberfox/38.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269155>

Thanks, I think that is a bit clearer.

You might also need to clarify the part about --format=raw where it says
'SHA-1s are displayed in full, regardless of whether --abbrev or --no-abbrev'.
That does not currently apply to the diffs, where --no-abbrev still needs to
be explicitly given.

-- 
Ed Avis <eda@waniasset.com>
