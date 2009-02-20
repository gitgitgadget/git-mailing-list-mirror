From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rebase -i
Date: Thu, 19 Feb 2009 16:11:00 -0800
Message-ID: <7vzlgij7cb.fsf@gitster.siamese.dyndns.org>
References: <43d8ce650902190121v2e18aac1rfaa64a4ce6e799a3@mail.gmail.com>
 <76718490902191255w24b30bd8jacaed8aa919d6526@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 01:12:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaJ0O-0002cm-Ei
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 01:12:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755881AbZBTALK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 19:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755839AbZBTALJ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 19:11:09 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59583 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755844AbZBTALJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 19:11:09 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 45BFD9B682;
	Thu, 19 Feb 2009 19:11:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 17AA79B67D; Thu,
 19 Feb 2009 19:11:01 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F7B0F2A8-FEE2-11DD-BC0F-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110769>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Thu, Feb 19, 2009 at 4:21 AM, John Tapsell <johnflux@gmail.com> wrote:
>> Hi,
>>
>>  I often do   'git rebase -i HEAD~10'  to rebase.  Since afaics it
>> doesn't matter if you go back 'too far' I just always use HEAD~10 even
>> if it's just for the last or so commit.
>>
>>  Would there be any objections to making  'git rebase -i' default to
>> HEAD~10  or maybe 16 or 20.  Having sensible defaults for commands
>> helps a bit with making it easier to use.
>
> I think the following might be reasonable to support:
>
> $ git rebase -i -10
> $ git rebase -i -n -10

The syntax would certainly imply a different semantics from giving
HEAD~10.  How would you compute the set of commits to rebase sanely when
you have merges after your 10th direct parent commit?
