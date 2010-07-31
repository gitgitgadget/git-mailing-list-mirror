From: Bryan Donlan <bdonlan@gmail.com>
Subject: Re: On MacOS, 1.7.2, git svn clone seems to fail silently
Date: Fri, 30 Jul 2010 22:30:52 -0400
Message-ID: <AANLkTi=p92653sWGS4WDgpnXYD90_2-xLLJTTEMLsfvk@mail.gmail.com>
References: <AANLkTimxqC3oax=Q0EppAb-Q7AzHshRkV=H=6dJDNhqY@mail.gmail.com> 
	<20100731013509.GG5817@burratino> <AANLkTikwTqQpVO5SMUgqPr04=kAh570zT_RWdxjipid9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Benson Margulies <bimargulies@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 31 04:31:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of1r6-0005n5-Ll
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 04:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754475Ab0GaCbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 22:31:15 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60709 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717Ab0GaCbP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 22:31:15 -0400
Received: by wwj40 with SMTP id 40so2179685wwj.1
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 19:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=oJJzN4CZaOldl4mJ5T4cvwbj/I8NNsIO8L3Mk+OKXa8=;
        b=WCEPeOIdye7Io22yb8YTV5+Lfl3WMHfs/KehaUF6U3fZqylBduUm2oLct1Ifl9w2Dh
         Ysg7TdqZ48iNUkItya39B58Q+pOgxBMrvNQV3OZcNfWYN/glwAJqF2mfD5yGJlzgIqr6
         ZepXYHkQVvYkH7fhPWVUq5NI2zXQXDt6lPa54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=tsP8Y6Svb4/Ycj2A0XQZQakiVI8AGxcV3OOGzHPsZ2vPly4O/bTRq8j4ZEgb2/ueaH
         v5YdLkp8FpLxhDBcwKAwzlIb2RrAqLomyjhKdh46rnx61qgrp8TVvb8pPCzZAUevBi61
         VxycbIGedSTvE3IKvpjPgsWsHLhGN/yX2DOOw=
Received: by 10.216.144.22 with SMTP id m22mr334329wej.0.1280543473774; Fri, 
	30 Jul 2010 19:31:13 -0700 (PDT)
Received: by 10.216.187.13 with HTTP; Fri, 30 Jul 2010 19:30:52 -0700 (PDT)
In-Reply-To: <AANLkTikwTqQpVO5SMUgqPr04=kAh570zT_RWdxjipid9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152289>

On Fri, Jul 30, 2010 at 22:28, Benson Margulies <bimargulies@gmail.com> wrote:
> $? -> 0
>
> The numbers in tags-maxRev don't go up with each 'fetch'.

Are you fetching to an already-existing repo? If you are, and it fails
relatively quickly, it'd be helpful if you could upload the repo
somewhere, so people can quickly test things (when I reproduced the
bug on Linux on a new clone, it took tens of minutes before failing).
