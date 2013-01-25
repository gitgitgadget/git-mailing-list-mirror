From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 6/7] mergetools: Fix difftool/mergetool --tool-help
 listing for vim
Date: Fri, 25 Jan 2013 02:28:22 -0800
Message-ID: <CAJDDKr4yb1-C9W1ZnKxHUk7WKpq-EN_YiR6diHCm5DVtQWzeCQ@mail.gmail.com>
References: <1359107034-14606-1-git-send-email-davvid@gmail.com>
	<1359107034-14606-7-git-send-email-davvid@gmail.com>
	<51025D1C.2030307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Keeping <john@keeping.me.uk>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 11:28:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TygWd-00027r-Hy
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 11:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756677Ab3AYK22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 05:28:28 -0500
Received: from mail-ee0-f52.google.com ([74.125.83.52]:45779 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756472Ab3AYK2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 05:28:24 -0500
Received: by mail-ee0-f52.google.com with SMTP id b15so101870eek.25
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 02:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=J+ytONUo/mARMfvHfm8Qp5ww5NoVhSEHdd3d++761Dw=;
        b=rGgR6GkAtZnG7NUgaZt503P00Xr0Kbk6X2inQSqBZon1AY+mILvyaf6cjjAeNWfZAX
         zM6/By+ceS8+v7XzCf3GKAVV0dQpbik5rTNLNC9TIYluWHAdKPMJEqUZrWNQwQW7eOFw
         vVfNR/c0g0VCxnqSyUAN3xuYpGHNgcwsOsniAXurtU7PJK9A3/ww/VYo3l6SwoHNbcfm
         UZOnfZ1BPUd+t0VEAi2amwhE+GxA/82N0KhbKp0R0UniOYOAXE+ZmkJldyVdSLC+idm+
         RZmeYki/8aC9taKPJ/lKe/xko1bTx7tkrklqVPBE6cXr1Odz3T3kehP6P+/ZvRansVA/
         svHA==
X-Received: by 10.14.1.70 with SMTP id 46mr16966608eec.0.1359109702795; Fri,
 25 Jan 2013 02:28:22 -0800 (PST)
Received: by 10.14.125.135 with HTTP; Fri, 25 Jan 2013 02:28:22 -0800 (PST)
In-Reply-To: <51025D1C.2030307@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214538>

On Fri, Jan 25, 2013 at 2:23 AM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
> On 2013/01/25 10:43 , David Aguilar wrote:
>
>> Remove the exception for "vim" and allow the scriptlets to be found
>> naturally by using symlinks to a single "vimdiff" scriptlet.  This
>
>
> I guess that won't work on platforms where Git does not support symlinks,
> then, like Windows. But Windows has (g)vimdiff, so loosing these on that
> platform would not be so nice.

I thought Git did something sensible there like create a normal file?

If not then I was thinking we could add a provides_tools() function that
each scriptlet could supply.
-- 
David
