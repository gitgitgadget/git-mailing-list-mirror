From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 5/6] pull: allow interactive rebase
Date: Wed, 06 May 2015 07:43:20 +0200
Organization: gmx
Message-ID: <b186a33e222c4b4cc5759cfd58531b13@www.dscho.org>
References: <CACRoPnQ5_r-26J4gBHc27KZt3X9KAU7eFkA3vz_GE6_dP-Uyug@mail.gmail.com>
 <1430870453-5408-1-git-send-email-stephen.robin@gmail.com>
 <1430870453-5408-6-git-send-email-stephen.robin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: pyokagan@gmail.com, git@vger.kernel.org
To: Stephen Robin <stephen.robin@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 06 07:43:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yps7G-0008Jm-6l
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 07:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753844AbbEFFnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 01:43:25 -0400
Received: from mout.gmx.net ([212.227.17.20]:63823 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018AbbEFFnX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 01:43:23 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LfkJC-1ZaSOJ0ItW-00pPVy; Wed, 06 May 2015 07:43:21
 +0200
In-Reply-To: <1430870453-5408-6-git-send-email-stephen.robin@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:yiDbDqq6cRXLdsNbc78pLwqsxhUZKCmCcaT+BXXOhEaEIVIzz4A
 8F/124oEAtOeu5Qf5RZkvcUJbIP09iZQD6a4nd8bLZs4lSIrYk2boBtliYw3++55afmLpoZ
 SI1KkSzevWHCtOSPxipnfI+ZTkN0aPxfV1Z6pvWilnkzxmMYzk2bK1/8egU3PvUzd1yHkNa
 iPyezj7HFP2Bs1dqLeLnQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268447>

Hi Stephen,

On 2015-05-06 02:00, Stephen Robin wrote:

> Notes:
>     This feature is already present in msysgit.

Please note that it is "Git for Windows". The term "msysgit" just refers to the development environment required to compile Git for Windows 1.x and build its installer.

And yeah, I should contribute my changes already. Having said that, the --rebase=interactive support should not be a part of the initial conversion to a builtin because git-pull.sh as of git.git does not support it.

BTW Thanks for contributing the patch series, even if it is incomplete as you noted. I am sure that Paul (and for that matter, Stefan and I) will find it useful to see how you implemented the builtin `git pull`.

Ciao,
Johannes
