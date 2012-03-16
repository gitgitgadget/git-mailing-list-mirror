From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] perl/Makefile: install Git::I18N under
 NO_PERL_MAKEMAKER
Date: Fri, 16 Mar 2012 09:14:27 -0700
Message-ID: <7v62e4ikv0.fsf@alter.siamese.dyndns.org>
References: <CACBZZX5wHEigiYjn6ahmnXN3wd9sEyDnRV2EZiP+JSUCc182TQ@mail.gmail.com>
 <1331382575-16936-1-git-send-email-avarab@gmail.com>
 <1331382575-16936-3-git-send-email-avarab@gmail.com>
 <7vfwdg16i8.fsf@alter.siamese.dyndns.org>
 <CACBZZX47hAF_ayaa_QBrGcOkZ9UpR0Uxm-4Hf=FB685OKKvYFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	"Tom G. Christensen" <tgc@statsbiblioteket.dk>
X-From: git-owner@vger.kernel.org Fri Mar 16 17:14:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8ZnY-0005gb-7F
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 17:14:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031463Ab2CPQOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 12:14:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59320 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031348Ab2CPQO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 12:14:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 236F46EF5;
	Fri, 16 Mar 2012 12:14:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SMHcmfIiXzr3pzkp1dAoSlNDiHE=; b=Nch2g3
	PPgevO09L9Z1qSF2fI9LlrrJOqAveEEohBHMfnmR6IIBxjbROx1/IgGsj1joii7I
	4jWGH016X3U6rikqqoYs3QJMh94NMGicf4+8iEnmnod7bmFiexe+N7z5Uzi+MDlh
	CmxiJGilqC2fHn4o9zVXmT851Rw16P/xaEqKg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gxZFSpc7UFudxbwG/Oi9V7pUJRnfjLFf
	BQRG5KKejYELokbYTJHeZu0zERCgHLgvsSLkCdIFdeLywdN8vMOSJphnZbE+9ZAS
	JvYpk6x7Vza7M7a6VdhKSKTMPWKuwK37Ahhk3MAv75yidaaX8djfG0CNOIxi/aRx
	ASVbQekGuYw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B1A26EF4;
	Fri, 16 Mar 2012 12:14:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9315D6EF3; Fri, 16 Mar 2012
 12:14:28 -0400 (EDT)
In-Reply-To: <CACBZZX47hAF_ayaa_QBrGcOkZ9UpR0Uxm-4Hf=FB685OKKvYFw@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 11 Mar
 2012 20:27:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1B3FD018-6F83-11E1-80ED-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193273>

This topic has been stuck for almost a week.

    * ab/perl-i18n (2012-03-10) 3 commits
     - fixup! de1e4ae
     - perl/Makefile: install Git::I18N under NO_PERL_MAKEMAKER
     - Git::I18N: compatibility with perl <5.8.3

I just ran (including the fixup patch queued at the tip) this:

    $ PATH=/usr/bin:/bin ;# I do not have any "git" in these two places
    $ export PATH
    $ make NO_PERL_MAKEMAKER=NoThanks prefix=/tmp/no-perl-makemaker
    $ make NO_PERL_MAKEMAKER=NoThanks prefix=/tmp/no-perl-makemaker install

    $ head -n 2 /tmp/no-perl-makemaker/libexec/git-core/git-difftool
    #!/usr/bin/perl
    use lib (split(/:/, $ENV{GITPERLLIB} || "/tmp/no-perl-makemaker/lib"));
    $ ls -l /tmp/no-perl-makemaker/lib
    total 44
    drwxrwxr-x 2 junio junio  4096 Mar 16 09:06 Git
    -rw-rw-r-- 1 junio junio 36222 Mar 16 09:06 Git.pm
    drwxrwxr-x 3 junio junio  4096 Mar 16 09:06 python2.6

And the resulting perl-ish Porcelain seems to work OK.

    $ PATH=$PATH:/tmp/no-perl-makemaker/bin
    $ git add -i

So I'll be merging this (after squashing the fix-up) to master.
