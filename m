From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: Native Windows implementation of GIT ?
Date: Fri, 12 Jun 2009 23:12:03 +0100
Message-ID: <3f4fd2640906121512rdede623k7d08ef9785b8bc5a@mail.gmail.com>
References: <2A554044B82841D594338E2E096804BC@HPLAPTOP>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Aaron Gray <aaronngray.lists@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 00:12:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFEzb-00076q-5m
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 00:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764702AbZFLWMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 18:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760857AbZFLWME
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 18:12:04 -0400
Received: from mail-qy0-f177.google.com ([209.85.221.177]:32860 "EHLO
	mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760125AbZFLWMB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 18:12:01 -0400
Received: by qyk7 with SMTP id 7so364010qyk.33
        for <git@vger.kernel.org>; Fri, 12 Jun 2009 15:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LP2WDOTuj34ulMSRkda4k4eDrMdgg//M2FlTy1fjA0k=;
        b=rQAI2voWbzxDTlK7Sj4CLjOu/yXTXrpiLM6DnhuFR4f06pBXNfhr4byasSkg1JKrdi
         vey1bT5kXiXf/WzS0+PKqE7UoJQXc+pqR4yy3SVZ0Rz2ZGVlzzDj33Fbcz6GfyHE1khX
         il0vXqehzfE7x8hD/jqqOHHwY31AvBjnRUiPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CHmFRO6XDNdl0cRiiK1jwddKtFfu63tcd4qVlbXRBAbBAN+hnpPlndT9tWsPdMJCVe
         QfqL3dVfxOJ07eqfAQkZ6K9s2aMAg7TewJd26U8hB6oD3eWpLnhreNbXteefYxjnXcgF
         H1mBEm6BWiXaVdnbClaFbZib/jZqtT9uLcwtI=
Received: by 10.220.92.212 with SMTP id s20mr3947620vcm.91.1244844723172; Fri, 
	12 Jun 2009 15:12:03 -0700 (PDT)
In-Reply-To: <2A554044B82841D594338E2E096804BC@HPLAPTOP>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121457>

2009/6/12 Aaron Gray <aaronngray.lists@googlemail.com>:
> Is there going to be a native Windows implementation of GIT ?
>
> i.e. not MSYS or Cygwin based.
>
> Many thanks in advance,

Cygwin is an adapter layer that maps posix calls to the Windows Win32
API, so is not a native implementation.

MSYS uses the MinGW (gcc) compiler uses the native Windows Win32 API,
so the MSYS version *is* native.

Unless by native you mean using Visual Studio?

- Reece
