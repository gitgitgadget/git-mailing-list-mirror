From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 07/12] t4013: call git-merge instead of git-pull
Date: Thu, 07 May 2015 18:26:34 +0200
Organization: gmx
Message-ID: <a2c6df723ca5237c094ab4002e45a834@www.dscho.org>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
 <1430988248-18285-8-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 18:26:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqOdM-0006lr-VB
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 18:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036AbbEGQ0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 12:26:43 -0400
Received: from mout.gmx.net ([212.227.17.20]:50883 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752031AbbEGQ0m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 12:26:42 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MBrCt-1YzVZE038h-00Ao3a; Thu, 07 May 2015 18:26:35
 +0200
In-Reply-To: <1430988248-18285-8-git-send-email-pyokagan@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:iJmzp8ofqgz9RoA2bnkdC8DZinMvh4ju1l5kqmMRPQ1LsY5QgIV
 vlrNBl8ZlzOZpX76OqzzLlJ45S4vad5Ff/7oemAM3rPneh7lGI2sY4nXsM182/8jmWogVIf
 pTuLGYfwMFEMPogkfv6J/c1AEJTSe9whLneIUc5O5oP0eZdSDoiOGmmh412LU+GeHUfibig
 MewDGQ84MjBnlG9Ex/37g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268542>

Hi Paul,

sorry for being so slow on reviewing your patches, but I saw that plenty of excellent feedback has made the second round of patches even better than the first one.

I am particularly impressed by the thoroughness of the commit messages, they make reviewing much more pleasant.

On 2015-05-07 10:44, Paul Tan wrote:

> As such, replace the call to git-pull with a call to git-merge to reduce
> the dependence on git-pull's functionality to reduce irrelevant test
> breakage when git-pull is rewritten to C.

Both this patch and 9/12 change `git pull` invocations to equivalent non-pull ones, but I wonder whether it would not be a better idea to leave them as-are, so that we can make sure that scripts out there that might use similar `git pull` invocations would be unaffected by the rewrite?

Ciao,
Dscho
