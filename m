From: "Jay Soffian" <jaysoffian+git@gmail.com>
Subject: Re: [PATCH] Improve git-help--browse browser support under OS X
Date: Sun, 10 Feb 2008 21:10:31 -0500
Message-ID: <76718490802101810u74f86927hefacac162c69f697@mail.gmail.com>
References: <1202505794-13409-1-git-send-email-jaysoffian+git@gmail.com>
	 <20080209202020.GD30368@dpotapov.dyndns.org>
	 <76718490802091815s45c19113t938f5257aad3f46c@mail.gmail.com>
	 <20080210124336.GH30368@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 03:11:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOO8W-0008SG-CJ
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 03:11:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbYBKCKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 21:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbYBKCKe
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 21:10:34 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:59282 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbYBKCKd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 21:10:33 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1871513wah.23
        for <git@vger.kernel.org>; Sun, 10 Feb 2008 18:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=9fu2GU9Tk4kmeUaxXjH4lzkhFbCecelu+RBbPx9iDIk=;
        b=Q6QkZ2LgSOc1hLbYthSVOrEilPwQU3Gi5QinYziWNOHZfmUV5tWKWcqK8lrp3UWzz4AGIPg6wU2fCKKkEudJrbu9uSw7UxYFdiiNTVQ9hpl2Yb0YZ9FEuexoMct3mPdWKGVP6XgdoyiQ+Gjjl6nua0kMJ8AShcabyNDzY3AFby4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=LuaAoqM1NOnf1LG5Jp+NFMj2xfNdg5aQjSGf3Jq76ojGMXMf9X1d0UGOZy3/qYpOZwLLgVyD33koatnxgyJhrxMuqGp0VP9sIWVXopyzus8L3TVQNrFlsuCbnII2FWuxvh5aAmG2MKxfexHFFFIXByZQtlRAuPbXz7VApfDwVXg=
Received: by 10.114.121.1 with SMTP id t1mr8408795wac.55.1202695831393;
        Sun, 10 Feb 2008 18:10:31 -0800 (PST)
Received: by 10.114.255.11 with HTTP; Sun, 10 Feb 2008 18:10:31 -0800 (PST)
In-Reply-To: <20080210124336.GH30368@dpotapov.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: 0a7e8287a3b1d292
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73455>

On Feb 10, 2008 7:43 AM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> On Sat, Feb 09, 2008 at 09:15:30PM -0500, Jay Soffian wrote:
>
> Would not be better to use uname instead like this
>
>   if test "$(uname -s)" == "Darwin"; then
>     ...
> or in addition to SECURITYSESSIONID:
>
>   if test -n "$SECURITYSESSIONID" -a "$(uname -s)" == "Darwin"; then
>     ...
> ?
>
> I think it would be more reliable and more importantly it makes the
> code easier to understand, because it is clear now for everyone that
> this is OS X specific.

Sure.

> BTW, should not it be mentioned in the documentation? Probably, in
> the list of supported web browsers in git-help.txt.

Yep, will do.

j.
