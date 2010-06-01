From: Jeremiah Foster <jeremiah.foster@pelagicore.com>
Subject: Re: http-smart-backend: can clone, cannot push
Date: Tue, 1 Jun 2010 17:24:25 +0200
Message-ID: <B61D22CA-45BA-49DA-984B-A7F7090FAE55@pelagicore.com>
References: <E66CC81A-CCED-4D8E-AE7C-C02FB0AF6F6C@pelagicore.com> <AANLkTimqncJ7aqi_0AvjNimyIPsbVN1zSkAQ1LrPhwne@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 01 17:24:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJTKW-0004lg-KB
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 17:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756691Ab0FAPYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 11:24:31 -0400
Received: from av9-2-sn2.hy.skanova.net ([81.228.8.180]:33348 "EHLO
	av9-2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756382Ab0FAPYb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jun 2010 11:24:31 -0400
Received: by av9-2-sn2.hy.skanova.net (Postfix, from userid 502)
	id 73FD037EE7; Tue,  1 Jun 2010 17:24:29 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av9-2-sn2.hy.skanova.net (Postfix) with ESMTP id 434E537E7C
	for <git@vger.kernel.org>; Tue,  1 Jun 2010 17:24:29 +0200 (CEST)
Received: from [10.8.36.139] (194-237-7-146.customer.telia.com [194.237.7.146])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id 3631137E45
	for <git@vger.kernel.org>; Tue,  1 Jun 2010 17:24:29 +0200 (CEST)
In-Reply-To: <AANLkTimqncJ7aqi_0AvjNimyIPsbVN1zSkAQ1LrPhwne@mail.gmail.com>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148126>


On Jun 1, 2010, at 15:15, Tay Ray Chuan wrote:

> On Tue, Jun 1, 2010 at 8:28 PM, Jeremiah Foster
> <jeremiah.foster@pelagicore.com> wrote:
>>        I cannot push however. This is what git says:
>> 
>>        $ ~/administrivia >  git push origin master
>>        error: Cannot access URL https://git.pelagicore.net/var/www/git/administrivia.git/, return code 22
>>        fatal: git-http-push failed
> 
> Can you paste the output for
> 
>  $ GIT_CURL_VERBOSE=1 git push origin master

This is the output :

   GIT_CURL_VERBOSE=1 git push origin master
* About to connect() to git.pelagicore.net port 443 (#0)
*   Trying 109.74.195.212... * connected
* Connected to git.pelagicore.net (109.74.195.212) port 443 (#0)
* found 142 certificates in /etc/ssl/certs/ca-certificates.crt
*        server certificate verification SKIPPED
*        common name: www.pelagicore.net (does not match 'git.pelagicore.net')
*        server certificate expiration date OK
*        server certificate activation date OK
*        certificate public key: RSA
*        certificate version: #1
*        subject: CN=www.pelagicore.net
*        start date: Mon, 08 Feb 2010 13:49:15 GMT
*        expire date: Thu, 06 Feb 2020 13:49:15 GMT
*        issuer: CN=www.pelagicore.net
*        compression: NULL
*        cipher: AES-128-CBC
*        MAC: SHA1
> GET /var/www/git/administrivia.git/info/refs?service=git-receive-pack HTTP/1.1
User-Agent: git/1.7.1
Host: git.pelagicore.net
Accept: */*
Pragma: no-cache

* The requested URL returned error: 403
* Closing connection #0
* About to connect() to git.pelagicore.net port 443 (#0)
*   Trying 109.74.195.212... * connected
* Connected to git.pelagicore.net (109.74.195.212) port 443 (#0)
* found 142 certificates in /etc/ssl/certs/ca-certificates.crt
* SSL re-using session ID
*        server certificate verification SKIPPED
*        common name: www.pelagicore.net (does not match 'git.pelagicore.net')
*        server certificate expiration date OK
*        server certificate activation date OK
*        certificate public key: RSA
*        certificate version: #1
*        subject: CN=www.pelagicore.net
*        start date: Mon, 08 Feb 2010 13:49:15 GMT
*        expire date: Thu, 06 Feb 2020 13:49:15 GMT
*        issuer: CN=www.pelagicore.net
*        compression: NULL
*        cipher: AES-128-CBC
*        MAC: SHA1
> GET /var/www/git/administrivia.git/info/refs HTTP/1.1
User-Agent: git/1.7.1
Host: git.pelagicore.net
Accept: */*
Pragma: no-cache

< HTTP/1.1 200 OK
< Date: Tue, 01 Jun 2010 13:41:02 GMT
< Server: Apache/2.2.15 (Debian)
< Expires: Fri, 01 Jan 1980 00:00:00 GMT
< Pragma: no-cache
< Cache-Control: no-cache, max-age=0, must-revalidate
< Content-Length: 59
< Vary: Accept-Encoding
< Content-Type: text/plain
< 
* Connection #0 to host git.pelagicore.net left intact
* Re-using existing connection! (#0) with host git.pelagicore.net
* Connected to git.pelagicore.net (109.74.195.212) port 443 (#0)
> GET /var/www/git/administrivia.git/HEAD HTTP/1.1
User-Agent: git/1.7.1
Host: git.pelagicore.net
Accept: */*
Pragma: no-cache

< HTTP/1.1 200 OK
< Date: Tue, 01 Jun 2010 13:41:03 GMT
< Server: Apache/2.2.15 (Debian)
< Expires: Fri, 01 Jan 1980 00:00:00 GMT
< Pragma: no-cache
< Cache-Control: no-cache, max-age=0, must-revalidate
< Content-Length: 23
< Last-Modified: Tue, 01 Jun 2010 08:29:13 GMT
< Vary: Accept-Encoding
< Content-Type: text/plain
< 
* Connection #0 to host git.pelagicore.net left intact
* About to connect() to git.pelagicore.net port 443 (#0)
*   Trying 109.74.195.212... * connected
* Connected to git.pelagicore.net (109.74.195.212) port 443 (#0)
* found 142 certificates in /etc/ssl/certs/ca-certificates.crt
*        server certificate verification SKIPPED
*        common name: www.pelagicore.net (does not match 'git.pelagicore.net')
*        server certificate expiration date OK
*        server certificate activation date OK
*        certificate public key: RSA
*        certificate version: #1
*        subject: CN=www.pelagicore.net
*        start date: Mon, 08 Feb 2010 13:49:15 GMT
*        expire date: Thu, 06 Feb 2020 13:49:15 GMT
*        issuer: CN=www.pelagicore.net
*        compression: NULL
*        cipher: AES-128-CBC
*        MAC: SHA1
> PROPFIND /var/www/git/administrivia.git/ HTTP/1.1
User-Agent: git/1.7.1
Host: git.pelagicore.net
Accept: */*
Depth: 0
Content-Type: text/xml
Content-Length: 187
Expect: 100-continue

< HTTP/1.1 100 Continue
* The requested URL returned error: 404
* Closing connection #0
error: Cannot access URL https://git.pelagicore.net/var/www/git/administrivia.git/, return code 22
fatal: git-http-push failed
