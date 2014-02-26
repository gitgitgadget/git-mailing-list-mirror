From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Compiling git for Windows
Date: Wed, 26 Feb 2014 12:23:35 -0600
Message-ID: <CAHd499Cr2g0MZs2XBCC-zZqjHeffqO0LXoP1ViaFOjQhTuPKzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 26 19:23:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIj8y-0006kk-Hx
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 19:23:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932AbaBZSXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 13:23:37 -0500
Received: from mail-ve0-f182.google.com ([209.85.128.182]:33463 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986AbaBZSXg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 13:23:36 -0500
Received: by mail-ve0-f182.google.com with SMTP id jy13so2679641veb.27
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 10:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=noZXG6xy/L3gtKe04es0TXc8k+7juelOpH1VUJ544qg=;
        b=dcjRSgs2EpW7CD6zdsqZSi7ANl8Ck3q469vBRM5h9RTFyCaUaipzp4STvvF1UdNwp2
         a3ykg+2yzYlyToi6DH7GbnFBDBWDn4oUBI7gGRGtBY5nTTOy74E25gk4MuCGM4jA0eOn
         bR3ox7ccN0t8tV++/mGk+vNTfUmBEVBwfFh1EDFkcwsmxR5VeB//AebvVDvjEjvwBiXb
         JPICma/69eMOto9oOcwV0SgBa174s6DotktYuE1lCL709Wd7ru3kKLI7B0jIjTcy/3sy
         BhBDZEvytGEwVkPz2c+WTScdRdkaPMlVRQkaFv/KsqzT19QJHKbGFkd//gojByhfEzem
         g1VQ==
X-Received: by 10.52.190.1 with SMTP id gm1mr5852393vdc.21.1393439015742; Wed,
 26 Feb 2014 10:23:35 -0800 (PST)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.221.49.68 with HTTP; Wed, 26 Feb 2014 10:23:35 -0800 (PST)
X-Google-Sender-Auth: sLY0WJ80IfJuVb2q3t6P7ATVzG8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242745>

Oddly I'm not able to find any instructions on how to build Git for
Windows. I've done a clone of the repository here:

https://github.com/msysgit/git

I did attempt to try doing it myself. I installed 'make' and mingw-gcc
in Cygwin and attempted 'make' from the git directory but it fails
immediately (I can post information on the failure if needed, but I'm
assuming I'm not taking the correct approach).

Can someone point me to some instructions on how to build Git for
Windows? Thanks.
