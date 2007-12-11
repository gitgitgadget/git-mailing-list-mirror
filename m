From: "Jason Sewall" <jasonsewall@gmail.com>
Subject: Re: [ANNOUNCE] ugit: a pyqt-based git gui // was: Re: If you would write git from scratch now, what would you change?
Date: Tue, 11 Dec 2007 14:14:42 -0500
Message-ID: <31e9dd080712111114t2bbdba60m18b7d6210f3f9174@mail.gmail.com>
References: <402731c90712110548k67f28b64w5afa93ee908ce73b@mail.gmail.com>
	 <e5bfff550712111020k51829c03n5d64a94ce7c7ac2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: David <davvid@gmail.com>, "Andy Parkins" <andyparkins@gmail.com>,
	git@vger.kernel.org
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 20:15:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2AZy-0008Cj-Vp
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 20:15:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754816AbXLKTOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 14:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753555AbXLKTOo
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 14:14:44 -0500
Received: from an-out-0708.google.com ([209.85.132.242]:14049 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953AbXLKTOn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 14:14:43 -0500
Received: by an-out-0708.google.com with SMTP id d31so507136and
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 11:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=s/dkUs7vBguJbPKWUuvxCpddodvMYEcTNBiJklRDaPA=;
        b=RRGAQkGgDU8SadurLl5NiHPsIRn/JvVbkPfvv4LOogCL3dgR0SAURoq7/0Y/0QmHf/9+nx7HPVzuosDIjSlbwUOjwFvbg7k22Df2Sht1z8lSR+v8kCRIXy628qKctbHJSbHR1IQU8J9u5uMD+6xJqb6+B5Dmhi2kkg2KxXMCyr4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A12+owqN3aOX58RVBmOO8TU9BisfZ2/vCPBQG1iMU8hEcqLbSEDEZgV166e6U3IOmw/lM5f+zJh4v55vo+CWbSG1C9eWtJwdnC/4eKGoBKfyzx3E6rSrPLIRLY0zdTcHJhwFRTQ8Grzgfh3XunbaAbBwOmi7Hi3z1yKsvX9ndO8=
Received: by 10.101.66.14 with SMTP id t14mr18314749ank.1197400482064;
        Tue, 11 Dec 2007 11:14:42 -0800 (PST)
Received: by 10.101.66.17 with HTTP; Tue, 11 Dec 2007 11:14:42 -0800 (PST)
In-Reply-To: <e5bfff550712111020k51829c03n5d64a94ce7c7ac2a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67910>

On Dec 11, 2007 1:20 PM, Marco Costalba <mcostalba@gmail.com> wrote:
> Cannot start the thing...
>
> $ python bin/ugit.py
> Traceback (most recent call last):
>   File "bin/ugit.py", line 6, in <module>
>     from ugitlibs.models import GitModel
> ImportError: No module named ugitlibs.models
> $
>
> Some hints?

Where did you install it?

Because I had the same problem when I did
./configure
because it puts the python stuff in
/usr/local/python2.5/site-packages/... and python doesn't look there
by default.
./configure --prefix=/usr fixed that for me (and I'm sure there's a
way to tell python to look in /usr/local... too, but I can't be
bothered with that.

I re-installed without the prefix and that error disappeared, but now I get
Traceback (most recent call last):
  File "/usr/local/bin/ugit", line 12, in <module>
    view = GitView (app.activeWindow())
  File "../py/views.py", line 15, in __init__
  File "default/ui/Window.py", line 43, in setupUi
AttributeError: setLeftMargin

I'm too busy to poke around and see why that's happening, but
hopefully someone can.

This with Python 2.5.1 and PyQt4 4.2-8 (from an up-to-date Fedora 8 install)

Jason
