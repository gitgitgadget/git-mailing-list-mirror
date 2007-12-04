From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Introduce .git/BRANCH to point to the current branch
Date: Tue, 04 Dec 2007 12:46:37 -0800
Message-ID: <7vir3e428i.fsf@gitster.siamese.dyndns.org>
References: <4755B3B3.80704@gmail.com> <vpqbq96jjrf.fsf@bauges.imag.fr>
	<m34peyur8r.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Salikh Zakirov <salikh@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 21:47:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izeg1-0002ti-RM
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 21:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754861AbXLDUqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 15:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754870AbXLDUqq
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 15:46:46 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:55923 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754861AbXLDUqp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 15:46:45 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 3A4842FA;
	Tue,  4 Dec 2007 15:47:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 658A49CE9D;
	Tue,  4 Dec 2007 15:47:01 -0500 (EST)
In-Reply-To: <m34peyur8r.fsf@roke.D-201> (Jakub Narebski's message of "Tue, 04
	Dec 2007 12:42:43 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67083>

Jakub Narebski <jnareb@gmail.com> writes:

>> Currently, I can do:
>> 
>> # Oh, what did this look like two commits ago?
>> $ git checkout HEAD^^
>> # Ah, OK, let's go back to the tip
>> $ git checkout branch-name
>>                ^^^^^^^^^^^
>> But I have to remember and re-type the branch name.
>
> No, you don't have. You can use
>   $ git checkout ORIG_HEAD
> or
>   $ git checkout HEAD@{1}

But the point is he wants to go back to the branch he came from.  He
does not want to detach HEAD at the original commit.

Having said that, I am not sympathetic to "I have to remember".
