From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 0/2] mergetools: add support for ExamDiff
Date: Sat, 2 Apr 2016 14:02:39 -0700
Message-ID: <20160402210239.GA6917@gmail.com>
References: <xmqqio0a17ux.fsf@gitster.mtv.corp.google.com>
 <1458947877-31764-1-git-send-email-jacob.nisnevich@gmail.com>
 <xmqqfuv5i4i7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacob Nisnevich <jacob.nisnevich@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 02 23:02:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amSgy-0005I4-T4
	for gcvg-git-2@plane.gmane.org; Sat, 02 Apr 2016 23:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbcDBVCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2016 17:02:44 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34680 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbcDBVCn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2016 17:02:43 -0400
Received: by mail-pf0-f174.google.com with SMTP id c20so6902294pfc.1
        for <git@vger.kernel.org>; Sat, 02 Apr 2016 14:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SEyCp8U5JxrgBW1/Ol83ffzn75M3gceCeaAYSfZZ5Vo=;
        b=x3UlZ+UxU/hKURJLPSiEApwV8CRefrFHXzUjcYBIwWerwGtZqfEjb5MPrGdTeBilfq
         qXW7W64sAah9dfGi1ZhM/rNiV2Zf0q7LoCPckIIk/H0dHyuzTJzJh4OoTAgltcklttiL
         4q0sCuSEGvwiMY2uDM6Rc1nl5ufo6eCmLcxYm0uZZSAILrQwBmBRRrI7FG52y01lggQz
         UIMptimVQCUCRuZB6qO19stSxgXgEQE3bdtWp6VGrlpBQ7K3sbbqnHFGGp8RCHtx7o9a
         KuB+TvE2fypRFv+ZqyuivNRXRuCw2gnC1f9TxVQVEAHeDlOUwHLtHWg1obC8So6vY7kf
         rMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SEyCp8U5JxrgBW1/Ol83ffzn75M3gceCeaAYSfZZ5Vo=;
        b=UrxnuEFexYsAyP/8l+oWXqxqIqP7Z2SLH29VBctxwsTjIGNVQiTQu9246znaN3E3GA
         byvSTIcUatIt82v2dayb0ioya9fJBrouDJZwNWK+lS/aGfyjWK+DOwBnfKndgXkvifKH
         xlALuwSOJCdigz9sDq/09eDOz3kv5Q9JzONFCedpBS048S//tO7rdFAnXbshRvHZFxyU
         Fn3SEyPB1qz6Ys/FHiPK1Tri+KVpnTB/ZlMB9uidha+n5zdI2iIG66tjVghf4t+lYKaz
         Ps7MYRLwPWM3cUbielQAIQXCSryWwDl3mbGUToOM0pyxeuMPoZfYGV/6bHfcS0K/hIwh
         +g8g==
X-Gm-Message-State: AD7BkJI8pI8NcVNOWK/sjSksQRXgTPM768TipA/AfQUZR1AKZt8B1aI+hPmVTrakiOoxUQ==
X-Received: by 10.98.70.138 with SMTP id o10mr8602192pfi.123.1459630962581;
        Sat, 02 Apr 2016 14:02:42 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id lq10sm31039210pab.36.2016.04.02.14.02.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Apr 2016 14:02:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqfuv5i4i7.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290607>

On Fri, Apr 01, 2016 at 11:10:56AM -0700, Junio C Hamano wrote:
> Jacob Nisnevich <jacob.nisnevich@gmail.com> writes:
> 
> > OK I add the quotes and modified the comment. I also changed $folder to 
> > $sub_directory. I think that makes a little bit more sense and sounds a lot
> > better.
> >
> > Jacob Nisnevich (2):
> >   mergetools: create mergetool_find_win32_cmd() helper function for
> >     winmerge
> >   mergetools: add support for ExamDiff
> >
> >  git-mergetool--lib.sh | 25 +++++++++++++++++++++++++
> >  mergetools/examdiff   | 18 ++++++++++++++++++
> >  mergetools/winmerge   | 21 +--------------------
> >  3 files changed, 44 insertions(+), 20 deletions(-)
> >  create mode 100644 mergetools/examdiff
> 
> This round looked good to me.
> David, does this look sensible to you?
> 
> Thanks.

Yes, thank you.

Acked-by: David Aguilar <davvid@gmail.com>

cheers,
-- 
David
