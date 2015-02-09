From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 02/11] refs: remove the gap in the REF_* constant values
Date: Mon, 9 Feb 2015 10:14:17 -0800
Message-ID: <CAGZ79kbcgv236MxzNpQ3H6E9y-v_SYaYettzXUjr9311DyF-ig@mail.gmail.com>
References: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
	<1423412045-15616-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 09 19:14:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKsqk-0002BG-IO
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 19:14:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933793AbbBISOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 13:14:19 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:52603 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933233AbbBISOS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 13:14:18 -0500
Received: by mail-ig0-f171.google.com with SMTP id h15so18179189igd.4
        for <git@vger.kernel.org>; Mon, 09 Feb 2015 10:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Ed5aTjj1DquMWhGUgMZvdeI71uhO1Zuklfb7LWbzz0E=;
        b=oif1L/sFFjSQbsBBwktookcY2zIdliQM0kGIJ18QMfneas5UQmwxzV/zCjWXgPteyj
         rQlSF23IBnV4NwE0rJA/NjmznRdf5oUQ1FDfEXtvBYBgcTOGmkrZk1zGPI6lW3L8c2/i
         2LBUrv9LCBRTCKVH2wZplgq621ODmQWAkWYo1sPBnEzbAZ1/SVTL4Zn0RNlz2vtagiTd
         Pg3+wwgyAP02aTvpJM91xLShGxB8csBE0Qnd5o3QklDX1pSEYb3ZNISpLUcoJ88Awhst
         pLJPVrjwgOju2lxP/9HFDdZwkZHRhZD4P8YZxqBhNls+cVTjxXVciiRH5TyiaBcdJoaE
         XfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Ed5aTjj1DquMWhGUgMZvdeI71uhO1Zuklfb7LWbzz0E=;
        b=UDjK7iIWdUe5GJdFp8ChD871FQMNfdXLYSwt/QG09Hpj/kRUIiAOWEf0t13UaBwI9D
         uNE1Oc0bs6FsGUKRpduEjkB1wEu39IDhzvRi/oiXDsTqiG6LYYKLM5dP4/lRthyv/IEs
         Sf7SWwvVMA52AJp6Sh7x2XPRC1L5yz7LAJIZ+LRkL1FKJRFC//FUjgyqN0QkqqpY+KGC
         HKpcyEvrWE/txuU9ndgG5qWkve/U09wv5BQXmf5vj+BS7L/jV0baa6pfoyC0dG8XqLqd
         QFyHz97Hs2RPW8Lxw806+qYpa55ZJA7GT8Hcrlrpy990jJUYTuzvDZjfgsNZX35OTEDg
         F6ug==
X-Gm-Message-State: ALoCoQmzkh/UrBYTIzxLyS9HBveBpWyf6gOmE6cz5c4Eh+QDv4Y6Cl3S9xTxAFRtAQwfinjPdquM
X-Received: by 10.42.71.194 with SMTP id l2mr26118177icj.71.1423505657580;
 Mon, 09 Feb 2015 10:14:17 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Mon, 9 Feb 2015 10:14:17 -0800 (PST)
In-Reply-To: <1423412045-15616-3-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263570>

On Sun, Feb 8, 2015 at 8:13 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> There is no reason to "reserve" a gap between the public and private
> flags values.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/refs.c b/refs.c
> index cd5208b..477a5b3 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -44,7 +44,8 @@ static unsigned char refname_disposition[256] = {
>   * Used as a flag to ref_transaction_delete when a loose ref is being
>   * pruned.
>   */
> -#define REF_ISPRUNING  0x0100
> +#define REF_ISPRUNING  0x04
> +

I'm ok with that change, though I remember Duy had once started to
create a table in a header file documenting all positions of flags
(e.g foo.c would use 1<<{1,2,3,7}, and bar.c had 1<<{1,2,5,26} in
use).
I wonder if we should start a discussion on that topic. I think it
makes sense to have a central place documenting all the flags
(specially their bit allocation), but this one is only in one c file,
so we're really unlikely to
break something by having different defines pointing at the same bit.
