From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: 0 bot for Git
Date: Wed, 13 Apr 2016 07:43:18 +0200
Message-ID: <vpqegaa9i89.fsf@anie.imag.fr>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com>
	<CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com>
	<vpq60vnl28b.fsf@anie.imag.fr>
	<CAGZ79kaLQWVdehMu4nas6UBpCxnAB_-p=xPGH=aueMZXkGK_2Q@mail.gmail.com>
	<vpqoa9ea7vx.fsf@anie.imag.fr>
	<xmqqmvoypn7g.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, lkp@intel.com,
	Greg KH <gregkh@linuxfoundation.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 07:43:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqDaS-0007Ea-IB
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 07:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbcDMFnc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 01:43:32 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34592 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964813AbcDMFnb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 01:43:31 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u3D5hIiE020210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 13 Apr 2016 07:43:18 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u3D5hIoj002512;
	Wed, 13 Apr 2016 07:43:18 +0200
In-Reply-To: <xmqqmvoypn7g.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 12 Apr 2016 13:49:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Wed, 13 Apr 2016 07:43:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u3D5hIiE020210
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1461131001.81875@lS/thWHFruL2fAuL4x17rg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291370>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
> True, presumably the Travis integration already solves that part, so
> I suspect it is just the matter of setting up:
>
>  - a fork of git.git and have Travis monitor any and all new
>    branches;
>
>  - a bot that scans the list traffic, applies each series it sees to
>    a branch dedicated for that series and pushes to the above fork.

... and to make it really useful: a way to get a notification email sent
on-list or at least to the submitter as a reply to the patch series.
Just having a web interface somewhere that knows how broken the code is
would not be that useful.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
