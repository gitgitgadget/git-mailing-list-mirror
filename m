From: Rob Barrett <barrettboy@gmail.com>
Subject: Re: Usability question
Date: Sun, 20 Sep 2009 12:21:38 +1000
Message-ID: <513ca40e0909191921k1b7b14b5j7cfd8734441397d9@mail.gmail.com>
References: <513ca40e0909170301s2b09184akb27acde76975c09b@mail.gmail.com>
	 <vpqy6odhn0d.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Sep 20 04:22:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpC4c-0004tx-7X
	for gcvg-git-2@lo.gmane.org; Sun, 20 Sep 2009 04:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589AbZITCVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Sep 2009 22:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753533AbZITCVg
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Sep 2009 22:21:36 -0400
Received: from mail-yx0-f199.google.com ([209.85.210.199]:33482 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504AbZITCVf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Sep 2009 22:21:35 -0400
Received: by yxe37 with SMTP id 37so2119200yxe.33
        for <git@vger.kernel.org>; Sat, 19 Sep 2009 19:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type;
        bh=aflXP69280srIXzXzUM8bzPsu/Xh00HJ0j1G1PweBcY=;
        b=Zv67YKrThzbVnbOwbD8TPtpi6VS/r+3hEznRKM6hvD8Tq2NTgS6YNl/5iXYo3W51CU
         lO8zxnrsq/FKkIO3c9Dka3C+W6p9O2nb4WyWllwRDuis4xrgIjIETxEE9fIdiVYVgWP5
         xk3Ot7CzpvylWeAL6IIjmv6mHWdb27woX2/TA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=rRPELm2hDy7qX15OjiEqJXcxI3gJ3o/5a0YTaicddFIxPz6Taww+uXcZxOVC4xh3jr
         BTuJM/EO+jhUXcFtswKSOOJ2fWsY6qG4rOGlOflN0C5ZuTGPUBn7DYswOLrrWzLA43Mz
         5R75glNBkWkifskr5umvkSXP9t8YDKWtelJdw=
Received: by 10.150.128.18 with SMTP id a18mr5867737ybd.244.1253413298980; 
	Sat, 19 Sep 2009 19:21:38 -0700 (PDT)
In-Reply-To: <vpqy6odhn0d.fsf@bauges.imag.fr>
X-Google-Sender-Auth: c2619d8699e4956d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128835>

On Thu, Sep 17, 2009 at 8:41 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Well, if you want to get rid of subcommands, why not get rid of
> commands, too?
>
> git --commit
> git --status
> git --svn --rebase
>

Well, granted, that's a sort of heavyweight consistency, but all we
should need to do is to help reduce a _new_ user's confusion about
when the word after a subcommand gets a '--' prefix and when it
doesn't.

And do it in a way that's backwards compatible so it doesn't affect
the usage patterns of seasoned users, existing scripts, crons etc.

Will patch and see how it looks..

Rob
