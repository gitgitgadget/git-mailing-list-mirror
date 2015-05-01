From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Patch that modifies git usage message
Date: Fri, 1 May 2015 14:01:31 -0400
Message-ID: <CAPig+cS1t9jz8Dr+p89Ly5OG1dhiFqvyBxjgbvMhtSpk1VFqmA@mail.gmail.com>
References: <CAKB+oNtYbJXNb2wGzJCdQ5Ru5fq3HzcapSqiTVC_34=xDnTb7Q@mail.gmail.com>
	<CAGZ79kY1ZoYrVwVVqfyB+uMGsJo59qDxbDLgyo5qygSm=CUVhA@mail.gmail.com>
	<xmqqfv7gxnup.fsf@gitster.dls.corp.google.com>
	<CAKB+oNtKi6e7H9U75WEJDKH2KK349JT+vGE8+acHvM6SasCWfQ@mail.gmail.com>
	<CAPig+cROY5ZaXtAWpaMpe8JsuG1eSp2jhAsSh1dAsCSACgoFxw@mail.gmail.com>
	<CAKB+oNvSR4ifdCZAxTyhwoh-yeVxikB0+Z9+19MGyVv4yLB=Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Alangi Derick <alangiderick@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 01 20:01:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoFFx-0001xM-3K
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 20:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbbEASBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 14:01:35 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:33228 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbbEASBc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 14:01:32 -0400
Received: by iecrt8 with SMTP id rt8so94027424iec.0
        for <git@vger.kernel.org>; Fri, 01 May 2015 11:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=n4+ZTP8rV61GCRHgk2G2IWM898pY7FdON95aUjLy9eA=;
        b=qQYx94BuaKxGPyxWZ8mm1UURGDkICUHvlNtU29vKAJDUth8PHCgNpMDZ/861VJ4SpX
         cb+YABlGRqbFO1Ry+3GPBkdUCgUZlnk09SMJAd3CuxO+FQvnDj+H0jqDpwBQvZf4KDZz
         A3rDNTPo31KXM/inYRui9qXj1MVpon8p9IWzu2qWMe77WOwjRvSTizm6mSNEibwlyMi2
         QDEWw+cOD6mKyq3G4SAnktUHtZA06ZYA1MIuIzB7yv4Qw8JUB0e+DTDVt5xgPxc8fzQP
         yp/gkarKQOoJSAiqjFb5iMLGjvU3xU+tquqb3v/DyUzbC8m9oBENXNC6Ylnh64TYyr+q
         Ykeg==
X-Received: by 10.50.61.200 with SMTP id s8mr11880700igr.7.1430503291432; Fri,
 01 May 2015 11:01:31 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 1 May 2015 11:01:31 -0700 (PDT)
In-Reply-To: <CAKB+oNvSR4ifdCZAxTyhwoh-yeVxikB0+Z9+19MGyVv4yLB=Xw@mail.gmail.com>
X-Google-Sender-Auth: TAU7lQT-_gUUCEuIyf4G-0Lv7h8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268168>

On Fri, May 1, 2015 at 1:49 PM, Alangi Derick <alangiderick@gmail.com> wrote:
> So in essence what you are saying is that i should instead change
> error messages to lower case.

No, I'm not saying that you _should_ do anything. I am saying merely
that if you were to submit such a patch for the sake of improving
consistency, you might have an easier time convincing people that your
patch is worthwhile if you follow the current trend (which is to make
error messages lowercase).

However, I'm also saying that such a patch may encounter resistance if
it is perceived as mere "noise", as explained by the CodingGuidelines
blurb which I cited.

> And also i have seen an idea i want to work on from
> https://git.wiki.kernel.org/index.php/SmallProjectsIdeas
> I want to work on this and will submit a patch as soon as i am done.
