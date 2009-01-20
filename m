From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] diff: Support diff.color-words config option
Date: Tue, 20 Jan 2009 18:42:23 +0100
Message-ID: <200901201842.24000.markus.heidelberg@web.de>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de> <200901192145.21115.bss@iguanasuicide.net> <7v1vuympie.fsf@gitster.siamese.dyndns.org>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Santi =?iso-8859-1?q?B=E9jar?= <santi@agolina.net>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Teemu Likonen <tlikonen@iki.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 18:44:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPKdh-0005oI-7G
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 18:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757276AbZATRmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 12:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754995AbZATRmY
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 12:42:24 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:41850 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292AbZATRmX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 12:42:23 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 3AEBBF6CCE2B;
	Tue, 20 Jan 2009 18:42:20 +0100 (CET)
Received: from [89.59.121.55] (helo=pluto)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LPKcF-000537-00; Tue, 20 Jan 2009 18:42:19 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <7v1vuympie.fsf@gitster.siamese.dyndns.org>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18tmNznnUZ0JVJDE5YK5L0CBzaGiEauhP+gux5Y
	QXHxW3BhM6gyjJbIso0D6jneiR6F4DsDo3/iTi2VnTaiD6D0FH
	hokwoFS65ci8boaKZycw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106502>

Junio C Hamano, 20.01.2009:
> "Boyd Stephen Smith Jr." <bss@iguanasuicide.net> writes:
> 
> > When diff is invoked with --color-words (w/o =regex), use the regular
> > expression the user has configured as diff.color-words.
> >
> > diff drivers configured via attributes take precedence over the
> > diff.color-words setting.  If the user wants to change them, they have
> > their own configuration variables.
> 
> This needs an entry in Documentation/config.txt
> 
> None of the existing configuration variables defined use hyphens in
> multi-word variable names.

Except for diff.suppress-blank-empty
Should it be converted or is it intention to reflect GNU diff's option?

Markus
