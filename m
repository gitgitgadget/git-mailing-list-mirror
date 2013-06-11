From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: New feature discussion: git rebase --status
Date: Tue, 11 Jun 2013 15:19:44 +0200
Message-ID: <vpqbo7c4wen.fsf@anie.imag.fr>
References: <fb379a75c6c1af6dcff2e65bef1f1836@ensibm.imag.fr>
	<20130611125521.GL22905@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mathieu =?iso-8859-1?Q?Li=E9nard--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>, git@vger.kernel.org,
	Mathieu.Lienard--Mayor@ensimag.imag.fr,
	Jorge-Juan.Garcia-Garcia@ensimag.imag.fr
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Jun 11 15:19:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmOUL-0005ut-3D
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 15:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755600Ab3FKNTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 09:19:49 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35347 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755263Ab3FKNTs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 09:19:48 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5BDJhHW011226
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 11 Jun 2013 15:19:43 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UmOUD-0001wP-07; Tue, 11 Jun 2013 15:19:45 +0200
In-Reply-To: <20130611125521.GL22905@serenity.lan> (John Keeping's message of
	"Tue, 11 Jun 2013 13:55:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 11 Jun 2013 15:19:44 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227436>

John Keeping <john@keeping.me.uk> writes:

> The one piece of information that I often want is the SHA1 of the commit
> that is currently being applied.  Currently I have to look through my
> scrollback for the "stopping" message or poke around in .git/.
>
> Having that in the output of "git status" would be really nice,

... and should be rather easy as it is the content of
.git/rebase-merge/stopped-sha

Perhaps "git status" could say stg like "(applying 1d3fb08, 2/5)"

> output format you've posted is a big improvement over what we have at
> the moment for this case.

My idea when I wrote the item on the wiki was to keep the a very short
summary in "git status", and to put all the information one could whish
in a separate command. I'd describe it as a complement more than an
improvement ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
