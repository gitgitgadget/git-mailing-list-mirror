From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/3] pull: allow interactive rebase with
 --rebase=interactive
Date: Wed, 13 Jan 2016 19:50:00 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601131949060.2964@virtualbox>
References: <cover.1452612112.git.johannes.schindelin@gmx.de> <cover.1452668201.git.johannes.schindelin@gmx.de> <2ebf99214ba600b63a39c58bcb9abb7941a7619d.1452668201.git.johannes.schindelin@gmx.de> <xmqqd1t5pej1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 20:00:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJQeI-0004uZ-C6
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 20:00:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757388AbcAMS7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 13:59:51 -0500
Received: from mout.gmx.net ([212.227.15.18]:59653 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756424AbcAMSuG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 13:50:06 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MYP57-1afmps38xV-00VC8J; Wed, 13 Jan 2016 19:50:01
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqd1t5pej1.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:z8/z5X11SM6xd/YY1DjWPI5mPYddW7QWXux/gsGFWpmA9wJrgvW
 IbRuEu9JJ1VW/s4uRloByFRDB5RUAXenTEcP80v2iTyb3l/jAA6sN6/SOzmpjrwDoUTTzJa
 bha1MRMcUi+Jj9G9fVNUkNmq33VEXM3ECrots5i0jHsOgwQtGLCFEdF0gyAR49UewpkZ3T4
 5NcFFs21BaC9r0x/7vryg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hHiykMI+stc=:RFWX4UlE3H+JVunQItPbCY
 aKIy462sN0u+KmDOu6Pk8PMHugSIgqon6xmcO3/VXsHhYvZJTTcYuoD76hUUObbarsE6MeT1m
 5PADkdsZpjr0zOOPLkAUWHPcWZob0sLwVhlHP3XIQft13BcE/JPsUa/+2f6cnSXH0XpX+MgYF
 qHRSYRnM7QPemoxFN4tsAxQbU3TbaavKfmU4rLwP6FEosunivpkoPstes3NxJI7lblVtn+CYL
 vLFbHE6BAoqTILrh62xqLZaaHe12xcBFBQHCQ5kvKxJfJzrlh028uS7A7vcJA9MKnSHQx+XHT
 h5RFQAM6DkC40GHTv0sNc3pSMghR57dnRjPY3MXrCMNoRKt/JG99zponim3sBlHzAedTtF6NS
 B38tmLG580q3J7VrYa5ij1r6/MqhUHBMfDAZoNpACmrQs36e50cVwGAdm6Q/3xlmUHXP0wsVa
 wxYM3byAoR1+/QCzE6GauvNPoZ5XCqm0NcaQkWpQHVsleCL4x4CPR4EVysS+RjtKYsIynxt+W
 ponA45BIvGYOASf0dVjfQqodinNI02yY7wCqglgL3orsyCi2LApMruBSZ39uGB1CqAsGYA/5I
 PpEurpSt+zfC4piL/RVtic50Uwpi4UtxoDFOZrx6r1k23fpuuuf/uoQidsozY/tRXtayZcv+W
 s1MlfnSpgWaDr4WiuBViRJpuWHzUqmgsT74kEzTk7QUIuj7+A4XYxBKqN5J76+hhvyH4NTtw/
 R73yGNP9jT7b+9X8TcUXtiJY2T9yEwVVSSE8q/62mPf6VKxCR5foj7MAnxHBIHRDCwNO0UJw 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283970>

Hi Junio,

On Wed, 13 Jan 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>     A couple of years ago, I found the need to collaborate on topic
>     branches that were rebased all the time, and I really needed to see
>     what I was rebasing when pulling, so I introduced an
>     interactively-rebasing pull.
> 
> [...] I may just insert these four lines at the beginning of the log
> message while queuing, or something.

Oh, that's what you meant! Sorry for misunderstanding, and thanks for not
requiring a reroll.

Ciao,
Dscho
