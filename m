From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 5/6] Add regression tests for stricter tag fsck'ing
Date: Thu, 11 Sep 2014 16:15:46 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1409111614420.990@s15462909.onlinehome-server.info>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info> <cover.1410356761.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.1409101553080.990@s15462909.onlinehome-server.info> <xmqqbnqngy0z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 16:16:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XS5Ah-000643-PV
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 16:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754050AbaIKOQD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 10:16:03 -0400
Received: from mout.gmx.net ([212.227.15.19]:59790 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751298AbaIKOQB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 10:16:01 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0LvVUR-1YRqhF48ep-010bXM;
 Thu, 11 Sep 2014 16:15:47 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqbnqngy0z.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:sZcgY7Uxca5u/rveSbswUF1AJavgRUeX4Qr2gGOmdaeVyDmhtAM
 FPIL4FXleSKrM8oXJ+mdqFTh3jkeOUMWqMSmnmvk/3JCGHXIYwOB29sbMxlJB8QcYM07Jlu
 0bDZJ6/uWolH5HEKLPQUKiIESO71XZ1QHePzWkPHjPgoSmnYSuNfFDFqf3lqw/HM/spOpjZ
 vWGyORDadD4IvgwBCMUMg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256837>

Hi Junio,

On Wed, 10 Sep 2014, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > +	test_when_finished "git update-ref -d refs/tags/wrong" &&
> > +	git fsck --tags 2>out &&
> 
> I wonder what the command does with or without --tags option
> (applies to both tests added by this patch)?
> 
> Does running "fsck" without the option not to report broken tags
> detected by the new checks added in this series?  Should it?

fsck fails perfectly fine without the --tags option; this option just
triggers that fsck will show also the objects referenced by the tag
objects (which is nice for debugging).

Ciao,
Dscho
