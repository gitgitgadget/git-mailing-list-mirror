From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] mergetool merge/skip/abort
Date: Wed, 21 Jan 2009 19:49:53 +0100
Message-ID: <200901211949.53432.markus.heidelberg@web.de>
References: <81bfc67a0901210637j52fa7a55q51b599e9ff16f6dc@mail.gmail.com> <81bfc67a0901210817r49971c09kea9dc8ee5ae21572@mail.gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 19:51:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPiAP-0003N3-TP
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 19:51:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbZAUStp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 13:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbZAUStp
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 13:49:45 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:57663 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215AbZAUStp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 13:49:45 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id A8C22F6DA38F;
	Wed, 21 Jan 2009 19:49:43 +0100 (CET)
Received: from [89.59.73.85] (helo=pluto)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LPi91-00062F-00; Wed, 21 Jan 2009 19:49:43 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <81bfc67a0901210817r49971c09kea9dc8ee5ae21572@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19fku0j0bo5su8peRQZas7SA3wIVeW9UP+K8x24
	vETLMKs6edN3fpHdmEpwgu9HIcVGX9qScvGE0aCzLXys+dodKK
	IkvTJF0nIHFlXPZQnEGQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106638>

Caleb Cushing, 21.01.2009:
>  git-mergetool.sh |   24 ++++++++++++++++++++----
>  1 files changed, 20 insertions(+), 4 deletions(-)

> +               case "$ans" in
> +                       [mM]*)
> +                       break

I'd like to keep (additionally) the behaviour, that the merge starts
with just pressing <Enter>. Because what you mostly want to do, when
using git-mergetool, is actually merging.

> -    case "$merge_tool" in
> +       case "$merge_tool" in
>         kdiff3)

This doesn't seem right.

Markus
