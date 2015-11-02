From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git log --author=me
Date: Mon, 02 Nov 2015 19:24:16 +0100
Message-ID: <vpqsi4oi7jj.fsf@anie.imag.fr>
References: <563764B8.4010101@exec64.co.uk> <8737wos32p.fsf@igel.home>
	<xmqqy4ege0p5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Harry Jeffery <harry@exec64.co.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 19:24:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtJmQ-0004uo-72
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 19:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941AbbKBSY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 13:24:26 -0500
Received: from mx1.imag.fr ([129.88.30.5]:53385 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752669AbbKBSYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 13:24:25 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id tA2IOEiG021712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 2 Nov 2015 19:24:15 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id tA2IOGKZ001284;
	Mon, 2 Nov 2015 19:24:16 +0100
In-Reply-To: <xmqqy4ege0p5.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 02 Nov 2015 10:05:42 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 02 Nov 2015 19:24:15 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: tA2IOEiG021712
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1447093457.72741@J1DmyJWdvdkQgcLezlG/cw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280707>

Junio C Hamano <gitster@pobox.com> writes:

> Andreas Schwab <schwab@linux-m68k.org> writes:
>
>> Harry Jeffery <harry@exec64.co.uk> writes:
>>
>>> The purpose being to make finding your own commits quicker and easier:
>>>     git log --author=me
>>
>> Since --author does a regexp search, this would most likely break
>> someone's searches.  Better add a new option for that functionality.
>
> I do not think it would hurt too much to add "--mine" to look for
> "--author" that matches you, but on the other hand, I am not sure
> its value outweighs the additional noise in the manual page.

I have a few aliases to congratulate myself for being such an awesome
contributor from time to time ;-):

[alias]
	mymaster = log --oneline --author=Matthieu.Moy@imag.fr origin/master

It did require me to write these lines in my config file, but I think
that the trouble of writing them is smaller than the extra noise in the
manual page and possibly the output of `git log -h`. Having the
shorthand "--author=me" would be better than "git log --mine" as far as
cluttering the doc is concerned IMHO, but it's also likely to break
someone's search.

BTW, the output of `git log -h` is disappointing:

    $ git log -h
    usage: git log [<options>] [<revision-range>] [[--] <path>...]
       or: git show [<options>] <object>...
    
        -q, --quiet           suppress diff output
        --source              show source
        --use-mailmap         Use mail map file
        --decorate[=...]      decorate options
        -L <n,m:file>         Process line range n,m in file, counting from 1
    
There are far more options than this...

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
