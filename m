From: Rahul Bansal <rahul.bansal@rtcamp.com>
Subject: Re: Git tag output order is incorrect (IMHO)
Date: Thu, 18 Jul 2013 21:28:11 +0530
Message-ID: <CADtAFQk3inn2C6s0f-uc55Y=wPvwAtmgRu67D9uw6pcMxLvWmA@mail.gmail.com>
References: <840FACA0-7E13-41DB-A0F8-124FAB53BFBD@rtcamp.com>
 <CACsJy8CpZHTCr0=MkSpfurPW_fyLGN_zd4uSzvBSYbuqH8aXew@mail.gmail.com> <CACsJy8Av7b9GMuO-HsT_+QHAc3iDUZQk5KdJ=p8VugaYc3nUPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 18 17:58:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzqbO-0004SU-Bi
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 17:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932749Ab3GRP6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 11:58:33 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:43621 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932307Ab3GRP6b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 11:58:31 -0400
Received: by mail-ie0-f180.google.com with SMTP id f4so7239095iea.39
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 08:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=MEyodsxuQzE4GYLlLNOSgq1nGWfWvPYUY6xwJw7k0Ys=;
        b=ohr87JXRuNrhHnkhEW+LKmVe2ZIs5uw+lM+LOYPzAfexzMi56cglbeFW3CGCupg7EF
         6y7cJd0F7GfdwEd2slRXPNmWKtEk6QYVLIMkEcW+uFE8Fy8NfEEasQkfq5hwYlnoUu0C
         FMYz1pOccXzjxDVLzCZDiK8y3UMQlJo0UYqwZj4lESN4tdQ+NKqPbocoFTktBcfRfhTW
         iIEq64OuvQ6N3X7BJEBS1heboZjUMA5h2FWVOtFGlztGFPzkdV3wzGD6TS51lFa6SUKn
         qZN0OHbb7IurG8hmo4m5UydHiKTOuCrizB9axm074i39hIG4GoTQcP2MwGwFzt1PApma
         hlGQ==
X-Received: by 10.42.47.69 with SMTP id n5mr6564485icf.24.1374163111252; Thu,
 18 Jul 2013 08:58:31 -0700 (PDT)
Received: by 10.64.53.3 with HTTP; Thu, 18 Jul 2013 08:58:11 -0700 (PDT)
In-Reply-To: <CACsJy8Av7b9GMuO-HsT_+QHAc3iDUZQk5KdJ=p8VugaYc3nUPg@mail.gmail.com>
X-Gm-Message-State: ALoCoQko0/a+NtvlMmGFekNhTrbzIryh2XIDgzRe4tQ/6BsdmnqLfw0CxBdFep2OGrLiT4eWZmbC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230698>

Thanks again Duy. :-)

Sorry for misspelling your name in earlier email.
--
Rahul Bansal | Founder & CEO | rtCamp Solutions Pvt. Ltd.
Skype: rahul286 | Twitter: @rahul286 | Web: http://rtcamp.com/


On Thu, Jul 18, 2013 at 9:26 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Jul 18, 2013 at 10:51 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> Try
>>
>> git for-each-ref --sort=committerdate --format='%(refname:short)' refs/tags
>
> And I wondered why it did not seem right. Use this one instead
>
> git for-each-ref --sort=taggerdate --format='%(refname:short)' refs/tags
>
> make it --sort=-taggerdate to reverse sort order.
> --
> Duy
