From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2009, #02; Sun, 11)
Date: Sun, 11 Jan 2009 14:19:46 -0800
Message-ID: <7vwsd1pjst.fsf@gitster.siamese.dyndns.org>
References: <7v63kmtbk6.fsf@gitster.siamese.dyndns.org>
 <m3ljthzzdq.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 11 23:21:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM8gc-0003c3-HF
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 23:21:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754519AbZAKWTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 17:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754502AbZAKWTx
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 17:19:53 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33262 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbZAKWTx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 17:19:53 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D12741C45D;
	Sun, 11 Jan 2009 17:19:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AC4E41C45C; Sun,
 11 Jan 2009 17:19:48 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F74F2BE6-E02D-11DD-A406-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105235>

Jakub Narebski <jnareb@gmail.com> writes:

>> ----------------------------------------------------------------
>> [Actively cooking]
>>
>> * sc/gitweb-category (Fri Dec 12 00:45:12 2008 +0100) 3 commits
>>  - gitweb: Optional grouping of projects by category
>>  - gitweb: Split git_project_list_body in two functions
>>  - gitweb: Modularized git_get_project_description to be more generic
>
> This I think needs some further cooking.  I guess with addition of one
> more patch to series categories could be sorted together with projects
> they contain, and not always have to be in fixed ordering.

These should be moved to the Stalled category; nobody seems to be
discussing improvements and sending updates to the series as far as I
recall.

>> * gb/gitweb-patch (Thu Dec 18 08:13:19 2008 +0100) 4 commits
>>  - gitweb: link to patch(es) view in commit(diff) and (short)log view
>>  - gitweb: add patches view
>>  - gitweb: change call pattern for git_commitdiff
>>  - gitweb: add patch view
>
> If I remember correctly the only point of discussion is calling
> convention for git_commitdiff, and whether 'patches' view should
> (re)use git_commitdiff or use its own subroutine.

Thanks; I take it that it is basically usable, useful and can be
incrementally improved in 'next'?
