From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH 3/3] The "curl" executable is no longer required
Date: Sun, 15 Jun 2008 20:59:08 +1000
Message-ID: <ee77f5c20806150359x2b0e0953l201ead934b3dbecd@mail.gmail.com>
References: <200806120920.31161.johan@herland.net>
	 <200806151216.01886.johan@herland.net>
	 <ee77f5c20806150352n6ccf00e9w8083a17d8c5c2326@mail.gmail.com>
	 <200806151255.41055.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johan Herland" <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 15 13:00:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7pxt-0007kd-0B
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 13:00:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756983AbYFOK7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 06:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756697AbYFOK7K
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 06:59:10 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:38128 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756173AbYFOK7J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 06:59:09 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3083831fgg.17
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 03:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=iT1uSrcFuWU7H2A3Ds6PvMZQIq+bEtfCloHt1W1CzqE=;
        b=c8JVWsw5BRaRq6nhE7n5ialceIMfQdp7hZ6jjSV/8cvW/gQeE1wQSGmqbAV9PCJ/no
         qT9fWAxGC59Sb6pqLnnR4xiaiIk3J6fJLnwJKeC8HaWIVpW81ZuN7O+rwf0000oowGE4
         2zRn5X4ROqGU602DHYWF9daUpSiU1LLGHrofI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=J2RUIjF5MYXQ5dy9DsmcxuZkfjpcvbntzYXAx8nrP1IpsLtLU7yjM3mODChdAlTZr4
         skwOjF/S5BLdI4TCZUw6MRRweSiMT6e8nlfIb2fS7OoQ5SVnpRRwA/m/5S1d8yGe8tYE
         8Oquu6T39poZMgX/wTRiT5s96v2xhFjNXlEM0=
Received: by 10.86.89.1 with SMTP id m1mr6854878fgb.45.1213527548072;
        Sun, 15 Jun 2008 03:59:08 -0700 (PDT)
Received: by 10.86.74.8 with HTTP; Sun, 15 Jun 2008 03:59:08 -0700 (PDT)
In-Reply-To: <200806151255.41055.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85079>

On Sun, Jun 15, 2008 at 8:55 PM, Johan Herland <johan@herland.net> wrote:

> On Sunday 15 June 2008, David Symonds wrote:

>> Shouldn't libcurl still be listed as a requirement? Or is it statically
>> linked?
>
> 4 lines further up in git.spec.in:
>
> BuildRequires:  zlib-devel >= 1.2, openssl-devel, curl-devel, expat-devel,
> gettext  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}

So does a built RPM inherit that as a requirement? Just curious, since
I haven't touched RPMs for the better part of a decade.


Dave.
