From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH/RFC 2/2] git rebase -i: Warn removed or dupplicated
 commits
Date: Thu, 28 May 2015 09:44:07 +0200 (CEST)
Message-ID: <1388345544.70438.1432799047393.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1432676318-22852-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <1432676318-22852-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <CAPig+cQJMSjS=fiwMHE93efSsa2QYQ8TphyyfcLg7kAXRi_+cw@mail.gmail.com> <579982712.39028.1432732759119.JavaMail.zimbra@ensimag.grenoble-inp.fr> <xmqq1ti1n825.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 28 09:44:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxsU7-0002W4-VC
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 09:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836AbbE1HoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 03:44:07 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:54201 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752764AbbE1HoD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 May 2015 03:44:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id A6AD32792;
	Thu, 28 May 2015 09:44:00 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rQdU5ko77Zn6; Thu, 28 May 2015 09:44:00 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 951802789;
	Thu, 28 May 2015 09:44:00 +0200 (CEST)
In-Reply-To: <xmqq1ti1n825.fsf@gitster.dls.corp.google.com>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: git rebase -i: Warn removed or dupplicated commits
Thread-Index: NstyogYCh9DKFWPZhu27454ohqeD9w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270127>

Junio C Hamano <gitster@pobox.com> writes:
> I think there is a difference between (silently) accepting just to
> be lenient and documenting and advocating mixed case uses.
> 
> Personally, I'd rather not to see gratuitous flexibility to allow
> the same thing spelled in 47 different ways for no good reason.

It was more of a mistake on our part rather than actually wanting to
document mixed case uses.

In the v2 of the patch (not sent to the mailing list yet since we want
to take into consideration the conclusion of this discussion before)
it is entirely in lower case in both the documentation and the code
while we silently allow upper and mixed case.
