From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: http-smart-backend: can clone, cannot push
Date: Tue, 1 Jun 2010 23:40:32 +0800
Message-ID: <AANLkTin43VO3FA9dEjAx9w6FRwLK7FpqqO5rA6wKFZgn@mail.gmail.com>
References: <E66CC81A-CCED-4D8E-AE7C-C02FB0AF6F6C@pelagicore.com>
	<AANLkTimqncJ7aqi_0AvjNimyIPsbVN1zSkAQ1LrPhwne@mail.gmail.com>
	<B61D22CA-45BA-49DA-984B-A7F7090FAE55@pelagicore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeremiah Foster <jeremiah.foster@pelagicore.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 17:40:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJTa4-0001DU-8X
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 17:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101Ab0FAPkf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 11:40:35 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:61691 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757023Ab0FAPke convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jun 2010 11:40:34 -0400
Received: by pvg11 with SMTP id 11so1840859pvg.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 08:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=khwCnWmQNKSLPm1Rtk5oFEqOgCI1FzUrL/1aIXDrCS8=;
        b=ACf+bVhXLdN5j6X0tNlaCXmZG9kQFBupuPAvf+Ilvd1Xt06PNr8CXn4Vi3QrPfhLFU
         i4jSqOXvGZmmd5PWoCuvXWTP90pBjshGLkAko69kjQ9kwuHLSFZPv5Y0iaKjNlAHLarq
         c2+kXpyMAcpsenKn/Gm9XGKQcb3zTK8rulARU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wyCvDiKGFAozNZXBWeyNCobFv2tZ3D7T0J6popm9rDwi4fuu4uxo9LqxuM3Pw+HQrQ
         gU0XsfzRYbX2N13FzRceyrW6bV/5ObySHe4yQzM5zOREggdrTrQAgWN6cJd1mfqyY93d
         Rm9O3nRj+KA3wZibnxU7+o6ulGtrDzjIsn9Ho=
Received: by 10.142.66.12 with SMTP id o12mr4322088wfa.197.1275406832661; Tue, 
	01 Jun 2010 08:40:32 -0700 (PDT)
Received: by 10.231.37.131 with HTTP; Tue, 1 Jun 2010 08:40:32 -0700 (PDT)
In-Reply-To: <B61D22CA-45BA-49DA-984B-A7F7090FAE55@pelagicore.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148129>

Hi,

On Tue, Jun 1, 2010 at 11:24 PM, Jeremiah Foster
<jeremiah.foster@pelagicore.com> wrote:
> =A0 GIT_CURL_VERBOSE=3D1 git push origin master
> * About to connect() to git.pelagicore.net port 443 (#0)
> * =A0 Trying 109.74.195.212... * connected
> * Connected to git.pelagicore.net (109.74.195.212) port 443 (#0)
> * found 142 certificates in /etc/ssl/certs/ca-certificates.crt
> * =A0 =A0 =A0 =A0server certificate verification SKIPPED
> * =A0 =A0 =A0 =A0common name: www.pelagicore.net (does not match 'git=
=2Epelagicore.net')
> * =A0 =A0 =A0 =A0server certificate expiration date OK
> * =A0 =A0 =A0 =A0server certificate activation date OK
> * =A0 =A0 =A0 =A0certificate public key: RSA
> * =A0 =A0 =A0 =A0certificate version: #1
> * =A0 =A0 =A0 =A0subject: CN=3Dwww.pelagicore.net
> * =A0 =A0 =A0 =A0start date: Mon, 08 Feb 2010 13:49:15 GMT
> * =A0 =A0 =A0 =A0expire date: Thu, 06 Feb 2020 13:49:15 GMT
> * =A0 =A0 =A0 =A0issuer: CN=3Dwww.pelagicore.net
> * =A0 =A0 =A0 =A0compression: NULL
> * =A0 =A0 =A0 =A0cipher: AES-128-CBC
> * =A0 =A0 =A0 =A0MAC: SHA1
>> GET /var/www/git/administrivia.git/info/refs?service=3Dgit-receive-p=
ack HTTP/1.1
> User-Agent: git/1.7.1
> Host: git.pelagicore.net
> Accept: */*
> Pragma: no-cache
>
> * The requested URL returned error: 403

You're getting a 403 Forbidden here. What authentication method were
you expecting?

=46YI, after this, the requests show that git is falling back to the
"dumb"/WebDAV protocol, which the server doesn't seem to support.

--=20
Cheers,
Ray Chuan
