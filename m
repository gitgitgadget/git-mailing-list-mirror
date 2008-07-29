From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Community Book
Date: Tue, 29 Jul 2008 11:42:30 -0700
Message-ID: <7vwsj4edm1.fsf@gitster.siamese.dyndns.org>
References: <d411cc4a0807290920p62f5d7e1r727a62ef2b4611fc@mail.gmail.com>
 <20080729170955.GK32184@machine.or.cz>
 <d411cc4a0807291130p228f77d5r1f390090ec29aef4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Petr Baudis" <pasky@suse.cz>, "git list" <git@vger.kernel.org>
To: "Scott Chacon" <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 20:43:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNuAa-0007sy-5D
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 20:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757213AbYG2Smi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 14:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757160AbYG2Smh
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 14:42:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42496 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757077AbYG2Smh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 14:42:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EB2564A494;
	Tue, 29 Jul 2008 14:42:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3861C4A492; Tue, 29 Jul 2008 14:42:32 -0400 (EDT)
In-Reply-To: <d411cc4a0807291130p228f77d5r1f390090ec29aef4@mail.gmail.com>
 (Scott Chacon's message of "Tue, 29 Jul 2008 11:30:55 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1CBF62DC-5D9E-11DD-9E8F-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90666>

"Scott Chacon" <schacon@gmail.com> writes:

>>
>> There is no license in the source code - what are the copying terms?
>>
>
> I copied in the COPYING file from Git - GPL2.
>
>> It is maybe somewhat unfortunate that this is in a different format that
>> the standard git choice asciidoc, but the formats do look rather similar
>> so I assume it should not be hard to even convert from one to another if
>> needed.
>
> I simply didn't want to get asciidoc working locally - it's always
> been a bit of a pain to compile (I've heard it referred to more than
> once as the only 'nightmare dependancy' in git), and I don't need to
> make man pages or anything, so it seemed Markdown would be a better
> choice for my output targets.  There are a number of good Markdown
> interpreters and they're easy to get running.

I personally like markdown, but doesn't your refusal to work with existing
practices pose a significant problem, unless:

 (0) you do not consider it a goal to keep the documentation shipped with
     git and your book in sync; or

 (1) you have either markdown to asciidoc (or the other way around)
     converter; the book is written in markdown, and its conversion back
     to asciidoc is fed to Documentation as patches (or the other way
     around); or

 (2) somebody tries to find markdown to manpage, and we convert
     Documentation/ to markdown.

Or is this, "fork once and borrow reviewer's time, but never be able to
contribute back to the original text because the result is so different"
approach?
