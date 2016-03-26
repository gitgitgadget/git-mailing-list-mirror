From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/GSOC] Git Beginner | Warnings for potentially destructive commands
Date: Sat, 26 Mar 2016 16:12:37 +0100
Message-ID: <vpqfuvdi87u.fsf@anie.imag.fr>
References: <56F51089.2050703@gmail.com>
	<xmqqd1qi4fvi.fsf@gitster.mtv.corp.google.com>
	<CA+P7+xqkqfccQtWeKbURZt21i+gw=b7f0YHHuqeNzM7TH2m+6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Sidhant Sharma <tigerkid001@gmail.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Philip Oakley <philipoakley@iee.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 26 16:12:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajptV-00084a-ET
	for gcvg-git-2@plane.gmane.org; Sat, 26 Mar 2016 16:12:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484AbcCZPMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2016 11:12:48 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41249 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752594AbcCZPMr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2016 11:12:47 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u2QFCZAp020457
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sat, 26 Mar 2016 16:12:35 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u2QFCbNM016517;
	Sat, 26 Mar 2016 16:12:37 +0100
In-Reply-To: <CA+P7+xqkqfccQtWeKbURZt21i+gw=b7f0YHHuqeNzM7TH2m+6g@mail.gmail.com>
	(Jacob Keller's message of "Fri, 25 Mar 2016 12:20:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Sat, 26 Mar 2016 16:12:36 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u2QFCZAp020457
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1459609956.60505@T5/8pLIHUX3qTsgH3g1mfg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289984>

Jacob Keller <jacob.keller@gmail.com> writes:

> If possible, I would suggest aiming for generating the actual topology
> that the user is seeing, customized so that it gives relevenat
> information, rather than static examples.

Using the real topology in a useful way is actually pretty hard. It's
quite easy to throw the output of "git log --graph --oneline ..." to the
user, but as soon as the rebase deals with more than a handfull of
commits, we'd want to simplify the history to show something
understandable to the user (which by definition should be a beginner if
he uses ggit), like replacing long sequences of commits with "..." or
so. That is hard to get right.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
