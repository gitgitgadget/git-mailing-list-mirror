From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] fetch: add new fetch.default configuration
Date: Sat, 1 Jun 2013 09:04:09 -0500
Message-ID: <CAMP44s1_yQ+y5eupd3vbhDi6be+vhkj8cSw4K2kxn5wDMFQwgA@mail.gmail.com>
References: <1368843536-19781-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 01 16:04:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UimPo-00056I-Fe
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 16:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754784Ab3FAOEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 10:04:12 -0400
Received: from mail-we0-f180.google.com ([74.125.82.180]:46108 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754610Ab3FAOEK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 10:04:10 -0400
Received: by mail-we0-f180.google.com with SMTP id w56so474500wes.39
        for <git@vger.kernel.org>; Sat, 01 Jun 2013 07:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=If+WYX7ivITq1oSAlpLAO4mIhafNfPCAksY9BDU0Z6s=;
        b=Wvy8j8nXgAwoAuaaSBhUDtI25OQpcC+4pAHIwFvH3X7ayoVvVMOjw2A4g/D9YYunCH
         vimm1LwR21rV9djWFXGuy38A1oqWY275yYB+STzwzg8Aj3LDKTR38RwzDemVIjs4eorI
         b5MHHXggVGWFVCC2aFvmw4m8Dg5W+ggp791zINOPRJ/3GeWX5YHaNkGfQyBi60ECNaf6
         Mg7x/aYMWvYsDW/spmrL3gAgALC+FV5lO5yYnzzQ/FBN51AFxEkSwXLXhldzFLRSWQcv
         +3uNDvTkJj+O4cA5KjZRrmSqhth82FQvqK2xlW8k1coDJGnkgNA5dVJm5QZDDYOuFqoO
         XHQA==
X-Received: by 10.180.109.84 with SMTP id hq20mr7059526wib.11.1370095449492;
 Sat, 01 Jun 2013 07:04:09 -0700 (PDT)
Received: by 10.194.47.4 with HTTP; Sat, 1 Jun 2013 07:04:09 -0700 (PDT)
In-Reply-To: <1368843536-19781-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226128>

On Fri, May 17, 2013 at 9:18 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> When the user has an upstream branch configured to track a remote
> tracking branch:
>
>   % git checkout --set-upstream-to github/master
>
> Doing a 'git fetch' without any arguments would try to fetch 'github',
> because it's configured as current branch's remote
> (branch.<current>.remote).
>
> However, if we do something slightly different:
>
>   % git checkout --set-upstream-to master
>
> Doing a 'git fetch' without any arguments would try to fetch the remote
> '.', for the same reason.

What happened to this? Didn't you want big commit messages?

-- 
Felipe Contreras
