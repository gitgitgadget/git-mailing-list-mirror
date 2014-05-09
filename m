From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v1 06/25] contrib: remove 'diffall'
Date: Fri, 9 May 2014 11:50:35 -0700
Message-ID: <20140509185035.GL9218@google.com>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <1399597116-1851-7-git-send-email-felipe.contreras@gmail.com>
 <CAFouetj4A+z2xzciGAbsQ8th8CNwYMd5QTapar4TXRLzGdAqeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 20:50:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wipsa-0001ya-6m
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 20:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbaEISuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 14:50:40 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:51708 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754353AbaEISuj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 14:50:39 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so4766301pab.10
        for <git@vger.kernel.org>; Fri, 09 May 2014 11:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/GhAII4Z4GBI19W+jmesNqcD+ZV16st2IwNEUcLzwGA=;
        b=NTNdfzDawRY3Q/wTIcYodw31YP3k35G1H4x6ICg4yUvLquQuIud4j0fSVSBqv9wXHW
         lnxN5SwSX1nBLWohtl5msL5F794vpSfpz9zXkb1e1UlwRkXBne6ILh5UYKk1NesvlS5g
         2e2jjQ78x/BUNSu1hUrT/TpdvamesNmBaSntALCJ/hSbQ1Yi8oWnlhnSPQlxoIfs0C0d
         gltc7xuTXPaxK/IulrkAd0YlMTgcFatKHFAMN4oFEThaBWEeIImeDsYnjEmVnySYdYXK
         GnDbDV4RcBRsojvs+eJV6Y1FzD+TWPg+ztQ5tcsh+HDcIxcv2gAu719jDXgu4UPLQJSa
         sKEQ==
X-Received: by 10.66.222.100 with SMTP id ql4mr2877594pac.109.1399661439167;
        Fri, 09 May 2014 11:50:39 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id pl10sm8852228pbb.56.2014.05.09.11.50.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 09 May 2014 11:50:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAFouetj4A+z2xzciGAbsQ8th8CNwYMd5QTapar4TXRLzGdAqeQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248612>

Hi Tim,

Tim Henigan wrote:
> On Thu, May 8, 2014 at 5:58 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:

>>  contrib/diffall/README      |  31 ------
>>  contrib/diffall/git-diffall | 257 --------------------------------------------
>>  2 files changed, 288 deletions(-)
>>  delete mode 100644 contrib/diffall/README
>>  delete mode 100755 contrib/diffall/git-diffall
>
> I see no problem with removing this script from contrib.  However, the commit message
> should mention that git-difftool learned all the features of git-diffall when the '--dir-diff'
> option was added in v1.7.11 (ca. June 2012).

A few questions:

 * Do you still use git-diffall?  Since it hasn't been a maintenance
   burden, I wouldn't mind keeping it if it still has users.

 * Any thoughts about how to help people who have been using it to
   migrate to difftool?  Would a note in the release notes to look
   into the --dir-diff option to difftool be enough, or are there
   more specific pointers that could be useful?

Once those questions are dealt with, this seems like a nice small
cleanup.  Thanks for the quick feedback.

Hope that helps,
Jonathan
