From: Nate Parsons <parsons.nate@gmail.com>
Subject: Unable to make git with https support
Date: Wed, 7 Mar 2012 14:52:13 -0500
Message-ID: <CADjGbJq_HL--_CAuE_Yj3B0srx=WDficot8bgadvW92zz9PJdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 07 20:52:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5Muk-0000dW-KR
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 20:52:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030558Ab2CGTwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 14:52:43 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39043 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030495Ab2CGTwe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 14:52:34 -0500
Received: by bkcik5 with SMTP id ik5so5585946bkc.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 11:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=X72kz2fY7HYTsg1ydezVAB332XDtootJmKsQCgCR5sU=;
        b=qJOU+oGxkHtoRRh9CD1vaIlwELnkXl9jqH2ouO+7fpkV8UGXoEEBoizHf6hMMKdugY
         B9IQgEFle7bovBjfrE/e3nAtuxod6n7IZUvnmPHaOtTarZQyC/DR4WRZuK/PKPevIfTK
         pqwVJbC/Jnlal7wdxO4Yp3NbUtjVqjgIgLL6YFZv3fiXSGVFscuWB4p1y0cB3jJr1WyU
         V6rqTTNN6JximN61PfsgxNT5jsPu+oxeVC709pWd39ZJewWSiBeY1z3HCDQUMxqyTZRh
         1Fq4nh32NkDgKOn8BbgTfn66QdoLb/D5AGQRJ63Xt8vSXOGdB596AY0KJtNSjljE84gD
         Ny1Q==
Received: by 10.204.141.8 with SMTP id k8mr1568555bku.24.1331149953421; Wed,
 07 Mar 2012 11:52:33 -0800 (PST)
Received: by 10.204.168.81 with HTTP; Wed, 7 Mar 2012 11:52:13 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192475>

I'm trying to make git for myself, but can't seem to get https
working. This is what I did to make it:

> wget http://git-core.googlecode.com/files/git-1.7.9.3.tar.gz
> tar -xf git-1.7.9.3.tar.gz
> cd git-1.7.9.3.tar.gz
> ./configure --with-curl --prefix=$HOME
> make
> make install

In a new shell

> git clone https://github.com/git/git.git
Cloning into 'git'...
fatal: Unable to find remote helper for 'https'

But my machine does have curl, and that curl can access https urls

> which curl
/usr/bin/curl
> curl --version
curl 7.19.0 (x86_64-suse-linux-gnu) libcurl/7.19.0 OpenSSL/0.9.8h
zlib/1.2.3 libidn/1.10
Protocols: tftp ftp telnet dict ldap http file https ftps
Features: GSS-Negotiate IDN IPv6 Largefile NTLM SSL libz
> curl https://github.com/git/git.git
<GitHub 404 page, no https error message>

Thanks, Nate
