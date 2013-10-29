From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: Limiting disk usage
Date: Tue, 29 Oct 2013 15:45:39 +0100
Message-ID: <526FCA13.4090902@gmail.com>
References: <0a4899b7-f75f-4016-9c99-5e6e3fb9603c@email.android.com> <vpqob68ebcu.fsf@anie.imag.fr> <CAA01Cso+yTzatiAaQahx5h2N0nnOON7FsnWNSYrN-pV=8qzn7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 29 15:45:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbAYJ-0002nr-HL
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 15:45:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756812Ab3J2Opp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Oct 2013 10:45:45 -0400
Received: from dovecot.mat.uni.torun.pl ([158.75.2.81]:51291 "EHLO
	dovecot.mat.uni.torun.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756794Ab3J2Opo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 10:45:44 -0400
Received: from dovecot.mat.uni.torun.pl (localhost.localdomain [127.0.0.1])
	by dovecot.mat.uni.torun.pl (Postfix) with ESMTP id 95532B71695;
	Tue, 29 Oct 2013 15:45:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at mat.uni.torun.pl
Received: from dovecot.mat.uni.torun.pl ([127.0.0.1])
	by dovecot.mat.uni.torun.pl (dovecot2.mat.uni.torun.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 9pg1nKLV2cql; Tue, 29 Oct 2013 15:45:40 +0100 (CET)
Received: from [158.75.2.83] (unknown [158.75.2.83])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: jnareb)
	by dovecot.mat.uni.torun.pl (Postfix) with ESMTPSA id 50F34B713A2;
	Tue, 29 Oct 2013 15:45:40 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <CAA01Cso+yTzatiAaQahx5h2N0nnOON7FsnWNSYrN-pV=8qzn7g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236929>

On 2013-10-29 14:50, Piotr Krukowiecki wrote:

> Yes, I put a lot of code into the repository. I know it is wrong from=
 git POV ;)
> That's why I wrote about splitting repository into multiple smaller
> repositories, but AFAIK git is not very good at managing that too...

Lot of code isn't problem, see Linux kernel or GCC, or LibreOffice.org

> (Background: we're thinking about migrating svn repository into git.
> Currently there is one svn repository containing many related
> directories. They are branched/merged/tagged together. Often work is
> done on all/many of them, but there are some use cases where we need
> only some of them)

If they are independent projects, they should get independent repositor=
ies;
you can stitch them back together using git-submodule (or git-subtree).
reposurgeon can hel you with that.

--=20
Jakub Nar=C4=99bski
