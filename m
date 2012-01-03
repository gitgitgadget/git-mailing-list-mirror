From: Thomas Berg <merlin66b@gmail.com>
Subject: Re: git-p4 under cygwin
Date: Tue, 3 Jan 2012 16:54:36 +0100
Message-ID: <CABYiQpmqfRTQ+=o38x0AVDaqg6wjdgqeJF6+sGSr215833QWtA@mail.gmail.com>
References: <1325604726.49597.YahooMailClassic@web132101.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Paul Chown <pmchown@yahoo.co.uk>
X-From: git-owner@vger.kernel.org Tue Jan 03 16:54:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ri6hG-0002e6-No
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 16:54:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753961Ab2ACPyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 10:54:39 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:61329 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753930Ab2ACPyh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 10:54:37 -0500
Received: by eekc4 with SMTP id c4so15989275eek.19
        for <git@vger.kernel.org>; Tue, 03 Jan 2012 07:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Qa0nWxiKeZFOBbI0Lu7YgqKxmg0H7Lceyq7UcZjkht8=;
        b=fuhyxPYZAFiFzQ5u0DjDZqj4FZ836w7zlg7ZZlMoZ5+TMQ8TLivvtnbn6/bmtrisDc
         L/fTmn3IVq9PSiCjdUNa8o9lmbYx9ugkL2ENE+j3wUho1w3uu7akD/mrSUxufK9/CsLv
         251Ks2zUqaYoK3InOcnXecgu6ecpXrfRxDyVM=
Received: by 10.205.127.2 with SMTP id gy2mr11805907bkc.87.1325606076322; Tue,
 03 Jan 2012 07:54:36 -0800 (PST)
Received: by 10.204.50.198 with HTTP; Tue, 3 Jan 2012 07:54:36 -0800 (PST)
In-Reply-To: <1325604726.49597.YahooMailClassic@web132101.mail.ird.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187867>

On Tue, Jan 3, 2012 at 4:32 PM, Paul Chown <pmchown@yahoo.co.uk> wrote:
> Is there are recommended approach for using git-p4 on Windows? I also tried using the non-Cygwin installations of git, but these don't seem to have any Python support in them, so the git-p4 code won't run at all.

I'm not sure, but the error may not be a cygwin related problem at
all, it could be a pure git-p4 usage issue. Do you have a perforce
workspace set up, and do you have the affected files mapped into your
workspace so git-p4 can run p4 sync on them?

Other than that, git-p4 works excellently with the regular msysgit
too. Just install python the regular way on Windows (under C:\Python27
for example) and add it to your path. This python runs just fine in
the MinGW shell too (I think it picks up any PATH changes you make in
Windows). Then just download the git-p4 python script and make sure it
is in your path. This is how I use it.

- Thomas Berg
