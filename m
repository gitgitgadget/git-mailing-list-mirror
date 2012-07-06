From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 02/12] git-remote-mediawiki: test environment of git-remote-mediawiki
Date: Fri, 06 Jul 2012 10:44:05 +0200
Message-ID: <vpqhatl9t4a.fsf@bauges.imag.fr>
References: <1341473772-28023-1-git-send-email-Matthieu.Moy@imag.fr>
	<1341473772-28023-3-git-send-email-Matthieu.Moy@imag.fr>
	<7vmx3dpzsn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>,
	Simon CATHEBRAS <Simon.Cathebras@ensimag.imag.fr>,
	Julien KHAYAT <Julien.Khayat@ensimag.imag.fr>,
	Simon Perrat <simon.perrat@ensimag.imag.fr>,
	Charles ROUSSEL <Charles.Roussel@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 11:53:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sn5E1-0003zZ-IF
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 11:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755800Ab2GFJxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 05:53:10 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55698 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752364Ab2GFJxH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 05:53:07 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q668grEG025420
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 6 Jul 2012 10:42:53 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Sn490-0001QE-Uz; Fri, 06 Jul 2012 10:44:07 +0200
In-Reply-To: <7vmx3dpzsn.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 05 Jul 2012 16:13:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 06 Jul 2012 10:42:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q668grEG025420
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1342168978.11014@22ANVN6Z+Vtz8Pc7+U1NoQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201094>

Junio C Hamano <gitster@pobox.com> writes:

>> +clean:
>> +	$(RM) '$(gitexecdir)/$(SCRIPT)'
>> +	$(MAKE) -C t/ clean
>> +
>
> New blank link at EOF.

[...]

>> +		git clone mediawiki::'"$WIKI_URL"' mw_dir_1 &&
>> +		wiki_editpage Foo "page created after the git clone" false &&
>> +	
>
> Trailing whitespace
>
> There are many others, 16 in total, I think.

Oops, sorry, I should have noticed that. I "rebase --whitespace=fix"ed
the serie (there were still some indent-with-space too).

Junio C Hamano <gitster@pobox.com> writes:

> This suggests the series is not based on 'master', which is not
> fatal per-se ("am -3" guesses that came from b3d98595), but then
> applying the series on mm/mediawiki-file-attachments topic will show
> that the index line recorded in [PATCH 09/12] is useless.
>
> On what commit was this meant to be applied???

Sorry, this was based on an intermediate commit, that were rewritten in
the meantime.

I'll resend a proper serie soon.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
