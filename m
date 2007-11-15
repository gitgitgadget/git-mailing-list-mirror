From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git-clean won't read global ignore
Date: Thu, 15 Nov 2007 18:50:22 +0100
Message-ID: <vpqfxz71jq9.fsf@bauges.imag.fr>
References: <30046e3b0711131349h51d253d5n4e5649bde36dc36f@mail.gmail.com>
	<20071113225057.GB22836@artemis.corp>
	<7vsl39l0b7.fsf@gitster.siamese.dyndns.org>
	<vpqbq9vlt3k.fsf@bauges.imag.fr>
	<7v7ikj5shd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	shunichi fuji <palglowr@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 18:52:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Isit5-0001QL-44
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 18:52:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757577AbXKORwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 12:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757020AbXKORwF
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 12:52:05 -0500
Received: from imag.imag.fr ([129.88.30.1]:64741 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757322AbXKORwD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 12:52:03 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id lAFHoM7N021429
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 15 Nov 2007 18:50:23 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Isir8-0000yu-M4; Thu, 15 Nov 2007 18:50:22 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Isir8-0001A1-JU; Thu, 15 Nov 2007 18:50:22 +0100
In-Reply-To: <7v7ikj5shd.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Thu\, 15 Nov 2007 09\:27\:42 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 15 Nov 2007 18:50:23 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65145>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> At last, I'll be able to write
>>
>> $ git ls-files -o --exclude-standard >> .gitignore
>> $ $EDITOR .gitignore
>
> I think this is a good cookbook material to put somewhere in the
> docs.

Here it is:

http://git.or.cz/gitwiki/GitTips?action=diff&rev2=217&rev1=216

== How to ignore files which are "Untracked" now? ==

{{{
$ git ls-files -o --exclude-standard >> .gitignore
$ $EDITOR .gitignore
}}}

(note : `--exclude-standard` is not yet in a released version of git
as of november 2007, you'll have to use `--exclude-from=.gitignore
--exclude-from=.git/info/exclude ...` if you don't have it).

-- 
Matthieu
