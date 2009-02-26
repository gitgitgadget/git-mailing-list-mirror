From: Tim Visher <tim.visher@gmail.com>
Subject: Building 1.6.2-rc2 in Cygwin
Date: Thu, 26 Feb 2009 10:23:54 -0500
Message-ID: <c115fd3c0902260723o4d475df5yecc9ff23c55c7af4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 16:25:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lci72-00022D-Jj
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 16:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431AbZBZPX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 10:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754295AbZBZPX4
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 10:23:56 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:63539 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754271AbZBZPX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 10:23:56 -0500
Received: by yx-out-2324.google.com with SMTP id 8so449371yxm.1
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 07:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=ptSkzOnPPbBAQd137N5+tjadpB0ibJAJnFwy0U8zmpU=;
        b=LrhNymqk32e+FCQpHi5X/Zd6t7nV6I7GiB3DN6PJ0gABjghdyUmJeyamdG5VxoQohm
         /J7z9H6wmHdXTWhjBx0RPnGmXcytyxXNt1mXRo/tQw/v7inp1NrwXfKK2EUkqLR4suJk
         PljKeB/+Oil6Bmnspe3qRROxTT0CEfqRYHuiI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=lEUtu3xERK5qnScOoq8eswPuO7ZsrTp1ysNCpYCx61qjf8ed4eWclUSRuHnlecNyOk
         G/Ue2sGAZ63MfT6e+T5YNDG5WCua3fZ3NUJZrzkF9MuOEOFUTVr97Ps6VNS+obPRb3NV
         Gcg3Q2N4XB5fiJ3IZnHJOZpTE8CTt5WgjJhS0=
Received: by 10.100.142.19 with SMTP id p19mr1632218and.3.1235661834390; Thu, 
	26 Feb 2009 07:23:54 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111573>

Hello Everyone,

This is somewhat related to my previous question about `configure`
ignoring `--XXdir=` options but it's different enough that I think it
warrants a new thread.

The reason I'm using `configure` at all is that when I simply do a
`make` without a `make configure; ./configure` first, it fails with a
message like:

    $ make
        CC fast-import.o
    In file included from builtin.h:4,
                     from fast-import.c:142:
    git-compat-util.h:100:19: iconv.h: No such file or directory
    make: *** [fast-import.o] Error 1

Once I configure, even without any options, it builds fine and I can
get my man pages (although I have to install them by hand).  I assume
this has something to do with cygwin's locations for header files and
such, but I have no real idea.  The first part of my question, then
would be what the issue is that I'm encountering when attempting to
build git in Cygwin?

My eventual goal is to have git installed with man, info, and html
pages, into my (and my fellow developers') personal bin, man, info,
and html directories at ~/x.  It appeared that I could do that with
./configure but per the response I got earlier, this doesn't seem to
be the case.

Second, I built and installed 1.6.2-rc2 and it still is claiming a
--version rc1.  I'm not sure if this is systemic or not, and obviously
it would be bad if it was just me as it means I'm doing something
wrong.

Thoughts?

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
