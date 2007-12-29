From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: NIST's policy: sha-1 until 2010, after 2010 sha-2.
Date: Sat, 29 Dec 2007 15:45:35 +1100
Message-ID: <ee77f5c20712282045ha230f42n3e68477229deb199@mail.gmail.com>
References: <998d0e4a0712282027y6e625141jcef90bd38fb83b75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "J.C. Pizarro" <jcpiza@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 05:46:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8TaE-0000hh-NE
	for gcvg-git-2@gmane.org; Sat, 29 Dec 2007 05:46:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599AbXL2Eph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2007 23:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753262AbXL2Eph
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Dec 2007 23:45:37 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:46564 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323AbXL2Epg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2007 23:45:36 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3689391rvb.1
        for <git@vger.kernel.org>; Fri, 28 Dec 2007 20:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Xb28iGlnpdpHvxPB3BHPk6ZCGC/ys4X7Tcwd7Cx22bo=;
        b=CigBQ12blbG5nA0A5ljGooUj5a92iiDYiRcGKGyo3M48uydiuHxyFqWSWSjnJNkbiRjg+aN9JYfhWw8WzC42D1os8e/QY8OsB+YJ+3L6id7GG7eoDxZdcTEl43/eT8d3ZfXhNkBSDPvmt6HMJJNtLDt2GCzqtTkX3xZWMurHWCw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OagPyDCv6z1ZT6EtfPXyHK28GFmbMZzShKQdLurLm/87ajmIkTQuk7gzHuaqaxUI7dln7qXSSqJEkClvRFEE9MQI8jissdPp/AzDhPWqFQeaBc4UaUxbk2P1/CSY/IyhnAw0PnAAyjO1TMSUQyClJaOAZ4lKvGeKUsb8DMceAKc=
Received: by 10.141.87.13 with SMTP id p13mr5213584rvl.55.1198903535267;
        Fri, 28 Dec 2007 20:45:35 -0800 (PST)
Received: by 10.141.115.4 with HTTP; Fri, 28 Dec 2007 20:45:35 -0800 (PST)
In-Reply-To: <998d0e4a0712282027y6e625141jcef90bd38fb83b75@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69309>

On Dec 29, 2007 3:27 PM, J.C. Pizarro <jcpiza@gmail.com> wrote:
> Dear Linus Torvalds,
>
> What do you think to do when your git has to change from SHA-1 to SHA-2
>   because of the weaker collision-resistance of SHA-1 in the next years?
>
>     (e.g. from an damn developer trying to commit a collisioned-SHA-1 file)

It's a non-issue. The closest-to-practical attack method on SHA-1 is a
collision-finding attack, not a second pre-image attack, which means
you can find two messages with the same hash. As far as I know,
there's no significant weakness known for finding a pre-image, which
would be the most practical way of weakening Git's "security" via
SHA-1 substitution.

Regardless, the use of SHA-1 in Git isn't primarily for security,
though it is a nice side-effect. The SHA-1 is there for reliability in
addressing and as a good hash.


Dave.
