From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: git only one file
Date: Tue, 25 Aug 2009 23:29:28 +0200
Message-ID: <1251235768-24921-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <synhedionn <synhedionn@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: synhedionn <synhedionn@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 25 23:29:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mg3aK-0005od-Kr
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 23:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756205AbZHYV3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 17:29:36 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756186AbZHYV3f
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 17:29:35 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:41877 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756167AbZHYV3f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 17:29:35 -0400
Received: by fxm17 with SMTP id 17so2478523fxm.37
        for <git@vger.kernel.org>; Tue, 25 Aug 2009 14:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=XH0lDXmyCqbMS3ANUe0ZLQYskbRYwqFoNjWoe+Mt6dc=;
        b=wtl4GXdbQZeuAzq2wBAztZGk9+GHEDN3Oh6TuUcl7OgjmR3KDpT7ABsztdMa/TWNpm
         h87rh86/X+C7zpaGaXmqf8jiQqEHD3Sg5TMYNCtqrQUzSs/8kXcOJOSxsABZfBdFG9aw
         9bEV4F3xgFvEY5vGsIsETmhT5dAQIQcDPEhWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EuHbgFhZUin/DWhusMcDt7Oa2UICRxjkJiet8Qdz23m4CkDs8eqoNXm1qMHeddnGju
         RQYsdtHWxacUFhdaf3uHIsUBjIYCg0r6wrHru3yMk4snKJsU5n9dotoXWEzZkC3WyE4H
         hiBdDeNg8fQ+Ic7bu2yKCrM1YZN7Lm5C3xygI=
Received: by 10.103.78.38 with SMTP id f38mr3026373mul.72.1251235774449;
        Tue, 25 Aug 2009 14:29:34 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-16-72.clienti.tiscali.it [94.37.16.72])
        by mx.google.com with ESMTPS id s11sm1121062mue.11.2009.08.25.14.29.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 25 Aug 2009 14:29:33 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.177.g695987
In-Reply-To: <synhedionn <synhedionn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127050>

synhedionn <synhedionn@gmail.com> wrote:

> with git add . =C2=A0, a directory is expected, but I don't need all =
my files to
> be recorded, only one of my thousands, so how can I record just 1 fil=
e?

Generally, if you want to track a single file in a directory you just
add that file, as per Matthias' suggestion, and possibly create a
=2Egitignore with the single '*' pattern in it..

<shameless plug>
However, if you want to track more than one _independent_ files in the
same directory (RCS-style), then I would recommend you look into zit,
the Git-based single-file content tracker I've developed. You can find
it at git://git.oblomov.eu/zit ( gitweb at http://git.oblomov.eu/zit )
</shameless plug>
