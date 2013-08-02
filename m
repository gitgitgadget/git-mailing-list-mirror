From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] Provide some linguistic guidance for the
 documentation.
Date: Thu, 1 Aug 2013 23:25:41 -0700
Message-ID: <20130802062511.GA3013@elie.Belkin>
References: <1375197114-10742-1-git-send-email-marcnarc@xiplink.com>
 <1375369825-28636-1-git-send-email-marcnarc@xiplink.com>
 <7vfvuts25p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org,
	Fredrik Gustafsson <iveqy@iveqy.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 02 08:25:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V58oG-00018X-0U
	for gcvg-git-2@plane.gmane.org; Fri, 02 Aug 2013 08:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753953Ab3HBGZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 02:25:52 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:41192 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326Ab3HBGZv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 02:25:51 -0400
Received: by mail-pb0-f51.google.com with SMTP id jt11so318763pbb.10
        for <git@vger.kernel.org>; Thu, 01 Aug 2013 23:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jX+H9+AhQRbgxz1mnWjSTmsQG+BuZVYFGvSBptJd0SE=;
        b=mJKwBVHZr2MP0Zmc7pWrzMV9p/CfW57dzsmnt9fJ1eD6mFYIJGudYhw+7TeYofIsOJ
         JmbPboUwYfqR2odYKc911x+erMuXkVXsPpmeng0Hxc/XIcLmPYkbmwR4gK3SPhVY5lBv
         i2gz/Bh5ZhoJ/AwL/5FjerY9a6uDtM8So+hTQt3i3CJ7vXFkEM2Cq54mEOnb/Cmh0cKj
         94k+Gdupdy7X0+ACxG4rpPwB3G1nNaiuJWGmRUJYZLeyG3uNKWt6rbKeTDhPa6uvteC7
         bynrMEdCpCc8zlYGex+qZ+3YNO64ZlPrgoqsKkU3clToCvwLZbGhOHgukvAPISp9mWNZ
         fyXg==
X-Received: by 10.66.25.232 with SMTP id f8mr8800458pag.25.1375424751011;
        Thu, 01 Aug 2013 23:25:51 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id a5sm8267439pbw.4.2013.08.01.23.25.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 01 Aug 2013 23:25:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vfvuts25p.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231517>

Junio C Hamano wrote:

> Is that accurate?  My impression has been:
>
>     The documentation liberally mixes US and UK English (en_US/UK)
>     norms for spelling and grammar, which is somewhat unfortunate.
>     In an ideal world, it would have been better if it consistently
>     used only one and not the other, and we would have picked en_US.

I'm not convinced that would be better, even in an ideal world.

It's certainly useful to have a consistent spelling of each term to
make searching with "grep" easier.  But searches with "grep" do not
work well with line breaks anyway, and search engines for larger
collections of documents seem to know about the usual spelling
variants (along with knowing about stemming, etc).  Unless we are
planning to provide a separate en_GB translation, it seems unfortunate
to consistently have everything spelled in the natural way for one
group of people and in an unnatural way for another, just in the name
of having a convention.

I am not sure it makes sense for the documentation to say "A huge
disruptive patch of such-and-such specific kind of no immediate
benefit is unwelcome".  Isn't there some more general principle that
implies that?  Or the CodingGuidelines could simply say

	The documentation uses a mixture of U.S. and British English.

My two cents,
Jonathan
