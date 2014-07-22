From: Robert Luberda <robert@debian.org>
Subject: Two gitweb bugs related to javascript-actions
Date: Tue, 22 Jul 2014 22:41:43 +0200
Organization: Debian
Message-ID: <53CECC87.7030209@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 22 23:14:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9hNx-0001S4-45
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 23:14:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbaGVVOE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 17:14:04 -0400
Received: from master.debian.org ([82.195.75.110]:33096 "EHLO
	master.debian.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932135AbaGVVOD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 17:14:03 -0400
X-Greylist: delayed 1922 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Jul 2014 17:14:03 EDT
Received: from localhost ([::1] helo=vox.robbo.home)
	by master.debian.org with esmtp (Exim 4.80)
	(envelope-from <robert@debian.org>)
	id 1X9gsn-0005H4-RA
	for git@vger.kernel.org; Tue, 22 Jul 2014 20:41:57 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by vox.robbo.home (Postfix) with ESMTP id 50530E2B2D
	for <git@vger.kernel.org>; Tue, 22 Jul 2014 22:41:44 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254039>

Hi

Some time ago I reported the two following bugs to Debian BTS,
could you please look at them?

  1. http://bugs.debian.org/741883 -- gitweb blame does not work
correctly when $feature{'javascript-actions'} is enabled

This should be one-line change fix, which I really would like to be
applied to the git package itself, not to do the same change over and
over again every time my gitweb package is updated on my system.

  2. https://bugs.debian.org/741884 feature{'javascript-actions'} breaks
external links

This might be more challenging, but the simplest approach would be avoid
adding those strange '[#?]js=1' parts to non-gitweb-generated links.

Thanks a lot,
robert
