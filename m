From: Timur Tabi <timur@freescale.com>
Subject: Re: Unknown option: no-signed-off-by-cc (git-send-email)
Date: Mon, 03 Mar 2008 12:37:31 -0600
Message-ID: <47CC456B.6000203@freescale.com>
References: <47CC21F7.3020204@freescale.com> <47CC4423.8020109@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jon Loeliger <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 19:38:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWFYG-0001Xo-8I
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 19:38:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755135AbYCCShh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 13:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755033AbYCCShh
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 13:37:37 -0500
Received: from de01egw02.freescale.net ([192.88.165.103]:49882 "EHLO
	de01egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbYCCShg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 13:37:36 -0500
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id m23IbX92029230
	for <git@vger.kernel.org>; Mon, 3 Mar 2008 11:37:34 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m23IbWS5009297;
	Mon, 3 Mar 2008 12:37:32 -0600 (CST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.8.1.11) Gecko/20071128 SeaMonkey/1.1.7
In-Reply-To: <47CC4423.8020109@freescale.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75967>

Jon Loeliger wrote:

> Except that the "no" and "signed" are not separated by "-".

>From the man page:

       --no-signed-off-by-cc
              Do  not add emails found in Signed-off-by: lines to the cc list.

However, when I removed the "-", it worked.  So thanks for that.

It *used* to work with the "-", so I consider it a bug.

-- 
Timur Tabi
Linux kernel developer at Freescale
