From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [ANNOUNCE] ugit: a pyqt-based git gui // was: Re: If you would write git from scratch now, what would you change?
Date: Tue, 11 Dec 2007 20:33:45 +0100
Message-ID: <e5bfff550712111133j66c4b9adx9f57661cc720aa41@mail.gmail.com>
References: <402731c90712110548k67f28b64w5afa93ee908ce73b@mail.gmail.com>
	 <e5bfff550712111020k51829c03n5d64a94ce7c7ac2a@mail.gmail.com>
	 <31e9dd080712111114t2bbdba60m18b7d6210f3f9174@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: David <davvid@gmail.com>, "Andy Parkins" <andyparkins@gmail.com>,
	git@vger.kernel.org
To: "Jason Sewall" <jasonsewall@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 20:34:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Aro-0007eq-Rn
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 20:34:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555AbXLKTdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 14:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753481AbXLKTdr
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 14:33:47 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:21062 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173AbXLKTdq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 14:33:46 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2145587rvb
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 11:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=l5FBm44RXzzdhhlSLELWS8YiPFP7Hd9GrGZkMI3nRAM=;
        b=W5Ztxli18bba3gT1e6CDsQ8PvMa4DcZuOTFaCMKZmtvGN+HoFo1T+r6v0WGoJxkllg7A9DBmQNb9VBhtoLPLHYky7NQKJLtoM22mjpLWshJ+cHuAf5gQT50ahT3X/gjZWDADqurwjV153C7JRA4ecwKastEiXxD/P8YzzV6RCAo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Pamu4ybvcyA7J/l2lpOMHMUXDnB3UajqHhtUaMJ0THRD+defA4jJyCjD+7BzLqL5p6LStRpBw0ulCCOU731WH3rMIb+ZtVnOzVBmUKXqIDHm8Am1JXYzpqgTuCEF2z4T3AOuhn8GeqOfIG37RgdiCN/CLw2TABum3NGNeYd8Xxc=
Received: by 10.141.145.11 with SMTP id x11mr5266368rvn.1197401625714;
        Tue, 11 Dec 2007 11:33:45 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Tue, 11 Dec 2007 11:33:45 -0800 (PST)
In-Reply-To: <31e9dd080712111114t2bbdba60m18b7d6210f3f9174@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67918>

On Dec 11, 2007 8:14 PM, Jason Sewall <jasonsewall@gmail.com> wrote:
> On Dec 11, 2007 1:20 PM, Marco Costalba <mcostalba@gmail.com> wrote:

> ./configure --prefix=/usr fixed that for me (and I'm sure there's a
> way to tell python to look in /usr/local... too, but I can't be
> bothered with that.
>

./configure --prefix=$HOME/bin

(half) worked thanks.



> I re-installed without the prefix and that error disappeared, but now I get
> Traceback (most recent call last):
>   File "/usr/local/bin/ugit", line 12, in <module>
>     view = GitView (app.activeWindow())
>   File "../py/views.py", line 15, in __init__
>   File "default/ui/Window.py", line 43, in setupUi
> AttributeError: setLeftMargin
>
> I'm too busy to poke around and see why that's happening, but
> hopefully someone can.
>

I have only $HOME/bin in path so I manually moved main 4 files and
directory ugitlibs under   bin/

$HOME/bin  -> ugit ugit.py uit.pyc ugit.pyo
                   -> ugitlibs/ -> with remaining files


And it worked.

Marco
