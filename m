From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] sequencer.c: abbreviate hashs placed in the middle of messages
Date: Sun, 10 May 2015 11:05:41 +0200
Message-ID: <vpqwq0g2462.fsf@anie.imag.fr>
References: <1431104035-2056-1-git-send-email-ralf.thielow@gmail.com>
	<CAPig+cSeNn0r7N6vp+qs4NTNwfYx5p-zUX3tkifuXLu+nB2yNQ@mail.gmail.com>
	<xmqqbnhvm1f5.fsf@gitster.dls.corp.google.com>
	<CAN0XMOKPbKUMwU5-T78m_knt=9O2GkKaqmXKViSi5k-Z7Damrg@mail.gmail.com>
	<xmqqtwvmlxlo.fsf@gitster.dls.corp.google.com>
	<CAN0XMO+ZY-oXb1aWK3TzUxDRuBEEoasxjdagYQQoB+JVheju9Q@mail.gmail.com>
	<xmqqa8xekeb2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ralf Thielow <ralf.thielow@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 10 11:06:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrNBP-0003qC-IG
	for gcvg-git-2@plane.gmane.org; Sun, 10 May 2015 11:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258AbbEJJFy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2015 05:05:54 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40868 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752170AbbEJJFx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2015 05:05:53 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t4A95e2e029644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 10 May 2015 11:05:40 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4A95fIj015311;
	Sun, 10 May 2015 11:05:41 +0200
In-Reply-To: <xmqqa8xekeb2.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 08 May 2015 13:24:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 10 May 2015 11:05:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4A95e2e029644
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1431853544.14215@66fG3yHy9cbLcaRzRUmvrA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268728>

Junio C Hamano <gitster@pobox.com> writes:

> I am not sure how that changes anything.
>
>     $ git cherry-pick 38e70713119c25ab5699df6b2fb13e4133d399ab
>     error: that commit is a merge and you didn't give me -m <which-parent>
>
>     $ git cherry-pick 38e70713119c25ab5699df6b2fb13e4133d399ab
>     error: the commit 38e707... is a merge and you didn't give me -m <which-parent>

But ...

    ./myscript.sh
    error: that commit is a merge and you didn't give me -m <which-parent>

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
