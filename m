From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: [PATCH v2 0/3] http: proxy support improvements
Date: Thu, 01 Mar 2012 19:16:20 +0100
Message-ID: <4F4FBCF4.8010306@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, sam@vilain.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 18:18:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S39dp-0004Dh-1r
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 18:18:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754076Ab2CARR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 12:17:59 -0500
Received: from luthien1.map.es ([213.9.211.102]:50824 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753751Ab2CARR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 12:17:57 -0500
Received: from correo.map.es (unknown [10.1.24.76])
	by luthien2.map.es (Postfix) with ESMTP id 37DDAB6F34;
	Thu,  1 Mar 2012 18:17:42 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.79])
	by correo.map.es (Postfix) with ESMTP id 5D3482C630;
	Thu,  1 Mar 2012 18:17:37 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 37DDAB6F34.588B6
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1331227063.00033@UEOBO6tVozsuedZvg/11Wg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191947>

So here is v2 of proxy authentication support patch-set,
the following modifications were done as per discussion:

- PATCH 1/1: Extended commit message

- PATCH 2/2: Extended commit message and only read http_proxy
(discard HTTP_PROXY).

- PATCH 3/3: Extended commit message and use credential api for
retrieving password from user, taking care we only ask it once
for multiple curl handles case.

Nelson Benitez Leon (3):
  http: authenticate on NTLM proxies and others suppported by CuRL
  http: try http_proxy env var when http.proxy config option is not set
  http: when proxy url has username but no password, ask for password

 http.c |   27 +++++++++++++++++++++++++--
 1 files changed, 25 insertions(+), 2 deletions(-)

-- 
1.7.7.6
