From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 09/11] user-manual.txt: explain better the remote(-tracking) branch terms
Date: Sun, 31 Oct 2010 15:57:20 +0100
Message-ID: <vpqvd4ih0kv.fsf@bauges.imag.fr>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
	<1288411819-24462-10-git-send-email-Matthieu.Moy@imag.fr>
	<20101030071811.GA30779@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 31 15:57:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCZLk-0006J9-RC
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 15:57:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755971Ab0JaO5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 10:57:31 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60910 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755937Ab0JaO5a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 10:57:30 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o9VEgR0C010294
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 31 Oct 2010 15:42:27 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PCZLU-0003B2-RA; Sun, 31 Oct 2010 15:57:20 +0100
In-Reply-To: <20101030071811.GA30779@burratino> (Jonathan Nieder's message of "Sat\, 30 Oct 2010 02\:18\:11 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 31 Oct 2010 15:42:28 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o9VEgR0C010294
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1289140952.91673@ruzp18+7AunDbWk3WnhshA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160442>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Matthieu Moy wrote:
>
>> --- a/Documentation/user-manual.txt
>> +++ b/Documentation/user-manual.txt
>> @@ -359,6 +360,14 @@ $ git branch -r
>>    origin/todo
>>  ------------------------------------------------
>>  
>> +In this case, "origin" is called a remote repository, or "remote" for
> [...]
>
> Did you send the wrong patch?  This looks the same as last time.

Nice catch. I had squashed my changes into the wrong patch (if you
look closely, it ended up in patch 10/11).

Also, after looking more closely, you're right about squashing the
changes in fetch and fmt-merge-msg, I do introduce a (transcient,
untested) bug.

I've fixed all that locally. I'll resend the serie tomorrow or the day
after (better wait for comments, I've already bothered the list too
much with resends of the serie, and I'll be offline travelling).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
