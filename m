From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Re: [Misfeature] cloning without configuration fails and returns 0
Date: Tue, 11 Dec 2007 12:42:11 +0100
Message-ID: <2A5EA5CA-5A8E-4A9F-9D5C-AAEEFAB1910A@lrde.epita.fr>
References: <9438BB94-AE9C-4F4E-A4DA-8E2121642736@lrde.epita.fr> <7vzlwktzzb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 12:43:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J23Vv-0003tQ-Cz
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 12:43:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbXLKLml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 06:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbXLKLml
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 06:42:41 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:33422 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbXLKLmk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 06:42:40 -0500
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1J23VS-0001YY-3F; Tue, 11 Dec 2007 12:42:34 +0100
In-Reply-To: <7vzlwktzzb.fsf@gitster.siamese.dyndns.org>
X-Gpgmail-State: !signed
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67839>

On Dec 9, 2007, at 2:32 AM, Junio C Hamano wrote:

> Benoit Sigoure <tsuna@lrde.epita.fr> writes:
>
>> on a new machine I have access to, I fetched tonight's git master  
>> (git
>> version 1.5.3.7.g9758e) and installed it on my account in order  to
>> clone one of my projects.  I did not setup anything in my git config
>> and stumbled on the following misfeature:
>
> This is not a misfeature but an outright bug in an earlier fix to
> 13208572fbe8838fd8835548d7502202d1f7b21d (builtin-commit: fix -- 
> signoff)
>
> Can you try this and see if it works for you?

Yes, thank you.

>
> -- >8 --
> Re-fix "builtin-commit: fix --signoff"
>
> An earlier fix to the said commit was incomplete; it mixed up the
> meaning of the flag parameter passed to the internal fmt_ident()
> function, so this corrects it.
>
[...]
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  builtin-commit-tree.c |    4 ++--
>  builtin-commit.c      |    4 ++--
>  builtin-log.c         |    4 ++--
>  builtin-tag.c         |    4 ++--
>  cache.h               |    3 +++
>  ident.c               |   30 ++++++++++++------------------
>  refs.c                |    2 +-
>  var.c                 |    4 ++--
>  8 files changed, 26 insertions(+), 29 deletions(-)

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory
