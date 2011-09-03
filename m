From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-remote-helpers.txt: explain how import works with multiple refs
Date: Sat, 03 Sep 2011 12:35:18 +0200
Message-ID: <vpqty8tc3rt.fsf@bauges.imag.fr>
References: <CAGdFq_gooPGQMa5D19-wag=X+mDntHF1MwXiYF0zovB=L-Sybw@mail.gmail.com>
	<1314809222-30528-1-git-send-email-Matthieu.Moy@imag.fr>
	<20110901231734.GA21945@elie>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 03 12:35:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QznZf-0005Kl-Bl
	for gcvg-git-2@lo.gmane.org; Sat, 03 Sep 2011 12:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376Ab1ICKfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Sep 2011 06:35:38 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52901 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752229Ab1ICKfh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Sep 2011 06:35:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p83AYS9V005485
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 3 Sep 2011 12:34:28 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QznZG-0005eX-Lx; Sat, 03 Sep 2011 12:35:18 +0200
In-Reply-To: <20110901231734.GA21945@elie> (Jonathan Nieder's message of "Thu,
	1 Sep 2011 18:17:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 03 Sep 2011 12:34:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p83AYS9V005485
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1315650872.01871@/rEVPc1dujNzdbdGbL3zZg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180651>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> +	is followed by a blank line). For example, the following would
>> +	be two batches of 'push', the first asking the remote-helper
>> +	to push the local ref 'master' to the remote ref 'master' and
>> +	the local 'HEAD' to the remote 'branch', and the second
>> +	asking to push ref 'foo' to ref 'bar' (forced update requested
>> +	by the '+').
>> ++
>> +------------
>> +push refs/heads/master:refs/heads/master
>> +push HEAD:refs/heads/branch
>> +\n
>> +push +refs/heads/foo:refs/heads/bar
>> +\n
>> +------------
>
> Probably examples like this could go in a later EXAMPLES section.

I think having a few examples within the explanations helps the reader
visualize what commands look like, and understand better further
explanations.

Plus, the example explains quickly the + which isn't documented
otherwise (but people reading this probably already know what a refspec
is and what the + normally means in this context so it's probably
sufficient to explain it as a side remark in an example)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
