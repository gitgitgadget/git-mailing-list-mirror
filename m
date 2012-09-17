From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Test failure: Test #3 in t1304-default-acl
Date: Mon, 17 Sep 2012 17:23:27 +0200
Message-ID: <vpqd31kr7v4.fsf@grenoble-inp.fr>
References: <CALkWK0n0bH3xPLarv35Th_agnhKCkRjgcKTJR7Xy=B_NkBHkOg@mail.gmail.com>
	<vpqy5k8raig.fsf@grenoble-inp.fr>
	<CALkWK0=h6iU_J=X6MFgLXPfo0rh236cTuVaU3nNSnAaikjKH5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 17:23:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDdAk-0007Bb-A7
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 17:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756849Ab2IQPXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 11:23:33 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38730 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753405Ab2IQPXb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 11:23:31 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q8HFI4X2006488
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 17 Sep 2012 17:18:04 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TDdAV-00052D-Gk; Mon, 17 Sep 2012 17:23:27 +0200
In-Reply-To: <CALkWK0=h6iU_J=X6MFgLXPfo0rh236cTuVaU3nNSnAaikjKH5w@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 17 Sep 2012 08:01:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 17 Sep 2012 17:18:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q8HFI4X2006488
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1348499885.32226@hl+nLFUeiy5Hb177H4BWXw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205699>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Hi Matthieu,
>
> Matthieu Moy wrote:
>> Do you have any user with this login (finger kseygold)? I suspect you
>> have two usernames with the same user ID.
>
> Login: kseygold                         Name: Seybold
> Directory: /home/likewise-open/ANT/kseygold     Shell: /bin/zsh
> Office:  Kelly
> Last login Tue Aug 28 12:16 (IST) on tty2
> No mail.
> No Plan.

Does this user have the same UID as your usual user
(id kseygold; id $LOGNAME)?

>> Which filesystem are you using in this directory?
>
> / is ext4.  What does that have to do with anything?

Last time we had a failure in this test, it was a filesystem bug ...

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
