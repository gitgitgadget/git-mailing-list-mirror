From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] diff: Support diff.color-words config option
Date: Wed, 21 Jan 2009 20:37:06 +0100
Message-ID: <200901212037.07014.markus.heidelberg@web.de>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de> <200901201842.24000.markus.heidelberg@web.de> <alpine.DEB.1.00.0901202202370.3586@pacific.mpi-cbg.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Santi =?iso-8859-1?q?B=E9jar?= <santi@agolina.net>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Teemu Likonen <tlikonen@iki.fi>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 21 20:38:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPiuM-0005k9-HA
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 20:38:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbZAUThA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 14:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbZAUTg7
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 14:36:59 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:42392 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbZAUTg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 14:36:59 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id B94DCF93D2B7;
	Wed, 21 Jan 2009 20:36:57 +0100 (CET)
Received: from [89.59.73.85] (helo=pluto)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LPisi-0004QI-00; Wed, 21 Jan 2009 20:36:56 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0901202202370.3586@pacific.mpi-cbg.de>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/MMLXzpDJPyYIrfPy1m/SdoWjDwqCyEIZYpJvu
	PMc1nbeWnIqHblKjIsc+MhgWvtirvNGwyUcUbezjJZoqVRhKMQ
	xE9X3CvRe95difI75ozA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106653>

Johannes Schindelin, 20.01.2009:
> Hi,
> 
> On Tue, 20 Jan 2009, Markus Heidelberg wrote:
> 
> > Junio C Hamano, 20.01.2009:
> > > None of the existing configuration variables defined use hyphens in
> > > multi-word variable names.
> > 
> > Except for diff.suppress-blank-empty
> > Should it be converted or is it intention to reflect GNU diff's option?
> 
> Grumble.  It's in v1.6.1-rc1~348, so we cannot just go ahead and fix it.

Did I say change it without keeping backward compatibility?

> Ciao,
> Dscho "who loves consistency, and knows new users appreciate it, too"

Me, too.

Markus
