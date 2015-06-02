From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFCv2 2/2] git rebase -i: warn about removed commits
Date: Tue, 02 Jun 2015 08:40:30 +0200
Message-ID: <vpq7frmy5nl.fsf@anie.imag.fr>
References: <1433159523-6596-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<1433159523-6596-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Philip Oakley <philipoakley@iee.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Stephen Kelly <steveire@gmail.com>
To: Galan =?iso-8859-1?Q?R=E9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 02 08:40:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzfsZ-0007o1-GD
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 08:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753073AbbFBGkr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Jun 2015 02:40:47 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54394 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751759AbbFBGkq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 02:40:46 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t526eUht005371
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 2 Jun 2015 08:40:30 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t526eUvP001271;
	Tue, 2 Jun 2015 08:40:30 +0200
In-Reply-To: <1433159523-6596-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	("Galan \=\?iso-8859-1\?Q\?R\=E9mi\=22's\?\= message of "Mon, 1 Jun 2015 13:52:03
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 02 Jun 2015 08:40:31 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t526eUht005371
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433832034.23081@hqla6YG9AVreRxXDZw7wSA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270503>

Galan R=E9mi <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes:

> Check if commits were removed (i.e. a line was deleted) and print
> warnings or abort git rebase according to the value of the
> configuration variable rebase.checkLevel.

checkLevel does not seem to be a good name, because it doesn't say
_what_ is checked. I don't have really good proposal in mind, but maybe

rebase.todoListCheckLevel
rebase.missinLinesCheckLevel

?

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
