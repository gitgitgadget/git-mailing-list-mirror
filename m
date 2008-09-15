From: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
Subject: Re: [PATCH 3/3] t9700/test.pl: remove File::Temp requirement
Date: Mon, 15 Sep 2008 20:27:34 +0200
Message-ID: <48CEA916.9000103@statsbiblioteket.dk>
References: <uWiPWIPu6IKkVafz9wdZ-sRK84QZuJQNOZM80bkfw24NxsVT-Z3J9g@cipher.nrlssc.navy.mil> <dQSOPLs4uHkUBp4B1ZT4QbBf2xm6SluHuVl0M4fikzSgHUtgDcJXiQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Sep 15 20:29:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfIok-0000xj-W9
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 20:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091AbYIOS1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 14:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753085AbYIOS1t
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 14:27:49 -0400
Received: from sbexch03.sb.statsbiblioteket.dk ([130.225.24.68]:58102 "EHLO
	sbexch03.sb.statsbiblioteket.dk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752842AbYIOS1t (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Sep 2008 14:27:49 -0400
Received: from ares.tgcnet (130.225.25.246) by sbexch03.sb.statsbiblioteket.dk
 (130.225.24.68) with Microsoft SMTP Server (TLS) id 8.1.291.1; Mon, 15 Sep
 2008 20:27:46 +0200
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <dQSOPLs4uHkUBp4B1ZT4QbBf2xm6SluHuVl0M4fikzSgHUtgDcJXiQ@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95927>

Brandon Casey wrote:
> The object oriented version of File::Temp is a rather new incarnation it
> seems. The File::Temp man page for v5.8.0 says "(NOT YET IMPLEMENTED)" in
> the 'Objects' section. Instead of creating a file with a unique name in
> the system TMPDIR, we can create our own temporary file with a static
> name and use that instead.
> 
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
 >
Tested-by: Tom G. Christensen <tgc@statsbiblioteket.dk>

I applied all three patches and ran the testsuite with perl 5.8.0 
(RHEL3). It now passes t9700 and runs to completion as expected.

-tgc
