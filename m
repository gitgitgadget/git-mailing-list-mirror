From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git merge --abort
Date: Fri, 20 Feb 2009 00:33:40 -0800
Message-ID: <7vljs1fqxn.fsf@gitster.siamese.dyndns.org>
References: <43d8ce650902190205yc2274c5gb8e658c8608267ff@mail.gmail.com>
 <7v63j6n16s.fsf@gitster.siamese.dyndns.org>
 <43d8ce650902190534j49e24f86k9b716190ae3d134b@mail.gmail.com>
 <76718490902191226k7b87f478p9a79b9b2372b464d@mail.gmail.com>
 <43d8ce650902192047g383a5cc1re6697e8009ad72fc@mail.gmail.com>
 <7v7i3lk7dp.fsf@gitster.siamese.dyndns.org>
 <43d8ce650902200013q4aca6b2na27092e0825f969a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 09:35:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaQqv-00063B-K2
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 09:35:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754099AbZBTIdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 03:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753579AbZBTIdv
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 03:33:51 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42970 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011AbZBTIdv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 03:33:51 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 66B8C9B377;
	Fri, 20 Feb 2009 03:33:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E9C299B372; Fri,
 20 Feb 2009 03:33:42 -0500 (EST)
In-Reply-To: <43d8ce650902200013q4aca6b2na27092e0825f969a@mail.gmail.com>
 (John Tapsell's message of "Fri, 20 Feb 2009 08:13:46 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 32523B42-FF29-11DD-BDB1-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110816>

John Tapsell <johnflux@gmail.com> writes:

> 2009/2/20 Junio C Hamano <gitster@pobox.com>:
> <snip>
>>    $ edit ;# unrelated local changes are still here
>>    $ git pull ;# or merge or whatever
>>    ... oops, large conflict ...
>>    ... look and see if it can easily be resolved ...
>>    ... otherwise
>>    $ git merge --abort
>
> Can I just confirm - at this stage, "git merge --abort" would be a
> "git reset --hard HEAD" ?

Not at all.  Please re-read my previous message that begins with "Not at
all".
