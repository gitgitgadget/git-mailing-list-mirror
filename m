From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Building Documentation in Cygwin
Date: Wed, 28 Jan 2009 00:32:05 +0800
Message-ID: <be6fef0d0901270832o1a176691nab5500a86c531795@mail.gmail.com>
References: <c115fd3c0901270741h2f213b99s31bac8829bd182c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 17:34:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRqsY-0000s7-LU
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 17:33:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753656AbZA0QcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 11:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753548AbZA0QcI
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 11:32:08 -0500
Received: from wf-out-1314.google.com ([209.85.200.171]:62777 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459AbZA0QcH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 11:32:07 -0500
Received: by wf-out-1314.google.com with SMTP id 27so7560226wfd.4
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 08:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yIZKPpWJ0YXVe0UrxWUPxeWDe0ig0KH23EJ+UvdBQh8=;
        b=vcfrV5H9fAZUeFxVPYD4oFYThn/yJuipGRqmTMMoF6r9vZ0uzIhkZaT489uckCkA3C
         h6rpZjw4O98U054+sBtrjg9DFgkn6ibMmMXK3FP/7Me+PK0mnKdoDUO3VzS7+gFEmwHM
         SpobV7feXCU6CrnQJiMPJZ0EACvy82orTMQ1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Dh2/l0ZgdkJB1vY/XZ4a+XdH50XvF6tvIRPXPHS04kgJzfe+6SnT+9Bm+u9NIMPUzX
         7x8HSvpur9TghQPUCS/fTVBD/eKoF8yy2zEnOxyI7nDZN7JFX+uCGThG5INx9gVLMUF5
         742gnp6QSuf7O41rsDcmDhpNtuG5fXN/ZVw28=
Received: by 10.114.157.1 with SMTP id f1mr2566054wae.43.1233073925821; Tue, 
	27 Jan 2009 08:32:05 -0800 (PST)
In-Reply-To: <c115fd3c0901270741h2f213b99s31bac8829bd182c2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107359>

Hi,

On Tue, Jan 27, 2009 at 11:41 PM, Tim Visher <tim.visher@gmail.com> wrote:
>    $ make install-man
>    rm -f doc.dep+ doc.dep
>    /usr/bin/perl ./build-docdep.perl >doc.dep+
>    mv doc.dep+ doc.dep
>    make -C ../ GIT-VERSION-FILE
>    make[1]: Entering directory `/cygdrive/c/Documents and
> Settings/tvishe01/Desktop/Projects/git'
>    make[1]: `GIT-VERSION-FILE' is up to date.
>    make[1]: Leaving directory `/cygdrive/c/Documents and
> Settings/tvishe01/Desktop/Projects/git'
>    make -C ../ GIT-VERSION-FILE
>    make[1]: Entering directory `/cygdrive/c/Documents and
> Settings/tvishe01/Desktop/Projects/git'
>    make[1]: `GIT-VERSION-FILE' is up to date.
>    make[1]: Leaving directory `/cygdrive/c/Documents and
> Settings/tvishe01/Desktop/Projects/git'
>    rm -f git-add.xml+ git-add.xml
>    asciidoc -b docbook -d manpage -f asciidoc.conf \
>                     -agit_version=1.6.1.1.230.gdfb04 -o git-add.xml+
> git-add.txt
>    mv git-add.xml+ git-add.xml
>    rm -f git-add.1
>    xmlto -m callouts.xsl man git-add.xml
>    xmlto: input does not validate (status 3)

hmm i tried running this and this rule passed for me.

try running xmlto in verbose, what does it output? here's mine:

---cut---

$ xmlto -v -m callouts.xsl man git-add.xml
Format script: /usr/share/xmlto/format/docbook/man
Convert to troff
Real stylesheet:
http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
xmllint >/dev/null --xinclude --postvalid
/cygdrive/g/temp/git/git/Documentation/git-add.xml
Stylesheet: /tmp/xmlto-xsl.nEUjsh
xsltproc --nonet --xinclude \
 -o /tmp/xmlto.MvioXw/git-add.proc \
 /tmp/xmlto-xsl.nEUjsh \
 /cygdrive/g/temp/git/git/Documentation/git-add.xml
Writing git-add.1 for refentry

---cut---

you might also want to try getting the cygwin package docbook-xml42.

-- 
Cheers,
Ray Chuan
