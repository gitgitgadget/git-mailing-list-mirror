From: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH] userdiff: add built-in pattern for CSS
Date: Mon, 6 Jun 2016 22:45:42 +0200
Message-ID: <20160606204542.GA9280@Messiaen>
References: <20160524142537.19324-1-william.duclot@ensimag.grenoble-inp.fr>
 <20160602224809.5167-1-william.duclot@ensimag.grenoble-inp.fr>
 <57511B2D.7040501@kdbg.org>
 <20160603094544.GA3865@Messiaen>
 <xmqq8tymqnj9.fsf@gitster.mtv.corp.google.com>
 <20160606072800.GA3803@Messiaen>
 <xmqqinxmxkmx.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	simon.rabourg@ensimag.grenoble-inp.fr,
	antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 22:45:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA1PD-0008VO-PA
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 22:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874AbcFFUps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 16:45:48 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:43918 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751834AbcFFUpr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2016 16:45:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 3635520B4;
	Mon,  6 Jun 2016 22:45:44 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eSCs2O34jcDf; Mon,  6 Jun 2016 22:45:44 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 17DA520AE;
	Mon,  6 Jun 2016 22:45:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 1113C2066;
	Mon,  6 Jun 2016 22:45:44 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0xPNLkMyHSWy; Mon,  6 Jun 2016 22:45:44 +0200 (CEST)
Received: from Messiaen (mut38-h02-176-189-75-243.dsl.sta.abo.bbox.fr [176.189.75.243])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id B8FFE2055;
	Mon,  6 Jun 2016 22:45:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <xmqqinxmxkmx.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296566>

On Mon, Jun 06, 2016 at 11:00:38AM -0700, Junio C Hamano wrote:
> William Duclot <william.duclot@ensimag.grenoble-inp.fr> writes:
> 
> > On Fri, Jun 03, 2016 at 08:50:50AM -0700, Junio C Hamano wrote:
> >> William Duclot <william.duclot@ensimag.grenoble-inp.fr> writes:
> >> 
> >> > Here I have to disagree (with you and Junio): the IPATTERN is
> >> > case-insensitive only on the "pattern" regex, not the "word_regex"
> >> > regex.
> >> 
> >> Ahh, OK.  Obviously both of us overlooked that.  Thanks for pushing
> >> back.
> >> 
> >> > On the identifier line, I have "A-F" instead of "A-Z" though
> >> 
> >> Yeah, that does need updating.
> >
> > Note that I sent a V4 :)
> 
> Yup, thanks.  Isn't that what I queued as 0719f3ee (userdiff: add
> built-in pattern for CSS, 2016-06-03)?

It is, my bad
