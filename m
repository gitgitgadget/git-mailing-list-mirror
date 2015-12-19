From: Yaroslav Halchenko <yoh@onerussian.com>
Subject: Re: git leaves behind .git/COMMIT_EDITMSG non-shared in --shared non-bare repo
Date: Sat, 19 Dec 2015 10:01:20 -0500
Message-ID: <1CDB6F0D-B48B-473D-A043-0AA38A808B43@onerussian.com>
References: <20151218195503.GA4554@onerussian.com> <alpine.DEB.2.20.1512191137450.6483@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Dec 19 16:01:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAJ0q-0005k4-Go
	for gcvg-git-2@plane.gmane.org; Sat, 19 Dec 2015 16:01:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbbLSPBc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2015 10:01:32 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:57256 "EHLO
	smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964788AbbLSPBb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2015 10:01:31 -0500
Received: from obi202.kiewit.dartmouth.edu ([129.170.166.68] helo=[192.168.1.14])
	by smtp.onerussian.com with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <yoh@onerussian.com>)
	id 1aAJ0j-0004Pf-SJ; Sat, 19 Dec 2015 10:01:31 -0500
User-Agent: K-9 Mail for Android
In-Reply-To: <alpine.DEB.2.20.1512191137450.6483@virtualbox>
X-SA-Exim-Connect-IP: 129.170.166.68
X-SA-Exim-Rcpt-To: Johannes.Schindelin@gmx.de, git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on smtp.onerussian.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	DNS_FROM_AHBL_RHSBL autolearn=no version=3.3.2
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282746>

fwiw that file is created not only by interactive tasks by with a regular commit -m msg as well.

On December 19, 2015 5:40:43 AM EST, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>Hi Yaroslav,
>
>On Fri, 18 Dec 2015, Yaroslav Halchenko wrote:
>
>> Not sure for what batch operations that file is actually useful,
>
>None. This file is written when you commit interactively. It is deleted
>afterwards, unless aborted in a fatal manner.
>
>So I would try to find out who the heck is working interactively
>without
>finishing their commit message in that shared directory.
>
>Ciao,
>Johannes

-- 
Sent from a phone which beats iPhone.
