From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH/WIP 0/9] for-each-ref format improvements
Date: Sun, 19 May 2013 06:36:31 -0500
Message-ID: <CAMP44s1w29evK29HvsbQv5OXhaQK7_yLWh_wq8toVMKagwb94w@mail.gmail.com>
References: <1368959235-27777-1-git-send-email-pclouds@gmail.com>
	<CALkWK0=7z91A54jSzc2yZU3g50u8H_f8su1Y+i=D+KxYtqor5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 13:36:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue1un-0002WK-Jv
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 13:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077Ab3ESLgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 07:36:33 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:38062 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970Ab3ESLgc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 07:36:32 -0400
Received: by mail-la0-f47.google.com with SMTP id fq12so5537835lab.20
        for <git@vger.kernel.org>; Sun, 19 May 2013 04:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=OfZOSPuHywz1DhtVV6Pq8OZPTrrCd0U3PoMBKEsibUc=;
        b=BUoWdKb35LlrDAExQZbJGaJjxEzDDsFMjjTvpbIaxFQ4CMMRFcdYwfZ59TXHTq7AsZ
         VT/ffUNA9M2W0FynIhojHAqVTFM50V2Gi1FH+H+l9IyLrWLyNjcLhCAGveuvGRHvrAI+
         jGdaZNWk1oqOl53n+eaK+xVNhP+8w5/ax6ENhFvMy/HDRfCsrV2Ahk+ly3WpS7DEI28p
         0HSG7U+evKl3b68dUfCblNLr0zO6JnOlrJp5brpZgDgKU8/Fyi2oL4Vbv9GFFDOyNi3u
         9HvxkrjqBwPzxsGsVuwpoOfUbkQxKIqS27mQnuDL3RDdPP0LIw7tC/J3pBfTupdcNCPp
         lWLA==
X-Received: by 10.112.63.169 with SMTP id h9mr11003746lbs.135.1368963391229;
 Sun, 19 May 2013 04:36:31 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Sun, 19 May 2013 04:36:31 -0700 (PDT)
In-Reply-To: <CALkWK0=7z91A54jSzc2yZU3g50u8H_f8su1Y+i=D+KxYtqor5g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224855>

On Sun, May 19, 2013 at 6:11 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:

> Yes, I think this is the direction we should be taking.  Poorly
> thought-out stuff like -v and -vv should be deprecated.

Of course not. They are useful and user-friendly.

The only question is what should be the format by default.

> Also, I think it'll help to have a --pretty="format:<string>"
> equivalent to --format="<string>" so that we can introduce pretty
> names like oneline, short, medium, full.  We can eventually deprecate
> --format for consistency.

I don't see the point of --pretty. I think there should be shortcuts,
something like --hash for the SHA1s only, and --names for the refs
only, or something like that.

-- 
Felipe Contreras
