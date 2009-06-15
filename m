From: Karsten Weiss <knweiss@gmx.de>
Subject: Re: [PATCH 2/2] http.c: add http.sslCertType and http.sslKeyType
Date: Mon, 15 Jun 2009 19:43:52 +0200 (CEST)
Message-ID: <alpine.OSX.2.00.0906151927010.816@xor.localnet>
References: <1245033541-15558-1-git-send-email-lodatom@gmail.com> <1245033541-15558-2-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 19:44:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGGEk-0006Bx-UW
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 19:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762225AbZFORok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 13:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760318AbZFORoj
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 13:44:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:45859 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754462AbZFORoi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 13:44:38 -0400
Received: (qmail invoked by alias); 15 Jun 2009 17:44:39 -0000
Received: from port-92-200-94-69.dynamic.qsc.de (EHLO mail.localnet) [92.200.94.69]
  by mail.gmx.net (mp013) with SMTP; 15 Jun 2009 19:44:39 +0200
X-Authenticated: #3612999
X-Provags-ID: V01U2FsdGVkX1/AJbdjUtPAVTd5JQ4Er4084u3eLz4zwU407Hs8vH
	uWiS3tuOLyxoVZ
Received: by mail.localnet (Postfix, from userid 502)
	id 115F2B8B2F9; Mon, 15 Jun 2009 19:43:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.localnet (Postfix) with ESMTP id E1F33B8B2EA;
	Mon, 15 Jun 2009 19:43:52 +0200 (CEST)
In-Reply-To: <1245033541-15558-2-git-send-email-lodatom@gmail.com>
User-Agent: Alpine 2.00 (OSX 1167 2008-08-23)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121619>

Hi Mark!

On Sun, 14 Jun 2009, Mark Lodato wrote:

> Add two new configuration variables, http.sslCertType and
> http.sslKeyType, which tell libcurl the filetype for the SSL client
> certificate and private key, respectively.  The main benefit is to allow
> PKCS12 certificates for users with libcurl >= 7.13.0.

This is interesting. Thanks for working on that!

(However, it's a similar issue like the question whether the private key 
is encrypted or not: Usability would be better if the certificate type 
could be determined automatically (without having to violate the 
layering)).

>> +http.sslKeyType::
> +	Filetype for SSL private key.  Must be "PEM" (default), "DER", or
> +	(if libcurl >= 7.13.0) "P12".  Can be overridden by the
> +	'GIT_SSL_CERT_TYPE' environment variable.
                  ^^^^
                  KEY

Regards,
Karsten
