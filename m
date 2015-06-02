From: Remi LESPINET <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH/RFC v2 2/2] git-am: add am.threeWay config variable
Date: Tue, 02 Jun 2015 15:52:09 +0200
Message-ID: <87vbf6tdyu.fsf@ensimag.grenoble-inp.fr>
References: <1433251472-29460-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1433251472-29460-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<vpqvbf6jko8.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 02 15:52:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzmc6-0004GL-HL
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 15:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759013AbbFBNwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 09:52:14 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:34104 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753884AbbFBNwN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jun 2015 09:52:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id C660427E8;
	Tue,  2 Jun 2015 15:52:11 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8aYy3mMVs8hR; Tue,  2 Jun 2015 15:52:11 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id B5A9327B2;
	Tue,  2 Jun 2015 15:52:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id AB97A20E4;
	Tue,  2 Jun 2015 15:52:11 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v9tkwWkrG0E8; Tue,  2 Jun 2015 15:52:11 +0200 (CEST)
Received: from Groseille (wificampus-030200.grenet.fr [130.190.30.200])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 7756020DD;
	Tue,  2 Jun 2015 15:52:11 +0200 (CEST)
In-Reply-To: <vpqvbf6jko8.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	02 Jun 2015 15:37:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270535>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:
>
> > +if test "$(git config --bool --get am.threeWay)" = true
> > +then
> > +    threeway=t
> > +fi
>
> I think you missed Paul's remark on this:
>
> http://article.gmane.org/gmane.comp.version-control.git/270150
>
> Not terribly important since am will be rewritten soon, though.

Oh right, sorry about that, I modify it and I resend the patch asap
