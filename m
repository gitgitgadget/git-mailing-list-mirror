From: John Benes <smartcat99s@gmail.com>
Subject: Re: gitweb - feature request
Date: Tue, 09 Aug 2005 15:51:37 -0500
Message-ID: <42F91759.8010008@gmail.com>
References: <20050809193104.GA10858@mars.ravnborg.org> <20050809195818.GA19284@vrfy.org> <20050809201836.GA11051@mars.ravnborg.org> <Pine.LNX.4.63.0508092224580.9849@wgmdd8.biozentrum.uni-wuerzburg.de> <20050809204347.GB11132@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Aug 09 22:53:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2b4r-0006Gq-5r
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 22:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbVHIUv5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Aug 2005 16:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbVHIUv5
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Aug 2005 16:51:57 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:37242 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964954AbVHIUv4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Aug 2005 16:51:56 -0400
Received: by rproxy.gmail.com with SMTP id i8so1152315rne
        for <git@vger.kernel.org>; Tue, 09 Aug 2005 13:51:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=JxN9LkGVJ5iy1DQ1D7qRUsgDcMmS9ixTeUYHy+ppGr/JWmANVsIaMox/uu19J0+YgyHH6mDWLlWAcZroo/PD1pT0zo/o59nq2/ZJBM7UAZZNSFyCAnWvE9fQBKWKiogW9VIk5R0pr9AMyystVIGOauhk9unaBlOxqazp+juNRM4=
Received: by 10.38.75.26 with SMTP id x26mr3053571rna;
        Tue, 09 Aug 2005 13:51:56 -0700 (PDT)
Received: from ?192.168.0.198? ([68.96.128.241])
        by mx.gmail.com with ESMTP id a2sm5455450rnf.2005.08.09.13.51.55;
        Tue, 09 Aug 2005 13:51:56 -0700 (PDT)
User-Agent: Thunderbird 1.0+ (Windows/20050809)
To: git@vger.kernel.org
In-Reply-To: <20050809204347.GB11132@mars.ravnborg.org>
X-Enigmail-Version: 0.92.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Sam Ravnborg wrote:
>> You have Firefox, don't you? Next time you surf to gitweb, right click on 
>> the funny yellow symbol in the lower right corner of your Firefox. It 
>> should say something like "Subscribe to...". Do it.
> 
> Unfortunately not on my firefox. 1.0.6 on gentoo.
> Puzzled...

I don't see it either with Firefox/1.0+ ID:2005080905.

For it to work, this code needs to be added to the HEAD (slightly modified)

<link rel="alternate" type="application/rss+xml" title="GIT Trees"
href="http://www.kernel.org/git/?a=opml" />

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBQvkXWGF0oWcU9kCNAQLNiA//aeblC39Vlc6z6e3GjG84+9V/vPcXjrE9
MdCllzb9D5aITJSWTxK7Ow5Y1nat0g9Cnf1AgrG6wPT6Uvm+7j61EqH5rcjYx/mU
kNe+251cHHBnGohdXyV4n20KCoEnXKZOQX7p7R3dJWifR4eyUzacSQiA51WmNPIl
vkV+JpTD6lPAIcZxJMXOJWUblaDA0reMPoCQ2nz7gqZOsQP7qWvzi0uyIAxjhaPd
AQ5UzEE9l9Wt5J7Oyx/ldz9i5e54EZxFgkaDWlLpDwVpUChmlVBx5V1ltTRh3Ymp
7lCPfy7JFN7eIQpAKp2/rldxvWK2gobSErTJR6nfs3ohSxe6WPLEpVS5Bfxrjo+8
a0LUOi/9E2+Kj1ja1Wf165GkQlI7ZfQgrmFRm8pVWS9WwkjlDvZbHjArv4lg6X6w
02yGuiyT2P0MIhia7SJF7xFM+lUi8mDdT/psnrZQ1++UhckuGPwWTa0EJ8nVWfk2
KkN3G3R1RVdSSgQSlh71ngNzwyFmxvMjHAZHB5ETtiO+/Of6TMkW+o3S8oJrbJSh
9M7WjDlKSUl7R3NcBE2iqx9NUyz7ldwPme+iG/w3aTAsvNaMOgjzsVloEosVeDIh
I/GOOujl+ym2IiJsAX9YRyaKmcBTZGEjfnUNWhf14hMDeM5fB5N8P6f+6JsMOB/N
s8U1L/LUiCc=
=ai+1
-----END PGP SIGNATURE-----
