From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git doc build failure on OS X 10.5.6 (Leopard) during xmlto phase
Date: Wed, 11 Mar 2009 11:12:01 -0400
Message-ID: <76718490903110812t5e1723ebi28a84da680422d8a@mail.gmail.com>
References: <5e68abd90903110721o414283a4te188b58e0e4df8ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tom Holaday <tlholaday@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 16:14:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhQ7j-0008PH-Sa
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 16:13:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753651AbZCKPMH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Mar 2009 11:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752247AbZCKPMF
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 11:12:05 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:58838 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089AbZCKPMD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2009 11:12:03 -0400
Received: by rv-out-0506.google.com with SMTP id g37so45389rvb.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 08:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2q7BzN8HvAH5oBHpvdxW2knhB7gbUhEaPX69r8Vn2Z4=;
        b=kDTmKO5qcCjpvFV6Dn11J5nh0uQjfEIlJC6aElBicWvPhBF6TZDUf0bnn/DUxxt3/f
         US643+5qE99ngMsFLNHumo/9sWVngJEXYB9SITHr+vI6S4VhsDy6mC6zQ/kg6ca+Hyto
         h9XURfHmfVW7jzwzIqMaomyE0brefOGyDedD0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DKPu3y0U6BggmE8ansZsga64tL8qyPxYb+Nagg8m4Bbt/jKvsWjJ9+Q0diKsxq/yRz
         tPMriC0XpAZ+uVOvuuZcyUGpebK+M5b2ymkxdA9aqtxi0H1psIc9oYnUyM1zMQ/sllHx
         k+iMlnZIoJmXOTcJ997iUTm21uS+c3jo2F0S0=
Received: by 10.141.195.9 with SMTP id x9mr4419290rvp.216.1236784321737; Wed, 
	11 Mar 2009 08:12:01 -0700 (PDT)
In-Reply-To: <5e68abd90903110721o414283a4te188b58e0e4df8ad@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112936>

On Wed, Mar 11, 2009 at 10:21 AM, Tom Holaday <tlholaday@gmail.com> wro=
te:
> Hello,
>
> On OS X 10.5.6 (Leopard), the command ...
>
> =C2=A0 xmlto -m callouts.xsl man git-filter-branch.xml
>
> ... terminates with these errors:

Assuming you're using the MacPorts asciidoc, to build on OS X you need:

  export ASCIIDOC8=3DYesPlease
  export DOCBOOK_XSL_172=3DYesPlease

And your man pages still won't be perfect. Preformatted text will look
like this:

  .ft C
          ...
  .ft

I haven't had a chance to track down what is causing this. If you
build and install the html pages and use "help -w" those are formatted
fine. You may just want to install the prebuilt man-pages
(quick-install-doc or quick-install-man).

j.
