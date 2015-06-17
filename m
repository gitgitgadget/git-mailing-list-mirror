From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: What's cooking in git.git (Jun 2015, #04; Tue, 16)
Date: Wed, 17 Jun 2015 13:39:09 +0200 (CEST)
Message-ID: <333261417.557730.1434541149518.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <xmqq616n5mb0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 13:38:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5BfK-0007wo-O1
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 13:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751AbbFQLhx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jun 2015 07:37:53 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:57903 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753366AbbFQLht convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 07:37:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 6E9C1488E7;
	Wed, 17 Jun 2015 13:37:47 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UBtmZxGQaWBd; Wed, 17 Jun 2015 13:37:47 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 588CB488E6;
	Wed, 17 Jun 2015 13:37:47 +0200 (CEST)
In-Reply-To: <xmqq616n5mb0.fsf@gitster.dls.corp.google.com>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Win)/8.0.9_GA_6191)
Thread-Topic: What's cooking in git.git (Jun 2015, #04; Tue, 16)
Thread-Index: HkgFJliEvscF8b7f+DT5V3M1MR0Nnw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271831>

Junio C Hamano <gitster@pobox.com> writes:
> * gr/rebase-i-drop-warn (2015-06-01) 2 commits
> - git rebase -i: warn about removed commits
> - git-rebase -i: add command "drop" to remove a commit
>
> Add "drop commit-object-name subject" command as another way to
> skip replaying of a commit in "rebase -i", and then punish those
> who do not use it (and instead just remove the lines) by throwing
> a warning.
>
> What's the status of this one?

A third commit was added (static check).

I have some corrections and refactoring to do after the reviewing=20
(and less time than before), a reroll is to be expected before=20
next week.

R=C3=A9mi
