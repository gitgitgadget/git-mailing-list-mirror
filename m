From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: `git stash pop` UX Problem
Date: Tue, 25 Feb 2014 13:33:56 +0100
Message-ID: <vpqzjlf5q2z.fsf@anie.imag.fr>
References: <530B0395.5030407@booking.com>
	<CANUGeEbPrPp8Sa-KEKSxNDWJShdkDBTkQyXv7tDJ6ReH6MXrHw@mail.gmail.com>
	<vpqlhx0a3cb.fsf@anie.imag.fr> <530C893D.7000108@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Brandon McCaig <bamccaig@gmail.com>,
	Omar Othman <omar.othman@booking.com>, git@vger.kernel.org
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Feb 25 13:34:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIHDF-0007Fz-OO
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 13:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752929AbaBYMeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Feb 2014 07:34:12 -0500
Received: from mx1.imag.fr ([129.88.30.5]:55825 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751463AbaBYMeL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Feb 2014 07:34:11 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s1PCXuZT005162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 25 Feb 2014 13:33:56 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s1PCXvpv001628;
	Tue, 25 Feb 2014 13:33:57 +0100
In-Reply-To: <530C893D.7000108@ira.uka.de> (Holger Hellmuth's message of "Tue,
	25 Feb 2014 13:14:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 25 Feb 2014 13:33:56 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s1PCXuZT005162
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1393936440.80371@gdrk1dQEVrBZsT2zr5A1Lg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242664>

Holger Hellmuth <hellmuth@ira.uka.de> writes:

> Am 24.02.2014 17:21, schrieb Matthieu Moy:
>> $ git add foo.txt
>> $ git status
>> On branch master
>> Changes to be committed:
>>    (use "git reset HEAD <file>..." to unstage)
>>
>>          modified:   foo.txt
>
> Maybe status should display a stash count if that count is > 0, as
> this is part of the state of the repo.

Maybe it would help some users, but not me for example. My main use of
"git stash" is a safe replacement for "git reset --hard": when I want to
discard changes, but keep them safe just in case.

So, my stash count is almost always >0, and I don't want to hear about
it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
