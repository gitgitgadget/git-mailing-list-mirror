From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: [PATCH 0/3] Reduced re-roll of http-proxy-more branch
Date: Fri, 11 May 2012 15:13:25 +0200
Message-ID: <4FAD1075.8020309@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 14:18:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSonU-0002j3-ND
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 14:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758156Ab2EKMSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 08:18:01 -0400
Received: from luthien2.mpt.es ([213.9.211.102]:44168 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758128Ab2EKMR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 08:17:58 -0400
Received: from correo.map.es (unknown [10.1.24.76])
	by luthien2.map.es (Postfix) with ESMTP id A5465377CE;
	Fri, 11 May 2012 14:16:16 +0200 (CEST)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id 1C1D42C3CF;
	Fri, 11 May 2012 14:16:11 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120424 Thunderbird/12.0
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: A5465377CE.379C7
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1337343382.75925@ZldYWu7P8ck6Cae5+zLXGA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197668>

Hi, based on last feedback by Junio and Jeff I've created this
reduced version of http-proxy-more branch with all the bits
about "reading proxy from environment" removed. When cURL adds
the new api we will only need to expand the code introduced by
commit 1/3 .

Regards,

Nelson Benitez Leon (3):
  http: handle proxy authentication failure (error 407)
  http: Avoid limit of retrying request only twice
  http: rename HTTP_REAUTH to HTTP_AUTH_RETRY

 http.c |   37 ++++++++++++++++++++++++++++++++-----
 http.h |    2 +-
 2 files changed, 33 insertions(+), 6 deletions(-)

-- 
1.7.7.6
