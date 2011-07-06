From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/14] advice: Introduce error_resolve_conflict
Date: Wed, 6 Jul 2011 05:03:31 -0500
Message-ID: <20110706100331.GH15682@elie>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-2-git-send-email-artagnon@gmail.com>
 <20110706083512.GA15682@elie>
 <CALkWK0k57L5vc7oVQKw=G9FXtYkmnp8QaWrW_p1CvupyNGofZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 12:03:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeOxJ-00006U-AB
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 12:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667Ab1GFKDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 06:03:36 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49827 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955Ab1GFKDf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 06:03:35 -0400
Received: by iwn6 with SMTP id 6so5942138iwn.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 03:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=eeZTs/m7nwlFHeYGTy9CSrTvnfJjooNT4bLygskAiUU=;
        b=TwLsP+so45PtjO4Wh8o0DPbz2dmcwpQWISTXLS32ZNJaIKMpecI8HMOx12uIBq9KX6
         yu7one8N7PgK8AzpW/ZZLpEwa75zZzjj+9sHObqeK1r30ZDEApX1T74jNHvosuemo4Gm
         UBtzVFasEWo4gq2TRMrmJxoBqWc6RK4VTDKlQ=
Received: by 10.42.175.133 with SMTP id ba5mr4009941icb.243.1309946615169;
        Wed, 06 Jul 2011 03:03:35 -0700 (PDT)
Received: from elie (adsl-69-209-76-243.dsl.chcgil.ameritech.net [69.209.76.243])
        by mx.google.com with ESMTPS id d6sm8625127icx.13.2011.07.06.03.03.33
        (version=SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 03:03:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0k57L5vc7oVQKw=G9FXtYkmnp8QaWrW_p1CvupyNGofZg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176676>

Ramkumar Ramachandra wrote:

> Yes, but I was worried that I shouldn't expose it because your commit
> message (2a41df) says:
>
>     It is local to revert.c for now because I am not sure this is
>     the right API (we may want to take an array of advice lines or a
>     boolean argument for easy suppression of unwanted advice).
>
> So, is it still alright to expose it in advice.h?

Well, presumably this second caller is evidence that it is the right
API, no? :)

Of course the API can still easily be changed later.
