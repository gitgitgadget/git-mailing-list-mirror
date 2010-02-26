From: Brent Payne <brent.payne@gmail.com>
Subject: Fwd: gitweb trouble on fedora
Date: Fri, 26 Feb 2010 13:32:03 -0800
Message-ID: <f71da3d1002261332s671d0010h7d196569ec8c911@mail.gmail.com>
References: <f71da3d1002261329o1ec140f0y9ad56a61b26ccbfc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 22:32:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nl7nL-00005S-0w
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 22:32:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966204Ab0BZVcJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Feb 2010 16:32:09 -0500
Received: from mail-qy0-f179.google.com ([209.85.221.179]:32787 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966182Ab0BZVcF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Feb 2010 16:32:05 -0500
Received: by qyk9 with SMTP id 9so326771qyk.5
        for <git@vger.kernel.org>; Fri, 26 Feb 2010 13:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=sIG2AdJju9qiHD4TL9iZdUBxGWtbX0GFqpRUHED72g4=;
        b=dhvZpowVO+jPP0TdxkHWQBvsAhYvgqu5Ho43j7DZ8knuViI9HwLIH+9BwTdAcIdFy4
         2FZvia7zbiULT53xSmz/7dLOTwNmwBZI6nBRo3yfH+coXdGLs0tJH/A5h/olSzSQTf7X
         GZidx/2DnqjPkLRc93fLTrjNDlzFCDzvnB5vQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=AzQvmtWn+/7xFsSylnfb2XgJECP83rwyh2ihYpxMghtjHZQHNBMwzOI5Pkfeh9fMbK
         JCVxmdOpVzfdaS9HQLIoqd5Hg8+etrrpjEOwKHwTZqk2x7m55aebjichhSibLQOl48Gl
         U9jvZnlIZqnhnl//CqTwpD6HL5BV1JQtPfdwQ=
Received: by 10.229.131.22 with SMTP id v22mr475599qcs.77.1267219924196; Fri, 
	26 Feb 2010 13:32:04 -0800 (PST)
In-Reply-To: <f71da3d1002261329o1ec140f0y9ad56a61b26ccbfc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141151>

plain text version

---------- Forwarded message ----------
=46rom: Brent Payne <brent.payne@gmail.com>
Date: Fri, Feb 26, 2010 at 1:29 PM
Subject: gitweb trouble on fedora
To: git@vger.kernel.org


I'm new to about everything, but I've hit my head on the wall for a
couple of hours, went through the gitweb README and INSTALL, online
tutorial, everything.

I am having trouble getting gitweb running on a fedora box with apache.

The apache error is
[Fri Feb 26 13:21:25 2010] [error] [client 127.0.0.1] [Fri Feb 26
13:21:25 2010] gitweb.cgi: Can't opendir(/var/cache/git): Permission
denied
[Fri Feb 26 13:21:25 2010] [error] [client 127.0.0.1] [Fri Feb 26
13:21:25 2010] gitweb.cgi:=A0 at /var/www/cgi-bin/gitweb.cgi line 2432


Can anyone guess at what I'm doing wrong?

Thanks,
Brent
