From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git.el: Don't use font-lock-compile-keywords
Date: Sun, 3 Apr 2011 14:25:15 -0500
Message-ID: <20110403192515.GF3830@elie>
References: <m3oc501rja.fsf@e4300lm.epcc.ed.ac.uk>
 <20110403001902.GA25671@elie>
 <87ei5j2prc.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexandre Julliard <julliard@winehq.org>,
	Lawrence Mitchell <wence@gmx.li>, git@vger.kernel.org,
	David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>,
	Kevin Ryde <user42@zip.com.au>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 21:25:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6SvN-0003bF-SG
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 21:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753210Ab1DCTZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 15:25:21 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41261 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748Ab1DCTZU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 15:25:20 -0400
Received: by iwn34 with SMTP id 34so5134876iwn.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 12:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=CBsnT/fNRhtga+lZ0nil2FBOT1O/1o3K8hNah+J3tvE=;
        b=KswE3s8sL2tGixmxUkOneCpx464Qjd0gxNmrTTgDezha0SY91cVy0miOAdxoiwchpr
         hrba9SMPRv8pU9qhBxao4ITpIk1S1n/L1iyugIvlS6A+7YoT1B62GGpPoD674agWTVJY
         6AHVEj1N10s4UWxjbvTpLaym+O99sJwqQJXH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=uZNrRp1zq8T+d4FzJmyhXr0Rq0sYCWsBV3JXYdH8enYjMGH9C25dTRwyPkRBUVjQ5d
         /9SvPJcWjZaE/rKX0U+ywo81IhcRj6gtdVz64LzovK7nQMAYsyQAAmk7B2ANjbojCGL6
         nbc/yfSHu02gA3oaKMi8AWxJr4da0GFc9GR+4=
Received: by 10.43.54.210 with SMTP id vv18mr2329688icb.103.1301858719576;
        Sun, 03 Apr 2011 12:25:19 -0700 (PDT)
Received: from elie (adsl-69-209-53-77.dsl.chcgil.sbcglobal.net [69.209.53.77])
        by mx.google.com with ESMTPS id wu1sm2938622icb.22.2011.04.03.12.25.17
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 12:25:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87ei5j2prc.fsf@wine.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170776>

Alexandre Julliard wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>>> So here it is
>>> again.  The originally proposed patch from Debian is to use
>>> font-lock-add-keywords rather than font-lock-compile-keywords.
>>> However, it doesn't exist in XEmacs, if one is looking to
>>> maintain compatibility, I believe this patch is the right thing
>>> to do.
>>>
>>>  contrib/emacs/git.el |   13 ++++++++++---
>>>  1 files changed, 10 insertions(+), 3 deletions(-)
>>
>> Leaving patch unsnipped for reviewers' sake.
>
> Looks good to me.

Just cc-ing Junio so he can see your ack.

Junio, the patch up-thread fixes a bug reported by
Kevin Ryde <user42@zip.com.au>.  I'm not knowledgeable enough to see
what the impact is, but the emacs experts seem to like it.
