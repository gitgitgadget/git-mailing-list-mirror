From: John Keeping <john@keeping.me.uk>
Subject: Re: git log - crash and core dump
Date: Wed, 17 Apr 2013 09:27:01 +0100
Message-ID: <20130417082701.GP2278@serenity.lan>
References: <CANKwXW1EXLiWgdVM4+k_11wu1Nyixp05PUXmQYP_gUXQKek_OA@mail.gmail.com>
 <516D93C4.1000100@lsrfire.ath.cx>
 <7v61zml0ow.fsf@alter.siamese.dyndns.org>
 <516DBE2E.4060201@lsrfire.ath.cx>
 <7vzjwyi0ba.fsf@alter.siamese.dyndns.org>
 <CANKwXW2h1+CGw2M3CmeXzXAX+wdCPgs5Ff_bGvTgYVpkwpijUw@mail.gmail.com>
 <CANKwXW0WkZXJMi+6T8ymvTi5-JpRfrn_xKmjGw-FsXpaCGuK5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ivan Lyapunov <dront78@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 10:27:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USNi3-0001BA-R1
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 10:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754961Ab3DQI1N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Apr 2013 04:27:13 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:61000 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754040Ab3DQI1M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 04:27:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 476D8CDA66F;
	Wed, 17 Apr 2013 09:27:11 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xkkULR8antRp; Wed, 17 Apr 2013 09:27:10 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id A213FCDA5D2;
	Wed, 17 Apr 2013 09:27:10 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 8A0F9161E529;
	Wed, 17 Apr 2013 09:27:10 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id seQ26EvAcVfr; Wed, 17 Apr 2013 09:27:06 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 753BE161E528;
	Wed, 17 Apr 2013 09:27:03 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CANKwXW0WkZXJMi+6T8ymvTi5-JpRfrn_xKmjGw-FsXpaCGuK5g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221519>

On Wed, Apr 17, 2013 at 09:22:01AM +0400, Ivan Lyapunov wrote:
> I checked Ren=E9 Scharfe's patch and it works - no more git log crash=
=2E
> Also I checked a broken commits by git show and the most of them
> created by me. I can confirm I never used anyting else except console
> git commit or netbeans gui to commit, which is just git gui wrapper
> tool.

Doesn't NetBeans use JGit[1]?  That makes it a bit more than a wrapper
for the Git command line tools.

[1] http://eclipse.org/jgit/
