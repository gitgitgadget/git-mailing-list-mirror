From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] Documentation: fix description for enabling hooks
Date: Wed, 17 Dec 2008 20:55:45 +0100
Message-ID: <200812172055.45905.markus.heidelberg@web.de>
References: <200812170359.24109.markus.heidelberg@web.de> <4948ADE8.2050804@viscovery.net> <20081217143627.GB5691@genesis.frugalware.org>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, gitster@pobox.com,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Dec 17 20:57:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD2Vm-0000NK-Ay
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 20:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbYLQTza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 14:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbYLQTz3
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 14:55:29 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:36057 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbYLQTz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 14:55:29 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id C5489F58296D;
	Wed, 17 Dec 2008 20:55:27 +0100 (CET)
Received: from [91.19.64.135] (helo=pluto)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.109 #226)
	id 1LD2UR-0008HW-00; Wed, 17 Dec 2008 20:55:27 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <20081217143627.GB5691@genesis.frugalware.org>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX189dGVd48GyCTL6QJyM+Euqk8o1FblpVVA60A0Y
	sTspmktfpLoVHXzK542i3UALU2KtRotQ5oEvqyPsTwX0qqm9Xf
	qiX+7G3HjLqxhxWx/rhQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103376>

Miklos Vajna, 17.12.2008:
> On Wed, Dec 17, 2008 at 08:44:40AM +0100, Johannes Sixt <j.sixt@viscovery.net> wrote:
> > > This is true, but having the executable bit is necessary as well. I
> > > think it would be better to just append this requirement instead of
> > > replacing the old one with this.
> > 
> > Markus's proposed new wording is correct because the .sample hooks *are*
> > already executable.
> 
> I thought about the following situation: The user reads the
> documentation while working in an older repo (initialized a few versions
> ago). S/he sees that the .sample suffix is already missing, so s/he
> assumes that the hook is already active. Which is not true, because the
> +x bit is missing.

Valid point, I think, but not critical in this case, since the patch
only affected gitrepository-layout(5) and gitglossary(7).

When you want to learn how to use hooks, you will probably rather read
githooks(5), where the need for the executable bit is not even
explicitly mentioned. Maybe it should be added there?

Markus
