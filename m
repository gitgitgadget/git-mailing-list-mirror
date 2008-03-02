From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make builtin-reset.c use parse_options.
Date: Sun, 02 Mar 2008 08:18:57 -0800
Message-ID: <7vbq5xqetq.fsf@gitster.siamese.dyndns.org>
References: <47C98472.8000002@gmail.com>
 <7vir05x2di.fsf@gitster.siamese.dyndns.org>
 <1b46aba20803020437p2a5128a5wfee3e98c32c1a610@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Carlos Rica" <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 17:19:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVquj-0006R4-Hg
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 17:19:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753134AbYCBQTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 11:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753739AbYCBQTM
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 11:19:12 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57923 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275AbYCBQTM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 11:19:12 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1237D2A49;
	Sun,  2 Mar 2008 11:19:09 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6C5972A47; Sun,  2 Mar 2008 11:19:05 -0500 (EST)
In-Reply-To: <1b46aba20803020437p2a5128a5wfee3e98c32c1a610@mail.gmail.com>
 (Carlos Rica's message of "Sun, 2 Mar 2008 13:37:38 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75801>

"Carlos Rica" <jasampler@gmail.com> writes:

> On Sun, Mar 2, 2008 at 3:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Carlos Rica <jasampler@gmail.com> writes:
>>
>>  > Signed-off-by: Carlos Rica <jasampler@gmail.com>
>>
>>  Hmmm.  "git reset -h" now defaults to --hard?
>>
>>  It somehow feels a bit risky for new people.  I dunno.
>
> I don't understand what do you mean.
>
> Option -h just prints the options and exits.
> Do you mean that the help message is wrong?

I guess I mistested when I first ran it.  "-h" is Ok.

	$ ./git-reset -h
        usage: git-reset ...

Although "--h" still favors "--hard" over "--help":

	$ ./git-reset --h
        HEAD is now at c149184...

