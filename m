From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 0/3] git help: group common commands by theme
Date: Fri, 08 May 2015 10:18:48 +0200
Message-ID: <vpqioc38ot3.fsf@anie.imag.fr>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com>
	<vpqfv7ap25j.fsf@anie.imag.fr>
	<xmqqoalxbo0w.fsf@gitster.dls.corp.google.com>
	<vpqbnhw4w3r.fsf@anie.imag.fr>
	<xmqq7fskp6qf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?iso-8859-1?Q?S=E9bastien?= Guimmara 
	<sebastien.guimmara@gmail.com>, git@vger.kernel.org,
	sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 10:19:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqdUu-0003UI-4b
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 10:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbbEHIS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 04:18:59 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56910 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752506AbbEHIS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 04:18:57 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t488Ilts019376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 8 May 2015 10:18:47 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t488Im14019647;
	Fri, 8 May 2015 10:18:48 +0200
In-Reply-To: <xmqq7fskp6qf.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 07 May 2015 11:44:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 08 May 2015 10:18:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t488Ilts019376
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1431677929.14792@DpsLd908oNVS4TtUwC+59w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268609>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> And the answer may confuse that someone even further (it is not
>>> necessarily "rm", but is often "reset").  As a list of simple
>>> command set to help the dip-your-toes-in-water process, a new user
>>> may be better off starting with "add", "add ." and "commit -a", and
>>> learn from the last part of "git add --help" that there are "rm" and
>>> "mv" (both of which happen a lot less often than "add").
>>
>> If one wonders how to remove a file from Git, expecting that user to
>> look at the doc for "git add" to find out seems really backwards to me.
>
> Yeah, but you are moving the goalpost.

Yes, because Git has more than one user and each user may have different
ways of thinking. I both find it weird to present "add" without "rm" and
to expect users to look at the doc for "add" to find "rm".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
