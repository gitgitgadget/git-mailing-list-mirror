From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 0/5] Write a good 'git stash store' for autostash
Date: Fri, 14 Jun 2013 20:46:36 +0530
Message-ID: <CALkWK0==4qMijvj+Xyt+e3dbRQjMMenNkMPZi1N78VHdrBQQsg@mail.gmail.com>
References: <1371205924-8982-1-git-send-email-artagnon@gmail.com> <7va9mssr88.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 17:17:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnVks-0004Bm-5w
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 17:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753388Ab3FNPRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 11:17:20 -0400
Received: from mail-bk0-f41.google.com ([209.85.214.41]:62135 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081Ab3FNPRS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 11:17:18 -0400
Received: by mail-bk0-f41.google.com with SMTP id jc3so329376bkc.0
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 08:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MFyIJOlm0tkXKD0FCS4zHagecQlr+3Xc4WqsV13+c80=;
        b=ydebccgPixUYrXi/c8GSOfURTd0MZnLfMgy+vf7/ezolGYR5DPWYqHXc3wvshQuI/D
         Bbt54KJ+gPmmiIByUmfmRti7nQAqxreu94n1tahJOPdKM5lQ6yZHCPkjdAWkcccbGKXO
         Ot6UcLaRnGftzJgqx9PrsFGaOPnC/flDM+b9SJNMVg79QeNFhH9Gesokz6Bv0fvDqfNX
         OCtB3Rk8szNoYa5x28s0Z+nq887SpOzbSEnVk7wtefhOEyvOi828Cn78lvx+wiUh7Bgm
         mxHA9nrWw6SnkxaGqP+ToH5YMBn1mHZzQIGsm460j+MYuROqYHsc57bEZRY5cKQPkZsW
         CPuA==
X-Received: by 10.204.228.207 with SMTP id jf15mr420358bkb.16.1371223037058;
 Fri, 14 Jun 2013 08:17:17 -0700 (PDT)
Received: by 10.204.186.77 with HTTP; Fri, 14 Jun 2013 08:16:36 -0700 (PDT)
In-Reply-To: <7va9mssr88.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227884>

Junio C Hamano wrote:
>>   git stash store [-m <message>] [-e <error>] <commit>
>
> I am perplexed; that would not something I _would_ design or
> suggest.  The "-e <error>" looks especially odd, in that "-e"
> usually refers to something the command evaluates (e.g. sed, perl),
> but more importantly if the caller wants a custom error message,
> normal programmers would do
>
>         command || die "my custom error message"

Another result of me taking your suggestion too literally [1], and not
using my brains :/

[1]: http://article.gmane.org/gmane.comp.version-control.git/224174
