From: Andreas Ericsson <ae@op5.se>
Subject: Re: StGit hooks
Date: Wed, 28 Nov 2007 12:44:02 +0100
Message-ID: <474D5482.5020609@op5.se>
References: <9e4733910711271417l32ed9a77p9915aa34a780665b@mail.gmail.com> <9e4733910711271512g790364e0ka4839b2be9fd4935@mail.gmail.com> <20071128093403.GB12977@diana.vm.bytemark.co.uk> <20071128101718.GA13940@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 12:44:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxLLD-0006Gw-TB
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 12:44:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758973AbXK1LoL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Nov 2007 06:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757486AbXK1LoK
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 06:44:10 -0500
Received: from mail.op5.se ([193.201.96.20]:54207 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755955AbXK1LoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 06:44:09 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id A90411F08040;
	Wed, 28 Nov 2007 12:44:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KXEdMNQjSw7r; Wed, 28 Nov 2007 12:44:05 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 807B11F08038;
	Wed, 28 Nov 2007 12:44:05 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <20071128101718.GA13940@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66291>

Karl Hasselstr=F6m wrote:
>=20
> Also, if StGit is to set up hooks automatically (commit hooks,
> pre-rebase hooks, whatever), it'd be nice to not have to worry about
> overwriting any existing hooks the user might have. But git currently
> allows only one hook script per hook, right?
>=20

Yes, but you can obviously call any number of scripts and programs
from within the hook that git executes.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
