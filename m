From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: [PATCH v3] To make GIT-VERSION-FILE, search for git more widely
Date: Wed, 03 Jun 2009 09:32:09 +0200
Message-ID: <op.uuxtvv1v1e62zd@merlin.emma.line.org>
References: <1241688129-31613-1-git-send-email-matthias.andree@gmx.de>
 <20090602195533.6117@nanako3.lavabit.com>
 <7v7hzufxcu.fsf@alter.siamese.dyndns.org> <200906022035.30081.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "Nanako Shiraishi" <nanako3@lavabit.com>, git@vger.kernel.org
To: "Johannes Sixt" <j6t@kdbg.org>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 09:32:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBkxY-0000Mr-Gd
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 09:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755130AbZFCHcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 03:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755242AbZFCHcN
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 03:32:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:38603 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755130AbZFCHcM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 03:32:12 -0400
Received: (qmail invoked by alias); 03 Jun 2009 07:32:12 -0000
Received: from e179168167.adsl.alicedsl.de (EHLO mandree.no-ip.org) [85.179.168.167]
  by mail.gmx.net (mp003) with SMTP; 03 Jun 2009 09:32:12 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX1+qtXFQC8iqIRe1IKDN8JnSwRMI78hni0BCqiVvBp
	b+Qb/X9cSjr0nw
Received: from merlin.emma.line.org (localhost [127.0.0.1])
	by merlin.emma.line.org (Postfix) with ESMTP id 4BD2A94643;
	Wed,  3 Jun 2009 09:32:10 +0200 (CEST)
In-Reply-To: <200906022035.30081.j6t@kdbg.org>
User-Agent: Opera Mail/9.64 (Linux)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120589>

Am 02.06.2009, 20:35 Uhr, schrieb Johannes Sixt <j6t@kdbg.org>:

> On Dienstag, 2. Juni 2009, Junio C Hamano wrote:
>> Nanako Shiraishi <nanako3@lavabit.com> writes:
>> > Junio, I think you forgot to take a follow-up action on this thread  
>> after
>> > sending this message.  The patch favors the git program in the current
>> > directory.
>>
>> Indeed, I did, and I think I am Ok with the patch.  Thanks for a
>> reminder.
>>
>> I thought there was an "simplicity" issue raised by J6t that was not
>> addressed, but after re-reading the thread I do not think it applies
>> (J6t?)
>
> Sorry, I don't recall anymore what I said; but since the thread petered  
> out, I
> use this patch in the repository where I share Matthias' 'sudo make  
> install'
> problem:
>
> Subject: [PATCH] version-gen: Use just built git if no other git is in  
> PATH
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>
> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> index 39cde78..4779313 100755
> --- a/GIT-VERSION-GEN
> +++ b/GIT-VERSION-GEN
> @@ -3,6 +3,9 @@
>  GVF=GIT-VERSION-FILE
>  DEF_VER=v1.6.3.GIT
> +# use git that was just compiled if there is no git elsewhere in PATH
> +PATH=$PATH:.
> +
>  LF='
>  '

Hi Hannes,

that's not what I proposed at the time; I'll look how I ordered  
preferences at the time and will re-submit soon. AFAIR (I'll check the  
archives), Junio had preferred checking $(prefix) before . in order to  
support cross-builds.

Best regards

-- 
Matthias Andree
