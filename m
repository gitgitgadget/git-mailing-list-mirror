From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 14/18] fsck: allow upgrading fsck warnings to errors
Date: Mon, 22 Dec 2014 23:01:11 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412222259070.21312@s15462909.onlinehome-server.info>
References: <cover.1418055173.git.johannes.schindelin@gmx.de> <c70409e8e6a42bdc7cacd19cbd49d5d1adbedd1a.1418055173.git.johannes.schindelin@gmx.de> <xmqq4mt3idho.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 23:01:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3B2W-00052Y-6h
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 23:01:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755716AbaLVWBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 17:01:16 -0500
Received: from mout.gmx.net ([212.227.15.19]:51460 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755707AbaLVWBP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 17:01:15 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0LedVG-1XXiMg1Tkk-00qSsS;
 Mon, 22 Dec 2014 23:01:12 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqq4mt3idho.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:RrzOMVts2bbFVlIYS2qVjyLg7zRtIncOy54yReZbp21XLANtjM0
 8nKiYZoWETERrS1/xc0XAjclBg4M2TWCM7dtUGiXqDxPkD5Wr2svGfCgMG2nuukkiCtR3NI
 noeg7bakrBMRDCFk+g//Vke299IuoKkYR9Mvxmur7FX7Poinhs1jRLKA+Sv6SYYFJYVPyWG
 bJI5Wl/xJZ76ZJW8MtRSA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261678>

Hi Junio,

On Wed, 10 Dec 2014, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > The 'invalid tag name' and 'missing tagger entry' warnings can now be
> > upgraded to errors by setting receive.fsck.invalid-tag-name and
> > receive.fsck.missing-tagger-entry to 'error'.
> 
> Hmm, why can't all warnings promotable to errors, or are the above
> two mentioned only as examples?

Those were the only ones that were always shown as warnings but never
treated as errors.

There is a third one coming, as part of the patches that will let fsck
warn about NTFS-incompatible file names, but I want to get this patch
series integrated into git.git first.

Ciao,
Dscho
