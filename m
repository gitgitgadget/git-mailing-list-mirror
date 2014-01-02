From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix safe_create_leading_directories() for Windows
Date: Thu, 2 Jan 2014 18:33:31 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1401021826120.1191@s15462909.onlinehome-server.info>
References: <52C5A039.6030408@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 02 18:33:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vym9J-0001KB-K7
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 18:33:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267AbaABRdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 12:33:33 -0500
Received: from mout.gmx.net ([212.227.17.21]:56471 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752750AbaABRdc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 12:33:32 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0LcmN9-1VXNoC1mKN-00k6Sv
 for <git@vger.kernel.org>; Thu, 02 Jan 2014 18:33:31 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <52C5A039.6030408@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:49eB8PJSCQdi/PpHsKS9mCMjv1i1Ms3/ERqg2f1d9/dDhBSzJXp
 WMMJCY2XtvrZ8KSeVTjsbOdpL9Lp6R33CC+8QqQIWZ/kYxjG0susuFotay/1Rn0dsSMVhz9
 hqQzDqI2K1Dv8VYPYP/I9TH3CmCmvOaNE6n5U8H6ftykPAlMxnwia2G7fBHE4fVE4jIX16m
 8zdi8wBt/dYekXDAR4owQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239860>

Hi,

On Thu, 2 Jan 2014, Sebastian Schuberth wrote:

> See https://github.com/msysgit/git/pull/80.

Thanks Sebastian!

However, since the git.git project is not comfortable with the concept of
pull requests (which is why you submitted this patch via mail), I believe
that we have to explain the rationale in the commit message. So here goes
my attempt:

-- snip --
On Linux, we can get away with assuming that the directory separator is a
forward slash, but that is wrong in general. For that purpose, the
is_dir_sep() function was introduced a long time ago. By using it in
safe_create_leading_directories(), we proof said function for use on
platforms where the directory separator is different from Linux'.
-- snap --

Hmm?
Dscho
