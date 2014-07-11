From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 4/4 v6] cache-tree: Write updated cache-tree after commit
Date: Fri, 11 Jul 2014 16:37:21 -0700
Organization: Twitter
Message-ID: <1405121841.3775.31.camel@stross>
References: <1405038686-1138-1-git-send-email-dturner@twitter.com>
	 <1405038686-1138-4-git-send-email-dturner@twitter.com>
	 <xmqq38e76gfi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 01:37:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5kNu-0004jm-3P
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 01:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbaGKXhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 19:37:42 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:52125 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbaGKXhk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 19:37:40 -0400
Received: by mail-pd0-f180.google.com with SMTP id fp1so2163608pdb.39
        for <git@vger.kernel.org>; Fri, 11 Jul 2014 16:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=Ys6mznlI390xSeVH8m+AY5iL9NwXH4LZnzgichTFK3M=;
        b=lGLsxzQ/6Adhr8/u0DLV0ImVAj1cDb4THhZJUfwbnE1//r0vMSR0BMRBGhclC7U6cH
         Zh3YqMLiTJqVO2eeCmz0adITVY4iBtRbEDgz3jU0qSRvDm4BM4CmXiCFvvcGhrMzdpew
         ATmph0UZevibOvIXMiQD4mkevXEAqUP6NyaN3l0DiTSgjGYnKwYBuBxc8SjQ7ZFg/s4L
         bOcZGiA+ABtoFvAc5azyu3dqUuDriEiZFqGIv/Bwtdqpv/56UOYjuA6Muw8egyNWjTjU
         vwgsX3EW/DQqiEGamzysblh2gHYAP6TGrKplJWQRZBjMvNUY066HRy8v/qsEEsS3DZ4l
         3azg==
X-Gm-Message-State: ALoCoQk0pEDbVxKV2ugMglqQFvg8JYWtj5lQFj9X0NJGma1D+kWMNF8DNN1KJeRvpWvFA4kYsP05
X-Received: by 10.68.164.67 with SMTP id yo3mr1948297pbb.104.1405121860151;
        Fri, 11 Jul 2014 16:37:40 -0700 (PDT)
Received: from [172.25.253.5] ([208.184.35.186])
        by mx.google.com with ESMTPSA id ia2sm3391848pbb.32.2014.07.11.16.37.38
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 16:37:38 -0700 (PDT)
In-Reply-To: <xmqq38e76gfi.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253352>

On Fri, 2014-07-11 at 08:52 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > @@ -16,8 +16,34 @@ cmp_cache_tree () {
> >  # We don't bother with actually checking the SHA1:
> >  # test-dump-cache-tree already verifies that all existing data is
> >  # correct.
> 
> Is this statement now stale and needs to be removed?

I think it is still accurate; we still don't bother to check SHAs and
test-dump-cache-tree still does the comparison.
