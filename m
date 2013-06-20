From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 2/6] config doc: rewrite push.default section
Date: Thu, 20 Jun 2013 09:35:47 +0200
Message-ID: <CALKQrgf=gUTv22m_eBPVy+cQEfJn0w_G097a8nnJB1zJ48Lmpg@mail.gmail.com>
References: <1371640304-26019-1-git-send-email-artagnon@gmail.com>
	<1371640304-26019-3-git-send-email-artagnon@gmail.com>
	<7v7ghpzxhu.fsf@alter.siamese.dyndns.org>
	<7vhagtwjfa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 09:36:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpZPT-0005ZW-HR
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 09:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754151Ab3FTHfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 03:35:55 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:56557 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753613Ab3FTHfz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 03:35:55 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UpZPN-000B9G-E8
	for git@vger.kernel.org; Thu, 20 Jun 2013 09:35:53 +0200
Received: from mail-ob0-f182.google.com ([209.85.214.182])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UpYRX-0008z4-AS
	for git@vger.kernel.org; Thu, 20 Jun 2013 08:34:03 +0200
Received: by mail-ob0-f182.google.com with SMTP id va7so6833264obc.27
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 00:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gfTy/a3OA/mhJOzOD3tnuW81OslXQiP4+T/VFoUUH9Y=;
        b=S8VbYMV0FIb+uJMdQQeyvsiIPJbnBo6jPJ61gAoSE2sf59CiEvhLpoN1BwphZPh8vg
         5AgZGJIR/TBKmElo+vQ0djYREOQwx+IU8GFUXO9utJjthqc9EQzM76p3U99/T1acx01O
         0U73PuuQc/n2BVj1t2HH30hNforNy6PV5mM7mrK/dLL6DvfUT1T0PR1U7hH8ckXhxLeW
         AZW5ksaXl1u0DmhXw5SaVZrRsbKYn1o9y7fa0OXvrI/OH41mZXi7kB0rD9D9JVgwxkWb
         /OKv4A7mkZiCcFa1Tq34YhmzJ17wRzY72V83XXEFLGHbDRyWPDCPzD8pMGdBzmmDs56P
         TI2g==
X-Received: by 10.60.93.196 with SMTP id cw4mr3730921oeb.135.1371713748022;
 Thu, 20 Jun 2013 00:35:48 -0700 (PDT)
Received: by 10.182.102.5 with HTTP; Thu, 20 Jun 2013 00:35:47 -0700 (PDT)
In-Reply-To: <7vhagtwjfa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228445>

On Thu, Jun 20, 2013 at 5:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
> +* `simple` - a safer version of `current`; push the current branch
> +  to update a branch with the same name on the receiving end, with a
> +  safety feature: in central workflows, error out if your current
> +  branch is not set to integrate with the branch with the same name,
> +  to ensure that a `push` and a `push` are symmetrical.

to ensure that a `push` and a `pull` are symmetrical.

Otherwise, this looks good to me.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
